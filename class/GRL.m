classdef GRL < handle & matlab.mixin.Copyable

    properties (SetAccess=protected, GetAccess=public)   % read only
        % input
        GRLMode         % optional
        file            % optional
        radius_list     % optional
    end
    
    methods
        function obj = GRL(NameValueArgs,options)
            arguments   % 使用者輸入
                NameValueArgs.GRLMode
                options.file
                options.radius_list
            end
            obj.GRLMode = NameValueArgs.GRLMode;
            if obj.GRLMode == 1
                disp("[info]: GRL on")
                if isfield(options,"radius_list") && isfield(options,"file")
                    disp("[info]: 偵測到 radius_list 和 file, 將以 list 值為主")
                end
                if isfield(options,"radius_list")   % 以直接給 list 優先
                    disp("[info]: 讀取 GRL from list")
                    obj.radius_list = options.radius_list;
                elseif isfield(options,"file")
                    disp("[info]: 讀取 GRL from file")
                    obj.file = options.file;
                    try
                        load(obj.file);
                    catch
                        error("[錯誤]: 無法讀取 GRL 資料 (系統停止)")
                    end
                    obj.radius_list = LensRadiusEachLenticular;
                else
                    error("[錯誤]: 找不到 GRL data (系統停止)")
                end      
            else
            end
        end
    end
end

