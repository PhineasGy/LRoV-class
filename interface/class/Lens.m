classdef Lens < Medium % 先執行 Medium 初始化 --> 執行 Lens 初始化
    %LENS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(SetAccess=protected, GetAccess=public)   % read only
        %% 整面資訊: 初始化時須完整定義 
        % type                  % 宣告時直接定義
        LRA                     % 使用者輸入
        size_hor                % 使用者輸入
        size_ver                % 使用者輸入
        pitch                   % 使用者輸入
        number                  % 間接: Lens 數量
        thickness_EI0           % 使用者輸入
        substrate_EI0           % 間接
        fullheight_EI0          % 間接
        % refractive_index      % 使用者輸入 from Medium
        substrate_list          % 間接 (1 x grl_num) or 1 (由 vex_cave 決定)
        thickness_list          % 間接 (1 x grl_num) or 1 (由 vex_cave 決定)
        normal_list             % 間接 (auf_num x grl_num) * 2 (左右 edge)
        aperture_list           % 間接
        radius_list             % 間接 (1 x grl_num)
        height_list             % 間接 (auf_num x grl_num)
        center_list             % 間接 (x y 座標) cell (1 x grl_num), 每個 cell 包含 2 x (segnum+1) 個點
        edge_list_left          % 間接 (x y 座標) cell (auf_num x grl_num), 每個 cell 包含 2 x (segnum+1) 個點
        edge_list_right         % 間接 (x y 座標) cell (auf_num x grl_num), 每個 cell 包含 2 x (segnum+1) 個點
        % order
        % z_top
        % z_bottom
        z_edge_list
        z_traveling_list
        
        %% interface update
        grl
        auf
        seg

        %% optional parameter
        % reversed                % 使用者輸入 (default: 0 --> Lens 結構面朝上)
        vex_cave                % 使用者輸入 (default: 1 -->  convex 凸透鏡; -1 --> concave 凹透鏡)

        %% Current Lens Info: 初始化時可為空
        % update when tracing

        % normal_top            % from Medium
        % normal_bottom         % from Medium
        % thickness             % from Medium
        substrate   
        height
        aperture
        radius
        z_edge
        % z_traveling

        %% 縮寫                 % from Medium
        % n
        % t
        % nm_top
        % nm_btm

        %% useful
        rotLRA
    end

    methods
        function obj = Lens(NameValueArgs, options)
            %LENS Construct an instance of this class
            %   Detailed explanation goes here
            %% name-value pair 輸入
            arguments   % 使用者輸入
                NameValueArgs.LRA
                NameValueArgs.size_hor
                NameValueArgs.size_ver
                NameValueArgs.pitch
                NameValueArgs.refractive_index
                NameValueArgs.thickness_EI0
                NameValueArgs.aperture
                NameValueArgs.radius
                options.reversed = 0
                options.grl
                options.auf
                options.vex_cave = 1    % 1: convex 凸透鏡; -1: concave 凹透鏡
                options.order
                options.segment
            end
            % 沒有任何輸入時 --> return 空物件
            if isempty(fieldnames(NameValueArgs))
                obj.type = "Lens";
                return
            end

            obj.LRA = NameValueArgs.LRA;
            obj.size_hor = NameValueArgs.size_hor;
            obj.size_ver = NameValueArgs.size_ver;
            obj.pitch = NameValueArgs.pitch;
            obj.refractive_index = NameValueArgs.refractive_index;
            obj.thickness_EI0 = NameValueArgs.thickness_EI0;
            obj.aperture = NameValueArgs.aperture;
            obj.radius = NameValueArgs.radius;
            
            % optional 參數檢查
            if ~isfield(options, "grl"); options.grl.GRLMode = 0; end
            if ~isfield(options, "auf"); options.auf.AUFMode = 0; end
            obj.vex_cave = options.vex_cave;
            if ~any(options.reversed == [1,0])
                error("[錯誤]: reversed 參數只能為 1 or 0 (系統停止)")
            end
            obj.reversed = options.reversed;
            if isfield(options,"order"); obj.order = options.order;end

            %% 覆蓋母類別
            obj.type = "Lens";

            %% 剩餘參數決定:
            % number
            obj.deriveNumber
            % normal (part1): 預設都是朝下
            switch obj.reversed
                case 0  % 結構朝上
                    obj.normal_top = [];         % 待更新 when tracing
                    obj.normal_bottom = [0;0;-1];
                case 1  % 結構朝下
                    obj.normal_top = [0;0;-1];
                    obj.normal_bottom = [];      % 待更新 when tracing
            end
            % radius list
            obj.deriveRadiusList(options.grl)
            % aperture list
            obj.deriveApertureList(options.auf)
            % center_list
            obj.deriveCenterList(options.segment)
            % others
            obj.deriveOthersList(options.grl)
            % useful
            obj.rotLRA = rotz(obj.LRA);
            % edge_list
            obj.deriveEdgeList
            % update
            obj.update
        end
        %% derive parameter
        function deriveNumber(obj)
            s = obj.size_hor * abs(cosd(obj.LRA)) + obj.size_ver * abs(sind(obj.LRA));
            rangeY = - floor(0.5 * s / obj.pitch) : floor(0.5 * s / obj.pitch);
            obj.number = length(rangeY);
        end
        function deriveRadiusList(obj, grl)
            radius_original = obj.radius;
            if grl.GRLMode == 1
                LREL = grl.radius_list;
                % 數量判定
                if length(LREL) < obj.number
                    error("[錯誤]: GRL Lens 總數(GRLLensNum) < Lens總數(lensNum)。 (系統停止)");
                elseif length(LREL) > obj.number
                    disp("[info]: Lens Number < GRL Number: radius 將置中處理")
                end
                mid_ind_grl = 0.5 * (length(LREL) + 1);
                obj.radius_list = LREL(mid_ind_grl-0.5*(obj.number-1):mid_ind_grl+0.5*(obj.number-1));
            elseif grl.GRLMode == 0
                obj.radius_list = obj.radius;
            end
        end
        function deriveApertureList(obj, auf)
            if auf.AUFMode == 1
                obj.aperture_list = auf.list;
            elseif auf.AUFMode == 0
                obj.aperture_list = obj.aperture;
            end
        end
        function deriveCenterList(obj, segment)
            obj.center_list = segment.update_center(obj);
        end
        function deriveOthersList(obj, grl)
            % 其他參數更新: 
            % fullheight_EI0 substrate height_list thickness_list
            % normal_list

            % 已知: thickness_EI0
            if grl.GRLMode == 0
                mid_ind = 1;
            elseif grl.GRLMode == 1
                mid_ind = 0.5 * (obj.number + 1);           % get EI0 index
            end

            % fullheight_EI0, substrate_EI0
            obj.fullheight_EI0 = obj.radius_list(mid_ind)-sqrt(obj.radius_list(mid_ind)^2-(obj.aperture_list(end)*0.5)^2);
            obj.substrate_EI0 = obj.thickness_EI0 - obj.fullheight_EI0;

            % height_list substrate_list thickness_list
            [R, A] = meshgrid(obj.radius_list,obj.aperture_list);
            H = R - sqrt(R.^2 - (A*0.5).^2);                        % list (m x n) (垂直: A (m) 水平: R (n) )
            obj.height_list = H;                                    % 共 (m x n) 個高度
            switch obj.vex_cave
                case 1  % 凸透鏡
                    % sub: fixed, thk: changed
                    obj.substrate_list = obj.substrate_EI0;     % fixed
                    obj.thickness_list = obj.substrate_list + H(end,:);     % changed, (1 x n)
                case -1 % 凹透鏡
                    % sub: changed, thk: fixed
                    obj.thickness_list = obj.thickness_EI0;     % fixed
                    obj.substrate_list = obj.thickness_list - H(end,:);      % changed, (1 x n)  
            end
            
            % normal (mxnx2) (左 Lens edge + 右 Lens edge)
            normal_Lens_left = cell(size(H,1),size(H,2));
            normal_Lens_right = cell(size(H,1),size(H,2));
            normal_matrix = zeros(size(H,1),size(H,2),3);
            normal_matrix(:,:,2) = A/2;
            normal_matrix(:,:,3) = -(R-H);
            for a = 1: size(H,1)
                for r = 1:size(H,2)
                    temp = squeeze(normal_matrix(a,r,:));
                    temp = temp/norm(temp);
                    temp = rotz(obj.LRA) * temp;
                    normal_Lens_left{a,r} = temp; 
                    temp(1:2) = -temp(1:2);
                    normal_Lens_right{a,r} = temp;
                end
            end
            obj.normal_list.left = normal_Lens_left;
            obj.normal_list.right = normal_Lens_right;
        end
        function deriveEdgeList(obj)
            obj.edge_list_left = cell(length(obj.aperture_list),obj.number);
            obj.edge_list_right = cell(length(obj.aperture_list),obj.number);
            for left_right = [-1 1]
                for ii = 1:obj.number
                    lensCenter_array = obj.center_list{ii};
                    for jj = 1:length(obj.aperture_list)
                        lens_aperture = obj.aperture_list(jj);
                        temp1 = [0;left_right*0.5*lens_aperture;0];
                        temp2 = obj.rotLRA * temp1;
                        switch left_right
                            case -1
                                obj.edge_list_left{jj,ii} = lensCenter_array + temp2(1:2);
                            case 1
                                obj.edge_list_right{jj,ii} = lensCenter_array + temp2(1:2);
                        end
                    end
                end
            end
        end
        function deriveZEdgeList(obj, value)
            obj.z_edge_list = value;
        end
        function deriveZTravelingList(obj, value)
            obj.z_traveling_list = value;
        end
        function set_normal(obj, value)
            switch obj.reversed
                case 0  % 結構向上
                    obj.normal_top = value;
                case 1  % 結構向下
                    obj.normal_bottom = value;
            end
            obj.update
        end
        function set_z_traveling(obj, value)
            obj.z_traveling = value;
        end
        function set_LRA(obj, value)
            obj.LRA = value;
            obj.rotLRA = rotz(value);
        end
    end
end

