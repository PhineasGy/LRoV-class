classdef Ray < handle & matlab.mixin.Copyable
    %Ray: "光線 ray" 物件
    %
    %   必要參數:
    % 1. 光的出發點(座標)
    % 2. 光的終止點(座標)
    % 3. 光的向量 (optional)

    properties(SetAccess=protected, GetAccess=public)
      point_head
      point_tail
      vector
      TIR = 0
      p_h
      p_t
      v
      uv
    end
    methods
        % 初始化
        function obj = Ray(point_head,point_tail,vector)
            obj1 = obj;
            switch nargin
                case 0
                case 2
                    obj1.point_head = point_head;
                    obj1.point_tail = point_tail;
                    obj1.vector = [1;0;0];
                    obj1.check_type;
                    obj = obj1;
                    % 參數更新
                    obj.update_vector;
                    obj.update;
                case 3
                    obj1.point_head = point_head;
                    obj1.point_tail = point_tail;
                    obj1.vector = vector;
                    obj1.check_type;
                    obj = obj1;
                    % 參數更新
                    obj.update;
                otherwise
                    error("Ray 物件初始化錯誤。輸入參數項目不對 (可為 0 2 3)")
            end
        end   
        %% set function (要即時更新 abbri-parameter)
        function set_head(obj,values)
            if ~isequal([size(values,1),size(values,2),size(values,3)],[3,1,1])
                error(strcat("[錯誤] Ray 物件參數型態錯誤: vector must with size(3,1)"))
            end
            obj.point_head = values;
            obj.update;
        end
        function set_tail(obj,values)
            if ~isequal([size(values,1),size(values,2),size(values,3)],[3,1,1])
                error(strcat("[錯誤] Ray 物件參數型態錯誤: vector must with size(3,1)"))
            end
            obj.point_tail = values;
            obj.update;
        end
        function set_vector(obj,values)
            if ~isequal([size(values,1),size(values,2),size(values,3)],[3,1,1])
                error(strcat("[錯誤] Ray 物件參數型態錯誤: vector must with size(3,1)"))
            end
            obj.vector = values;
            obj.update;
        end
        
        %% 更新 vector (by refraction)
        % snell's law 3D vector form
        % 從介質 A 通過一個介面到介質 B 的 "vector" 變化
        % needP = 0: 只改變 uv。needP = 1: Ray 所有屬性更新
        function snell(obj,mediumA,mediumB,needP)
            arguments
                obj
                mediumA Medium
                mediumB Medium
                needP   % 0, 1
            end
            mu = mediumA.n/mediumB.n;
            % 檢測此時 ray 的向量: 向上追跡或向下追跡
            switch obj.uv(3) < 0
                case 1  % 往下追跡
                    uv_junc_normal = mediumB.nm_top;
                case 0  % 往上追跡
                    uv_junc_normal = mediumB.nm_btm;
            end
            uv_junc_normal = uv_junc_normal/norm(uv_junc_normal);
            uv_in = obj.uv;
            uv_out = sqrt(1-mu^2*(1-(uv_junc_normal'*uv_in)^2))*uv_junc_normal+...
                mu*(uv_in-(uv_junc_normal'*uv_in)*uv_junc_normal);
            
            % update uv
            obj.uv = uv_out;

            % 
            if needP
                obj.set_head(obj.p_t)   % 新頭為上一道光線的尾
                obj.update_tail(mediumB.z_traveling) % 新尾由 頭 "uv" 和 Z 決定
                obj.update_vector     % 由新頭尾重新更新 Vector
                obj.update            % 更新其他參數: 縮寫, uv, TIR
            end
        end


        %% 更新 point tail (by head, "uv" and travel Z) (注意 Z 正負)
        function update_tail(obj,z)
            obj.point_tail = obj.point_head + obj.uv * (z/obj.uv(3));
            obj.update
        end
        %% 更新 vector (by point_head and point_tail)
        function update_vector(obj)
            obj.vector = obj.point_tail - obj.point_head;
            if isnan(obj.vector(1));obj.vector=[0;0;0];end
            update(obj);
        end
        %% 檢查是否 TIR
        function r = isTIR(obj)
          if obj.TIR == 1
              r = 1;
          elseif obj.TIR == 0
              r = 0;
          end
        end
        %% 檢查輸入型態
        function check_type(obj)
            for ii = 1:3
                switch ii
                    case 1
                        test = obj.point_head;
                    case 2
                        test = obj.point_tail;        
                    case 3
                        test = obj.vector;
                end
                if isempty(test)
                    continue
                end
                if ~isequal([size(test,1),size(test,2),size(test,3)],[3,1,1])
                    error(strcat("[錯誤] Ray 物件參數型態錯誤: (輸入 ", num2str(ii),") vector must with size(3,1)"))
                end
            end
        end
        %% 更新參數: 縮寫, TIR, unit_vector
        function update(obj)
            obj.p_h = obj.point_head;
            obj.p_t = obj.point_tail;
            obj.v = obj.vector;
            obj.uv = obj.vector/norm(obj.vector);
            if any(~isreal([obj.point_head,obj.point_tail,obj.vector]))
                obj.TIR = 1;
            end
        end
    end
end