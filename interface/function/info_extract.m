function str = info_extract(M)
    arguments
        M 
    end
    if isa(M,"Medium")
        switch M.type
            case "Cube"
                str_candidate = ["name","type","thickness","refractive_index"];
            case "Lens"
                str_candidate = ["name","type","thickness_EI0","refractive_index",...
                                "pitch","aperture","LRA","size_hor","size_ver",...
                                "reversed","vex_cave","seg","grl","auf"];
            case "GP"
                str_candidate = ["name","type","thickness","refractive_index",...
                                "reversed","GPMode","PRA"];
        end
    elseif isa(M,"Eye")
        str_candidate = ["mode","IPD","VD","VVA","VVA_ori","HVA","HVA_ori","PS","STA"];
    end
    str = strings(length(str_candidate),1);
    for ii = 1:length(str_candidate)
        switch str_candidate(ii)
            case "GPMode" 
                str_temp = extract_from_GPMode(M,M.get(str_candidate(ii)));
            case "vex_cave"
                str_temp = extract_from_vex_cave(M.get(str_candidate(ii)));
            case "seg"
                str_temp = extract_from_seg(M);
            case "grl"
                temp = M.get(str_candidate(ii));
                str_temp = extract_from_grl(M,temp.GRLMode);
            case "auf"
                temp = M.get(str_candidate(ii));
                str_temp = extract_from_auf(M,temp.AUFMode);
            case "mode" % eye mode
                temp = M.get(str_candidate(ii));
                str_temp = extract_from_eyemode(temp);
            otherwise
                str_temp = M.get(str_candidate(ii));
        end
        str(ii) = str_candidate(ii) + ": " + str_temp;
    end
    disp(str)
end
function str = extract_from_GPMode(M,content)
    switch content
        case 0
            str = "noGP";
        case 1
            str = "auto GP (WDGP " + M.autoGP.WDGP + " PBA " + M.autoGP.PBA_center + ")";
        case 2
            str = "manual GP";
    end
end
function str = extract_from_seg(M)
    str = M.seg.num;
end
function str = extract_from_grl(M,content)
    switch content % grl.GRLMode
        case 0
            str = "noGRL (radius  " + M.radius + ")";
        case 1
            str = "GRL (" + M.grl.radius_list(1) + ", ..., " + M.grl.radius_list(end) + ")";
    end
end
function str = extract_from_auf(M,content)
    switch content % auf.AUFMode
        case 0
            str = "no AUF";
        case 1
            str = "AUF (a_start " + M.auf.a_start + " a_end " + M.auf.a_end + " num " + M.auf.a_num + ")";
    end
end
function str = extract_from_vex_cave(content)
    switch content % auf.AUFMode
        case 1
            str = "convex (凸透鏡)";
        case -1
            str = "convex (凹透鏡)";
    end
end
function str = extract_from_eyemode(content)
    if isequal(content,0)
        str = "bino eye";
    elseif isequal(content,-1)
        str = "left eye";
    elseif isequal(content,1)
        str = "right eye";
    elseif isequal(content,[-1 1])
        str = "middle eye";
    end
end