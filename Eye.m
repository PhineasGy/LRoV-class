classdef Eye < handle & matlab.mixin.Copyable
    %EYE Summary of this class goes here
    %   左中右眼: -1 0 1
    
    properties(SetAccess=protected, GetAccess=public)   % read only
        mode                % combination of [-1 0 1]
        center_lefteye      % 間接 (x y 座標)
        edge_left_lefteye   % 間接 (x y 座標)
        edge_right_lefteye  % 間接 (x y 座標)
        center_righteye     % .
        edge_left_righteye  % .
        edge_right_righteye % .
        center_mideye
        edge_left_mideye
        edge_right_mideye
        IPD     % 使用者輸入
        VD      % 使用者輸入。 中眼位置
        VVA     % 使用者輸入。 中眼位置
        HVA     % 使用者輸入。 中眼位置
        PS      % 使用者輸入。 半徑
        VD_z    % 間接: 用於設定 Medium 最上層厚度
        z

        now
    end
    
    methods
        function obj = Eye(NameValueArgs,options)
            %EYE Construct an instance of this class
            %   Detailed explanation goes here
            arguments   % 使用者輸入
                NameValueArgs.mode
                NameValueArgs.VD
                NameValueArgs.VVA
                NameValueArgs.HVA
                NameValueArgs.PS
                options.IPD
                options.STA = 0
            end

            % 沒有任何輸入時 --> return 空物件
            if isempty(fieldnames(NameValueArgs))
                return
            end
            obj.mode = NameValueArgs.mode;
            obj.VD = NameValueArgs.VD;
            obj.VVA = NameValueArgs.VVA;
            obj.HVA = NameValueArgs.HVA;
            obj.PS = NameValueArgs.PS;  
            
            if isfield(options,"IPD")
                obj.IPD = options.IPD;
            end

            % 考慮 STA
            if options.STA ~= 0
                obj.tiltBy(options.STA) % 僅更新 VD VVA HVA
            end

            % 得三眼中心 X Y 座標
            obj.deriveCenter

            % VD_z
            obj.VD_z = obj.VD*cosd(obj.VVA); 

        end
        function set_now(obj,eyeMode,left_right_edge)
            switch eyeMode
                case -1
                    switch left_right_edge
                        case -1
                            obj.now = obj.edge_left_lefteye;
                        case 1
                            obj.now = obj.edge_right_lefteye;
                    end
                case 0
                    switch left_right_edge
                        case -1
                            obj.now = obj.edge_left_mideye;
                        case 1
                            obj.now = obj.edge_right_mideye;
                    end
                case 1
                    switch left_right_edge
                        case -1
                            obj.now = obj.edge_left_righteye;
                        case 1
                            obj.now = obj.edge_right_righteye;
                    end
            end
        end
        function updateZ(obj,medium)
            arguments
                obj
                medium Medium
            end
            obj.z = medium.z_top;
        end
        function deriveCenter(obj)
            for ii = [0 -1 1]
                switch ii
                    case -1
                        obj.center_lefteye = obj.center_mideye - [0;0.5*obj.IPD];
                    case 0
                        VD_z = obj.VD*cosd(obj.VVA); 
                        ViewPoint_x = obj.VD*sind(obj.VVA)*cosd(obj.HVA);
                        ViewPoint_y = obj.VD*sind(obj.VVA)*sind(obj.HVA);
                        obj.center_mideye = [ViewPoint_x;ViewPoint_y];
                    case 1
                        obj.center_righteye = obj.center_mideye + [0;0.5*obj.IPD];
                end
            end
        end
        function deriveEdge(obj,lens)
            for left_right = [-1 1]
                temp1 = [0;left_right*obj.PS;0];
                temp2 = lens.rotLRA * temp1;
                switch left_right
                    case -1
                        obj.edge_left_lefteye = obj.center_lefteye + temp2(1:2);
                        obj.edge_left_mideye = obj.center_mideye + temp2(1:2);
                        obj.edge_left_righteye = obj.center_righteye + temp2(1:2);
                    case 1  
                        obj.edge_right_lefteye = obj.center_lefteye + temp2(1:2);
                        obj.edge_right_mideye = obj.center_mideye + temp2(1:2);
                        obj.edge_right_righteye = obj.center_righteye + temp2(1:2);
                end
            end
        end
        function tiltBy(obj,STA)
            % 紀錄 VVA 正負
            sign_VVA = abs(obj.VVA)/obj.VVA;
            
            % 得實際人眼位置
            vd_z = obj.VD*cosd(obj.VVA); 
            ViewPoint_x = obj.VD*sind(obj.VVA)*cosd(obj.HVA);
            ViewPoint_y = obj.VD*sind(obj.VVA)*sind(obj.HVA);
            pointEye = [ViewPoint_x;ViewPoint_y;vd_z];
            pointEye_roty = roty(-STA) * pointEye;
            
            % 反推 VVA (必為正值)
            obj.VVA = acosd(pointEye_roty(3)/obj.VD);
            
            % 反推 HVA
            if pointEye_roty(1)~=0 % 非水平線
                if pointEye_roty(2) == 0 && pointEye_roty(1)< 0 % X 值 < 0, HVA 180
                        obj.HVA = 180;
                elseif pointEye_roty(2) == 0 && pointEye_roty(1)> 0 % X 值 > 0, HVA 0
                        obj.HVA = 0;
                else
                    % atand: 鎖在 -90~90 
                    obj.HVA = atand(pointEye_roty(2)/pointEye_roty(1));
                    if pointEye_roty(1) < 0 % atand 會算錯
                       obj.HVA = obj.HVA + 180;
                    end
                end
            else % 在水平線上，HVA等於原值 (正負由 VVA 正負決定) (EX: no prism DV HVA 方向)
                if sign_VVA < 0
                    obj.HVA = -obj.HVA;
                elseif sign_VVA > 0
        %             obj.HVA;
                end
            end
            % HVA 控制在 +- 180 之間
            if obj.HVA > 180
                obj.HVA = obj.HVA - 360;
            elseif obj.HVA < -180
                obj.HVA = obj.HVA + 360;
            end
        end
    end
end

