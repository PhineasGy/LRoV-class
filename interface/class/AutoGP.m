classdef AutoGP < handle & matlab.mixin.Copyable
    %AUTOGP Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(SetAccess=protected, GetAccess=public)   % read only
        % for PLAvsPBA: 需要 gp, medium_list
        % for virtual eye: 需要 gp, medium_list, PBA_center, WDGP
        
        % input
        gp              % GP 物件
        PBA_center
        medium_list     % 按照順序追跡
        WDGP
        medium_list_text
        % output
        PLAtoPBAFunction
        virtualEye
        PLA_center
    end
    
    methods
        function obj = AutoGP(NameValueArgs,options)
            %AUTOGP Construct an instance of this class
            %   Detailed explanation goes here
            %% name-value pair 輸入
            arguments   % 使用者輸入
                NameValueArgs.medium_list
                NameValueArgs.WDGP
                options.gp
                options.medium_list_text % for interface
            end
            
            obj.medium_list = NameValueArgs.medium_list;
            obj.WDGP = NameValueArgs.WDGP;
            if isfield(options,"gp");obj.gp = options.gp;end
            if isfield(options,"medium_list_text");obj.medium_list_text = options.medium_list_text;end
        end
        function update_autoGP(obj,gp)
            % 將 mediun_list 中 [] 替換為 gp
            obj.gp = gp;
            obj.medium_list{cellfun(@isempty,obj.medium_list)} = obj.gp;
            obj.PBA_center = obj.gp.PBA_key;

            % 更新 medium (normal 改為向上)
            cellfun(@inverse_normal,obj.medium_list);

            % derive output
            obj.derive_PLAtoPBAFunction
            obj.derive_virtualEye

            % 更新 medium (normal 改回向下)
            cellfun(@inverse_normal,obj.medium_list);
        end
        function derive_PLAtoPBAFunction(obj)
            % input
            medium_array = obj.medium_list;

            % get data from GP
            % obj.gp_copy;

            % parameter setup
            PBA_train = -90:0.01:90;
            PLA_train = nan(1,length(PBA_train));
            count = 0;
            
            %% tracing
            % ex: air --> GP --> air
            for PBA = PBA_train
                count = count + 1;
                % update PBA normal
                gp_normal = [sind(PBA);0;cosd(PBA)];    % 向上
                gp_normal = obj.gp.rotPRA * gp_normal;
                medium_array{cellfun('isclass',medium_array,'GradientPrism')}.force_normal(top_btm=obj.gp.reversed,normal=gp_normal);

                % Ray 物件
                R = Ray();              % 空物件 (snell 只需要 vector)
                R.set_vector([0;0;1]);  % 向上追跡 (垂直入射)
                for mm = 1: length(medium_array)-1
                    % snell's law
                    mediumA = medium_array{mm};
                    mediumB = medium_array{mm+1};
                    R.snell(mediumA,mediumB,0);
                end
                PLA = acosd(dot(R.uv,[0;0;1]));
                if R.uv(1) < 0; PLA = -PLA; end
                PLA_train(count) = PLA;
            end
            %% filt TIR
            PBA_train(imag(PLA_train)~=0) = [];
            PLA_train(imag(PLA_train)~=0) = [];
            PLA_array_fromPBA = PLA_train;
            PBA_array_forPLA = PBA_train;
            %% create function
            [PLA_train_sort,I] = sort(PLA_train);
            PBA_train_sort = PBA_train(I);

            obj.PLAtoPBAFunction = griddedInterpolant(PLA_train_sort,PBA_train_sort);
        end
        function derive_virtualEye(obj)
            % input
            medium_array = obj.medium_list;

            % get data from GP
            obj.gp;

            % parameter setup
            PBA = obj.PBA_center;
            
            %% tracing
            % ex: air --> GP --> air
            gp_normal = [sind(PBA);0;cosd(PBA)];    % 向上
            gp_normal = obj.gp.rotPRA * gp_normal;
            medium_array{cellfun('isclass',medium_array,'GradientPrism')}.force_normal(top_btm=obj.gp.reversed,normal=gp_normal);

            % Ray 物件
            R = Ray();              % 空物件 (snell 只需要 vector)
            R.set_vector([0;0;1]);  % 向上追跡 (垂直入射)
            for mm = 1: length(medium_array)-1
                % snell's law
                mediumA = medium_array{mm};
                mediumB = medium_array{mm+1};
                R.snell(mediumA,mediumB,0);
            end
            PLA = acosd(dot(R.uv,[0;0;1]));
            if R.uv(1) < 0; PLA = -PLA; end
            
            obj.PLA_center = PLA;
            % substrate top == 0    % ignore wedge
            obj.virtualEye = [0;0;0] + R.uv * (obj.WDGP*cosd(PLA)/R.uv(3)); 
        end
    end
end

