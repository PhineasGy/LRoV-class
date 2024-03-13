function str = info_extract(M)
    arguments
        M Medium
    end
    
    switch M.type
        case "Cube"
            str_candidate = ["name","type","thickness","refractive_index"];
        case "Lens"
            str_candidate = ["name","type","thickness_EI0","refractive_index",...
                            "pitch","aperture","LRA","size_hor","size_ver",...
                            "reversed","seg","grl","auf"];
        case "GP"
            str_candidate = ["name","type","thickness","refractive_index",...
                            "reversed","GPMode","PRA"];
    end
    str = strings(length(str_candidate),1);
    for ii = 1:length(str_candidate)
        switch str_candidate(ii)
            case "GPMode" 
                str_temp = extract_from_GPMode(M,M.get(str_candidate(ii)));
            case "seg"
                str_temp = extract_from_seg(M);
            case "grl"
                temp = M.get(str_candidate(ii));
                str_temp = extract_from_grl(M,temp.GRLMode);
            case "auf"
                temp = M.get(str_candidate(ii));
                str_temp = extract_from_auf(M,temp.AUFMode);
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