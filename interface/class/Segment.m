classdef Segment < handle & matlab.mixin.Copyable
    %SEGMENT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        num % 段數: num = 5 ==> "5"段6點
    end
    
    methods
        function obj = Segment(NameValueArgs)
            %SEGMENT Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                NameValueArgs.num = 1
            end
            obj.num = NameValueArgs.num;
        end
        
        function lensCenter_list = update_center(obj,lens)
            %METHOD1 Summary of this method goes here
            %   update C2 center
            range = [-0.5*(lens.number-1):0.5*(lens.number-1)];
            count = 0;
            lensCenter_list = cell(1,lens.number);
            lens_ver_after_rot = lens.size_ver * cosd(lens.LRA) + lens.size_hor * sind(lens.LRA);
            rot = inv(rotz(-lens.LRA)); rot = rot(1:2,1:2);
            for ii = range
                count = count + 1;
                point_top = [-0.5*lens_ver_after_rot;lens.pitch*ii];
                point_top_transform = rot * point_top;
                point_bottom = [0.5*lens_ver_after_rot;lens.pitch*ii];
                point_bottom_transform = rot * point_bottom;
                % point_array: size [2 x (segnum+1)]
                point_array = [linspace(point_top_transform(1),point_bottom_transform(1),obj.num+1);...
                                linspace(point_top_transform(2),point_bottom_transform(2),obj.num+1)]; 
                lensCenter_list{1,count} = point_array;
            end
        end
    end
end

