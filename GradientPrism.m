classdef GradientPrism < Cube
    %GradientPrism : 其實是 Cube 的變體。有一個固定的厚度，強制調整法向量 (虛擬面方法)
    % 
    
    properties(SetAccess=protected, GetAccess=public)   % read only
        %% 整面資訊: 初始化時須完整定義 
        GPMode              % 0: no GP, 1: auto GP, 2: manual GP
        PRA                 
        size_hor            % 目前無作用
        size_ver            % 目前無作用
        % thickness         (使用者輸入) from Medium (prism_sub + prism_struct)
        % refractive_index  (使用者輸入) from Medium
        PBA_key                             
        autoGP
        manualGP
        PBA_list            % 不同 Lens Center 上的 PBA
        normal_list         % 不同 Lens Center 上的 PBA
        % order
        % z_top
        % z_bottom

        %% update when tracing
        PBA
        % normal_top        (使用者輸入) from Medium (已定義好) from Cube
        % normal_bottom     (使用者輸入) from Medium (已定義好) from Cube

        % useful
        rotPRA

    end
    
    methods
        function obj = GradientPrism(NameValueArgs,options)
            %GP Construct an instance of this class
            %   Detailed explanation goes here
            
            %% name-value pair 輸入
            arguments   % 使用者輸入
                NameValueArgs.GPMode
                NameValueArgs.PRA
                NameValueArgs.refractive_index
                NameValueArgs.thickness 
                NameValueArgs.PBA_key
                options.reversed = 1
                options.size_hor
                options.size_ver
                options.autoGP
                options.manualGP
                options.order
            end

            % 沒有任何輸入時 --> return 空物件 (不能使用 nargin ==)
            if isempty(fieldnames(NameValueArgs))
                obj.type = "GP";
                return
            end
            
            obj.GPMode = NameValueArgs.GPMode;
            obj.PRA = NameValueArgs.PRA;
            obj.refractive_index = NameValueArgs.refractive_index;
            obj.thickness = NameValueArgs.thickness;
            obj.PBA_key = NameValueArgs.PBA_key;

            if isfield(options,"size_hor"); obj.size_hor = options.size_hor;end
            if isfield(options,"size_ver"); obj.size_ver = options.size_ver;end
            if isfield(options,"autoGP"); obj.autoGP = options.autoGP;end
            if isfield(options,"manualGP"); obj.manualGP = options.manualGP;end

            %% optional 參數檢查
            if ~any(options.reversed == [1,0])
                error("[錯誤]: reversed 參數只能為 1 or 0 (系統停止)")
            end
            obj.reversed = options.reversed;
            if isfield(options,"order"); obj.order = options.order;end

            %% 覆蓋母類別
            obj.type = "GP";    % Cube 變體

            %% normal 決定
            
            %% useful
            obj.rotPRA = rotz(obj.PRA);

            %% GPMode update
            switch obj.GPMode
                case 0
                case 1  % autoGP
                    obj.set_autoGP(obj.autoGP)
                case 2  % manualGP
                    obj.set_manualGP(obj.manualGP)
            end
            
        end 
        function set_PRA(obj, value)
            obj.PRA = value;
            obj.rotPRA = rotz(value);
        end
        function set_autoGP(obj,autoGP)
            arguments 
                obj
                autoGP AutoGP
            end
            autoGP.update_autoGP(obj);
            obj.autoGP = autoGP;
        end
        function set_manualGP(obj,manualGP)
            arguments 
                obj
                manualGP ManualGP
            end
            manualGP.update_manualGP(obj);
            obj.manualGP = manualGP;
        end
        function deriveNormalList(obj,lens) % @ lens center 
            % prprocessing
            obj.PBA_list = cell(1,lens.number);
            obj.normal_list = cell(1,lens.number);
            switch obj.GPMode
                case 1  % autoGP
                    VEP = obj.autoGP.virtualEye; 
                    VEP_XY = VEP(1:2);
                    VEP_XY_equalto0 = norm(VEP_XY)==0;
                    PLAtoPBA = obj.autoGP.PLAtoPBAFunction;
                case 2  % manualGP
                    PBA_fit_length = obj.manualGP.LtoPBAFunction.fitLength;
                    PBA_fit_num = obj.manualGP.LtoPBAFunction.fitNum;
                    PBA_fit_line = obj.manualGP.LtoPBAFunction.fitLine;
                    PBA_fit_point = obj.manualGP.LtoPBAFunction.fitPoint;
            end
            
            % for loop: lens center
            segP = size(lens.center_list{1},2);
            for which_lens = 1: lens.number
                PBA_array = nan(1,segP);
                normal_array = nan(3,segP);
                for which_segP = 1:segP
                    lens_center = lens.center_list{which_lens}(:,which_segP);
                    if obj.GPMode == 1
                        % set: substrate top Z = 0
                        QP = [lens_center;0]; 
                        QV = VEP - QP; % query vector
                        if ~VEP_XY_equalto0
                            length_query = abs(lens_center'*VEP_XY-norm(VEP_XY)^2)/norm(VEP_XY); % 點到線距離
                            centerSide = -norm(VEP_XY)^2;
                            targetSide = lens_center'*VEP_XY - norm(VEP_XY)^2;
                            if centerSide*targetSide < 0;length_query = -length_query;end
                        elseif VEP_XY_equalto0 % 虛擬眼睛與面板中心重疊時
                            if obj.PRA == 0
                                length_query = -lens_center(1);
                            elseif obj.PRA ==90 || obj.PRA ==-90
                                length_query = -lens_center(2);
                            else
                                length_query = -lens_center(1)*cosd(obj.PRA);
                            end
                        end
                        PLA_desired = atand(length_query/QV(3));
                        PBA_desired = PLAtoPBA(PLA_desired);
                    elseif obj.GPMode == 2
                        if obj.PRA~=90 && obj.PRA~=-90
                            length_query = abs(lens_center(2)*sind(obj.PRA)+lens_center(1)*cosd(obj.PRA)+PBA_fit_length*0.5);
                        else
                            length_query = abs(lens_center(2) - (-sind(obj.PRA)*obj.size_ver*0.5));
                        end
                        whichpba = 1;
                        while 1 %找要代到哪一條線段
                            if whichpba == PBA_fit_num
                                error("[錯誤]: 手動 GP 未知錯誤，找不到要帶的 PBA。 (系統停止)")
                            end
                            % 該點位於面板外的情形
                            if length_query < PBA_fit_point(1,1)
                                PBA_desired = PBA_fit_line(1,1) * length_query + PBA_fit_line(2,1);
                                break
                            elseif length_query > PBA_fit_point(1,end)
                                PBA_desired = PBA_fit_line(1,end) * length_query + PBA_fit_line(2,end);
                                break
                            end
                            if PBA_fit_point(1,whichpba)<= length_query && PBA_fit_point(1,whichpba+1)>= length_query
                                PBA_desired = PBA_fit_line(1,whichpba) * length_query + PBA_fit_line(2,whichpba);
                                break
                            end
                            whichpba = whichpba + 1;
                        end    
                    elseif obj.GPMode == 0
                        PBA_desired = obj.PBA_key;
                    end
                    normal = [-sind(PBA_desired);0;-cosd(PBA_desired)]; % 出 Prism 斜面法向量  
                    normal = obj.rotPRA * normal; % 旋轉法向量
                    PBA_array(:,which_segP) = PBA_desired;
                    normal_array(:,which_segP) = normal;
                end
                obj.PBA_list{1,which_lens} = PBA_array;
                obj.normal_list{1,which_lens} = normal_array;
            end 
        end
    end
end