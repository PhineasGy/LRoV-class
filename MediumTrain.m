classdef MediumTrain < handle & matlab.mixin.Copyable
    %MEDIUMTRAIN Summary of this class goes here
    %   Detailed explanation goes here
    % get each element
    % ex: cellfun(@(X) X.t, medium_list)
    
    properties
        eye
        medium_list
    end
    
    methods
        function obj = MediumTrain(eye,medium_list)
            %MEDIUMTRAIN Construct an instance of this class
            %   Detailed explanation goes here 
            obj.eye = eye;
            obj.medium_list = medium_list;
            % update order
            order = 1:length(obj.medium_list);
            cellfun(@set_order,obj.medium_list,num2cell(order));
            % update z
            obj.update_z
        end  
        function set_order(obj,value)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            if length(obj.medium_list) ~= length(value)
                error("[錯誤]: set_order 輸入與 medium list 數量不符 (系統停止)")
            end
            cellfun(@set_order,obj.medium_list,num2cell(value));
        end
        function update_z(obj)
            % update z_top, z_bottom, z_traveling
            num = length(obj.medium_list);
            z = 0;
            for which_m = num:-1:1
                medium_now = obj.medium_list{which_m};
                % disp(strcat("medium now: ",medium_now.type))
                % 更新 medium_now --> 同時也更新了 obj.medium_list{which_m} (相同位址)
                switch medium_now.type
                    case "Cube"
                        medium_now.set_z_bottom(z);
                        z = z + medium_now.thickness;
                        medium_now.set_z_top(z);
                        medium_now.set_z_traveling(medium_now.z_bottom - medium_now.z_top);
                    case "Lens"
                        % top/bottom: substrate 面 (不考慮結構面)
                        % z_edge_list: if no AUF, z_edge = z_bottom or z_edge =
                        % z_top
                        % z_traveling_list
                        switch medium_now.vex_cave
                            case 1  % 凸透鏡
                                switch medium_now.reversed
                                    case 0  % 結構朝上
                                        medium_now.set_z_bottom(z);
                                        z = z + medium_now.substrate_list;
                                        medium_now.set_z_top(z);
                                        medium_now.deriveZEdgeList(medium_now.z_top + (medium_now.height_list(end,:) - medium_now.height_list));
                                        medium_now.deriveZTravelingList(medium_now.z_bottom - medium_now.z_edge_list);
                                    case 1  % 結構朝下
                                        medium_now.z_bottom(z);
                                        z = z + medium_now.substrate_list;
                                        medium_now.set_z_top(z);
                                        medium_now.deriveZEdgeList(medium_now.z_bottom - (medium_now.height_list(end,:) - medium_now.height_list));
                                        medium_now.deriveZTravelingList(medium_now.z_edge_list - medium_now.z_top);
                                end
                            case -1 % 凹透鏡
                                switch medium_now.reversed
                                    case 0  % 結構朝上
                                        medium_now.set_z_bottom(z);
                                        z = z + medium_now.thickness_list;
                                        medium_now.set_z_top(z);
                                        medium_now.deriveZEdgeList(medium_now.z_top - (medium_now.height_list(end,:) - medium_now.height_list));
                                        medium_now.deriveZTravelingList(medium_now.z_bottom - medium_now.z_edge_list);
                                    case 1  % 結構朝下
                                        medium_now.set_z_bottom(z);
                                        z = z + medium_now.thickness_list;
                                        medium_now.set_z_top(z);
                                        medium_now.deriveZEdgeList(medium_now.z_bottom + (medium_now.height_list(end,:) - medium_now.height_list));
                                        medium_now.deriveZTravelingList(medium_now.z_edge_list - medium_now.z_top);
                                end
                        end
                        % 檢查 z 裡的元素是否都相同
                        % 一個 凸透鏡 Lens 通常會馬上接一個凹透鏡的空氣 --> 最後每個 Lens(in LL) 的 Z 會相同
                    case "GP"   % Cube 變體
                        medium_now.set_z_bottom(z);
                        z = z + medium_now.thickness;
                        medium_now.set_z_top(z);
                        medium_now.set_z_traveling(medium_now.z_bottom - medium_now.z_top);
                end
            end
            obj.eye.updateZ(obj.medium_list{1})
        end
        function medium = find(obj, options)
            arguments
                obj
                options.type
                options.order
            end
            if isfield(options,"type")
                index = cellfun(@(x) x.type==options.type, obj.medium_list);
                medium = obj.medium_list(index);
                if length(medium) == 1
                    medium = medium{:};
                end
            end
            if isfield(options,"order")
                index = cellfun(@(x) x.order==options.order, obj.medium_list);
                medium = obj.medium_list(index);
                if length(medium) == 1
                    medium = medium{:};
                end
            end
        end
    end
end

