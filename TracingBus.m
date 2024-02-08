classdef TracingBus < handle & matlab.mixin.Copyable
    %TRACINGBUS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(SetAccess=protected, GetAccess=public)   % read only
        % input
        medium_train MediumTrain
        
        IPA_ind

        % 換算
        medium_noIPA
        medium_IPA
        medium_num
        lens_num
        auf_num
        segPoint_num

        % output: Point_Matrix (5-D) [auf x lens x seg x 2(左右 edge) x eye]
        RP
        RR
        systemTop         
    end
    
    methods
        function obj = TracingBus(medium_train,NameValueArgs)
            %TRACINGBUS Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                medium_train MediumTrain
                NameValueArgs.IPA = []
            end
            obj.medium_train = medium_train;  
            % 決定 數量, medium_IPA and medium_noIPA
            obj.derive_number
            obj.IPA_ind = NameValueArgs.IPA;
            obj.set_mediumList;
            % 建立 RP RR 矩陣 (座標)
            RP = cell(obj.auf_num,obj.lens_num,obj.segPoint_num,2,3);   % 2: two edge, 3: three eye
            RR = RP;
            ...
        end
        function derive_number(obj)
            medium_list = obj.medium_train.medium_list;
            obj.medium_num = length(medium_list);
            % 理論上 lens 會有兩層，取任意層均可
            lens = medium_list{cellfun(@isa,medium_list,repmat("Lens",[1,obj.medium_num]))};
            obj.lens_num = lens.number;
            obj.auf_num = size(lens.z_edge_list,1);
            obj.segPoint_num = size(lens.center_list{1},2);
        end
        function set_mediumList(obj)
            medium_list = obj.medium_train.medium_list;
            if ~isempty(obj.IPA_ind)
                obj.medium_IPA = medium_list(obj.IPA_ind);
                noIPA_ind = obj.IPA_ind(end):obj.medium_num;
                obj.medium_noIPA = medium_list(noIPA_ind);
            else
                obj.medium_noIPA = medium_list;
            end
        end
        function tracing(obj)
            
            %% 前置設定
            % 重新導向
            medium_list = obj.medium_train.medium_list;
            eye = obj.medium_train.eye;
            medium_top = medium_list{1};
            gp_layer_num = cellfun(@isa,medium_list,repmat("GradientPrism",[1,obj.medium_num]));
            gp = medium_list{gp_layer_num};
            layer_next2_gp = medium_list{find(gp_layer_num)+1};   % 要和 GP 一起改 normal
            switch gp.reversed
                case 1
                    gpnext_reversed = 0;
                case 0
                    gpnext_reversed = 1;
            end

            % 下面 lens 大部分情況是指 prism lens 間的 air
            lens = medium_list{cellfun(@isa,medium_list,repmat("Lens",[1,obj.medium_num]))};% 理論上會有兩層，取任意層均可
            % for normal update
            % lens_layer 通常為兩層
            lens_layer = medium_list(cellfun(@isa,medium_list,repmat("Lens",[1,obj.medium_num])));

            %% tracing loop
            for whichEye = eye.mode
                for whichLens = 1:obj.lens_num
                    for whichSeg = 1:obj.segPoint_num
                        %% update gp PBA --> normal
                        gp_normal = gp.normal_list{whichLens}(:,whichSeg);
                        gp.force_normal(top_btm=gp.reversed,normal=gp_normal);
                        % note: GP 接觸層也要改為此 normal
                        layer_next2_gp.force_normal(top_btm=gpnext_reversed,normal=gp_normal);
                        for whichAperture = 1:obj.auf_num
                            %% update "lens traveling z"
                            % z_traveling: 通常為 1x2 陣列 (兩層 Lens)
                            z_traveling = cellfun(@(X) X.z_traveling_list(whichAperture,whichLens), lens_layer);
                            cellfun(@set_z_traveling, lens_layer, num2cell(z_traveling))

                            for whichEdge = [-1 1]
                                %% update lens normal
                                switch whichEdge
                                    case -1
                                        lens_normal = lens.normal_list.left{whichAperture,whichLens};
                                    case 1
                                        lens_normal = lens.normal_list.right{whichAperture,whichLens};
                                end
                                cellfun(@set_normal,lens_layer,repmat({lens_normal},[1,length(lens_layer)]));
                                %% update eye
                                eye.set_now(whichEye,whichEdge);
                                %% update lens edge / pupil edge
                                switch whichEdge
                                    case -1
                                        point_lensEdge = [lens.edge_list_left{whichAperture,whichLens}(:,whichSeg);...
                                                            lens.z_edge_list(whichAperture,whichLens)];
                                    case 1
                                        point_lensEdge = [lens.edge_list_right{whichAperture,whichLens}(:,whichSeg);...
                                                            lens.z_edge_list(whichAperture,whichLens)];
                                end
                                point_pupilEdge = [eye.now;eye.z];
                                %% IPA tracing (if has)
                                if ~isempty(obj.IPA_ind)
                                    R = Ray();              % 空物件 (snell 只需要 vector)
                                    % 設定初始 Vector (必錯)
                                    pointA_initial = [point_lensEdge(1:2);medium_top.z_bottom]; % X Y 必錯
                                    R.set_vector(pointA_initial - point_pupilEdge)
                                    dev = [0,0,0]; % deviation 向量
                                    step = 0; % IPA Loop
                                    % 最終目標
                                    point_end = point_lensEdge;
                                    R_last_firstvector = R.vector;
                                    while 1
                                        % update R
                                        R.set_head(point_pupilEdge)
                                        % update vector
                                        R.set_vector(R_last_firstvector - [dev(1);dev(2);0])
                                        R_last_firstvector = R.vector;
                                        % update tail
                                        R.set_tail(R.point_head + R.vector)
                                        for mm = 1: length(obj.medium_IPA)-1
                                            % snell's law
                                            mediumA = obj.medium_IPA{mm};
                                            mediumB = obj.medium_IPA{mm+1};
                                            R.snell(mediumA,mediumB,1); % 1: 需要位置座標                                            
                                        end 
                                        dev = R.point_tail - point_end;
                                        if sqrt(dev(1)^2+dev(2)^2)<1e-6 %誤差越小越好 其值待商榷!
                                            break
                                        end
                                        step = step + 1;
                                    end
                                end
                                % 輸出 R (位於 lens prism 間空氣層
                                R;
                                %% no IPA 追跡
                                for mm = 1: length(obj.medium_noIPA)-1
                                    % snell's law
                                    mediumA = obj.medium_noIPA{mm};
                                    mediumB = obj.medium_noIPA{mm+1};
                                    R.snell(mediumA,mediumB,1); % 1: 需要位置座標
                                end
                                %% 賦值
                                switch whichEdge
                                    case -1
                                        edge_ind = 1;
                                    case 1
                                        edge_ind = 2;
                                end
                                obj.RP{whichAperture,whichLens,whichSeg,edge_ind,whichEye+2} = R.point_tail;
                            end
                        end
                    end
                end
            end
        end
    end
end