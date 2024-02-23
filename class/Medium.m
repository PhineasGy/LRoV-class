classdef Medium < handle & matlab.mixin.Copyable
    %MEDIUM "介質" 物件
    %   參數:
    % 1. 介質厚度
    % 2. 介質折射率
    % 3. 介質類型
    % 4. 上下介面法向量 (預設朝下 (-z))
    
    properties(SetAccess=protected, GetAccess=public)   % read only
        % necessary input
        type                % 使用者輸入 (有預設值)
        thickness           % 使用者輸入 (有預設值)
        refractive_index    % 使用者輸入 (有預設值)
        normal_top          % 間接
        normal_bottom       % 間接
        % optional input
        reversed
        % 在子類別定義
        order
        z_top
        z_bottom
        z_traveling
        % 縮寫
        t
        n
        nm_top
        nm_btm
    end
    
    methods
        function obj = Medium(NameValueArgs,options)
            %MEDIUM Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                NameValueArgs.type ="Cube"
                NameValueArgs.thickness = 0
                NameValueArgs.refractive_index = 1
                options.reversed = 0
            end
            obj.type = NameValueArgs.type;
            obj.thickness = NameValueArgs.thickness;
            obj.refractive_index = NameValueArgs.refractive_index;

            if ~any(options.reversed == [1,0])
                error("[錯誤]: reversed 參數只能為 1 or 0 (系統停止)")
            end
            obj.reversed = options.reversed;

            % default normal: [0;0;-1]  % 其他子類別會去覆蓋
            obj.normal_bottom = [0;0;-1];
            obj.normal_top = [0;0;-1];
            
            obj.update
        end
        %% set parameter
        function set_t(obj, values)
            if obj.type == "Cube"
                obj.thickness = values;
                obj.update;
            else
                error("[錯誤] set_t function 只對 type 為 'Cube' 的物件 有效")
            end
        end
        function set_n(obj, values)
            obj.refractive_index = values;
            obj.update;
        end
        function set_type(obj, str)
            obj.type = str;
        end
        function set_reversed(obj, value)
            % value 只能為 0 or 1
            if value == 0 || value == 1
                ori_value = obj.reversed;
                if ori_value ~= value % 要更新
                    temp = obj.normal_bottom;
                    obj.reversed = value;
                    obj.normal_bottom = obj.normal_top;
                    obj.normal_top = temp;
                    obj.update
                end
            else
                error("[錯誤] set_reversed(value), value 只能為 0, 1 (系統停止) ")
            end
        end
        function set_order(obj, value)
            obj.order = value;
        end
        function set_z_top(obj, value)
            obj.z_top = value;
        end
        function set_z_bottom(obj, value)
            obj.z_bottom = value;
        end
        function set_z_traveling(obj, value)
            obj.z_traveling = value;
        end
        function force_normal(obj, NameValueArgs)
            % 強制改變法向量
            % 用途: Lens 到 Prism 層之間的空氣層。
            % EX: 將該空氣層的上層法向量從 [0;0;-1] 改為 prism 法向量
            % top_btm:
            % 字串: "top", "btm"
            % 數字: 0 (reversed == 0) top, 1 (reversed == 1) btm
            arguments   % 使用者輸入
                obj
                NameValueArgs.top_btm
                NameValueArgs.normal    % from Medium class
            end
            % top ==> reversed 0
            % btm ==> reversed 1
            top_btm = NameValueArgs.top_btm;
            normal = NameValueArgs.normal;
            if isstring(top_btm) || ischar(top_btm)
                if matches(top_btm,"top",IgnoreCase=true)
                    obj.normal_top = normal;
                elseif matches(top_btm,"btm",IgnoreCase=true)
                    obj.normal_bottom = normal;
                else
                    error("[錯誤]: force_normal 失敗，無法識別 top_btm")
                end
            elseif isnumeric(top_btm)   % reversed 判定
                if top_btm == 1     % reversed = 1 --> btm
                    obj.normal_bottom = normal;
                elseif top_btm == 0 % reversed = 0 --> top
                    obj.normal_top = normal;
                else
                    error("[錯誤]: force_normal 失敗，無法識別 top_btm")
                end
            end
            obj.update()
        end
        function inverse_normal(obj)
            % including traveling z
            obj.z_traveling = -obj.z_traveling;
            obj.normal_top = -obj.normal_top;
            obj.normal_bottom = -obj.normal_bottom;
            obj.update
        end
        function update(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.t = obj.thickness;
            obj.n = obj.refractive_index;
            obj.nm_top = obj.normal_top;
            obj.nm_btm = obj.normal_bottom;
        end
    end
end

