classdef MediumList < handle
    %MEDIANLIST Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        list Medium
        order
    end
    
    methods
        function obj = MediumList()
            %MEDIANLIST 建立一個空 list
            % 後續使用 add 加入 list
            % 後續使用 order 改變 順序
        end
        
        function add(obj,medium)
            current_number = length(obj.list);
            if isempty(current_number);current_number = 0;end
            obj.list(current_number+1) = medium;
            disp("[info]: medium added.")
        end
    end
end

