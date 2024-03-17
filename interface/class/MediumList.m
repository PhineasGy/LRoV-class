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

        function target = find(obj,options)  % 搜尋特定介質
            arguments
                obj
                options.tag
                options.name
                options.type
                options.order
            end
            if isfield(options,"tag")
                index_tag = arrayfun(@(x) isequal(x.tag,options.tag),obj.list);
            else
                index_tag = ones(1,length(obj.list));
            end
            if isfield(options,"name")
                index_name = arrayfun(@(x) isequal(x.name,options.name),obj.list);
            else
                index_name = ones(1,length(obj.list));
            end
            if isfield(options,"type")
                index_type = arrayfun(@(x) isequal(x.type,options.type),obj.list);
            else
                index_type = ones(1,length(obj.list));
            end
            if isfield(options,"order")
                index_order = arrayfun(@(x) isequal(x.order,options.order),obj.list);
            else
                index_order = ones(1,length(obj.list));
            end
            target = obj.list(index_tag&index_name&index_type&index_order);
        end
    end
end

