classdef MediumList < handle
    %MEDIANLIST Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        list Medium
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

        function update_order(obj)  % update all order by list
            for ii = 1:length(obj.list)
                obj.list(ii).set_order(ii);
            end
        end

        function replace(obj,ind,new)
            obj.list(ind) = new;
        end

        function delete(obj,ind)    % 以下往上遞補
            obj.list(ind) = [];
        end
    end
end

