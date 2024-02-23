classdef AUF < handle & matlab.mixin.Copyable

    properties (SetAccess=protected, GetAccess=public)   % read only
        % input
        AUFMode
        a_start     % optional
        a_num       % optional
        a_end       % optional
        list        % optional
    end
    
    methods
        function obj = AUF(NameValueArgs,options)
            arguments   % 使用者輸入
                NameValueArgs.AUFMode
                options.a_start
                options.a_num
                options.a_end
                options.list
            end
            obj.AUFMode = NameValueArgs.AUFMode;
            if obj.AUFMode == 1
                A = isfield(options, "list");
                B = isfield(options, "a_start") && ...
                        isfield(options, "a_num") && ...
                        isfield(options, "a_end");
                if A && B
                    disp("[info]: 偵測到 list 和 參數設定, 將以 list 值為主")
                end
                if isfield(options, "list")
                    disp("[info]: AUF on < aperture by list >")
                    obj.list = options.list;
                elseif isfield(options, "a_start") && ...
                        isfield(options, "a_num") && ...
                        isfield(options, "a_end")
                    
                    obj.a_start = options.a_start;
                    obj.a_num = options.a_num;
                    obj.a_end = options.a_end;
                    disp("[info]: AUF on < aperture by linspace(a_start,a_end,a_num) >")
                    obj.list = linspace(obj.a_start,obj.a_end,obj.a_num);
                else
                    error("[錯誤]: 找不到 AUF aperture data (系統停止)")
                end
            end
        end
    end
end

