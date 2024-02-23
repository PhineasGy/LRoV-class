function [outputArg1,outputArg2] = IPA(head,tail,medium_list)
%UNTITLED2 Summary of this function goes here
%   tail 尾: lens edge point
%   medium_list: 眼睛 --> Lens Edge 經過的介質
%   最後一個 medium 必須為 Lens (即倒數第一和倒數第二都要是 Lens)
if ~(medium_list{end}.type == "Lens" && medium_list{end-1}.type == "Lens")
    error("[錯誤]: 最後兩層須為 Lens 物件 (系統停止)")
end

lens = medium_list{end};

% 決定要跑得根數 (由 GRL 和 AUF 決定)
[auf_num, grl_num] = size(lens.z_edge);

for whichgrl=1:grl_num
    for whichauf=1:auf_num
        head = [250;0;4.405807018922193e+02];   % 人眼位置
        tail = lens.z_edge
    end
end

end

