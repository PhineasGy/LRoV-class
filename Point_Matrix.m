classdef Point_Matrix < handle
    %POINT_MATRIX Summary of this class goes here
    %   (auf x grl x segP x two pupil edge x eye) 5-D matrix
    
    properties(SetAccess=protected, GetAccess=public)   % read only
        raw         % 5 維矩陣: auf x grl x segP x twoEdge x threeEye
        eye_num = 3
        auf_num
        grl_num
        segP_num
        edge_num = 2
        of4D        % permute 降維: grl x segP x 2 x 3
        ofLength    % 降維: grl x segP x 3
    end
    
    methods
        function obj = Point_Matrix(raw)
            %POINT_MATRIX Construct an instance of this class
            %   Detailed explanation goes here
            obj.raw = raw;
            [obj.auf_num,obj.grl_num,obj.segP_num,~,~] = size(raw);
            obj.auf_dr;
            obj.twoedge_dr;
        end

        function auf_dr(obj)    % auf dimension reduction (get of3D)
            % 降維: grl x segP x twoedge
            % if auf num == 1: 直接降維
            % if auf num ~= 1: auf 降維
            if obj.auf_num == 1
                obj.of4D = permute(obj.raw,[2,3,4,5,1]);
            elseif obj.auf_num ~= 1
%                 obj.of4D =;  % not yet
            end
        end

        function twoedge_dr(obj) % two edge dimension reduction (get length)
            % 降維: grl x segP x 3
            obj.ofLength = cellfun(@(x,y)(norm(x-y)),obj.of4D(:,:,1,:),obj.of4D(:,:,2,:));
            obj.ofLength = permute(obj.ofLength,[1,2,4,3]);
        end

        function pm = eye_extract(obj) % eye info extraction
            for ii = [-1,0,1]
                switch ii
                    case -1
                        try
                            pm.leftEye.P = obj.of4D(:,:,:,1);
                            pm.leftEye.L = cellfun(@(x,y)(norm(x-y)),pm.leftEye.P(:,:,1),pm.leftEye.P(:,:,2));
                        catch
                            disp("[info]: no info for left eye.")
                        end
                    case 0
                        try
                            pm.midEye.P = obj.of4D(:,:,:,2);
                            pm.midEye.L = cellfun(@(x,y)(norm(x-y)),pm.midEye.P(:,:,1),pm.midEye.P(:,:,2));
                        catch
                            disp("[info]: no info for mid eye.")
                        end
                    case 1
                        try
                            pm.rightEye.P = obj.of4D(:,:,:,3);
                            pm.rightEye.L = cellfun(@(x,y)(norm(x-y)),pm.rightEye.P(:,:,1),pm.rightEye.P(:,:,2));
                        catch
                            disp("[info]: no info for right eye.")
                        end
                    otherwise
                        error("[error] unknown value for eye_dr(). Should be -1 0 1. (system stopped)")
                end
            end
        end
    end
end

