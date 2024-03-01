classdef Cube < Medium
    %CUBE 
    % User Input:
    % name
    % thickness
    % refractive_index

    properties(SetAccess=protected, GetAccess=public)   % read only
        % thickness         (使用者輸入) from Medium
        % refractive_index  (使用者輸入) from Medium
        % normal_top
        % normal_bottom

        % order
        % z_top
        % z_bottom
    end
    
    methods
        function obj = Cube(NameValueArgs,options)
            %MEDIUM Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                NameValueArgs.type ="Cube"
                NameValueArgs.thickness = 0
                NameValueArgs.refractive_index = 1
                options.reversed = 0
                options.order
            end

            obj.type = NameValueArgs.type;
            obj.thickness = NameValueArgs.thickness;
            obj.refractive_index = NameValueArgs.refractive_index;
            
            % optional setup
            if ~any(options.reversed == [1,0])
                error("[錯誤]: reversed 參數只能為 1 or 0 (系統停止)")
            end
            obj.reversed = options.reversed;
            if isfield(options,"order"); obj.order = options.order;end
            
            % normal 預設向下:
            obj.normal_bottom = [0;0;-1];
            obj.normal_top = [0;0;-1];

            obj.update
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

