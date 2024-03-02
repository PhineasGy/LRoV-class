classdef ManualGP < handle & matlab.mixin.Copyable
    %ManualGP Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(SetAccess=protected, GetAccess=public)   % read only
        % for PLAvsPBA: 需要 gp, medium_list
        % for virtual eye: 需要 gp, medium_list, PBA_center, WDGP
        
        % input
        gp   GradientPrism           % GP 物件

        % output
        LtoPBAFunction
    end
    
    methods
        function obj = ManualGP()
            %AUTOGP Construct an instance of this class
            %   Detailed explanation goes here
            %% name-value pair 輸入
            arguments   % 使用者輸入
                
            end

        end
        
        function update_manualGP(obj,gp)
            % 因為不會動到 gp 參數: 不需要 copy
            obj.gp = gp;
            % derive output
            obj.derive_LtoPBAFunction
        end
        function derive_LtoPBAFunction(obj)
            if any(diff(obj.gp.PBA_key)>0)
                error("[錯誤] 手動 GP 底角規則應為: 角度遞減。 (系統停止)")
            end
            % X: 距離 Y: 底角
            PBA_fit_length = abs(obj.gp.size_ver*cosd(obj.gp.PRA))+abs(obj.gp.size_hor*sind(obj.gp.PRA));
            PBA_fit_num = length(obj.gp.PBA_key);
            PBA_fit_point = zeros(2,PBA_fit_num);
            PBA_fit_line = zeros(2,PBA_fit_num-1);
            for whichpba = 1:PBA_fit_num % 建立N條線段 (N=底角數量-1)
                PBA_fit_point(:,whichpba)=[(whichpba-1)*PBA_fit_length/(PBA_fit_num-1);obj.gp.PBA_key(whichpba)];
                if whichpba>=2 %建立線段
                    PBA_fit_x = PBA_fit_point(1,(whichpba-1):whichpba)';
                    PBA_fit_y = PBA_fit_point(2,(whichpba-1):whichpba)';
                    % poly1 speed up 20230109
                    % y = p1 * x + p2
                    p1 = (PBA_fit_y(2)-PBA_fit_y(1))/(PBA_fit_x(2)-PBA_fit_x(1));
                    p2 = p1*(-PBA_fit_x(1)) + PBA_fit_y(1);
                    PBA_fit_line(1,whichpba-1) = p1;
                    PBA_fit_line(2,whichpba-1) = p2;
                end
            end
            obj.LtoPBAFunction.fitLength = PBA_fit_length;
            obj.LtoPBAFunction.fitNum = PBA_fit_num;
            obj.LtoPBAFunction.fitLine = PBA_fit_line;
            obj.LtoPBAFunction.fitPoint = PBA_fit_point;
        end
    end
end

