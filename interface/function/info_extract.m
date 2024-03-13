function str = info_extract(M)
    arguments
        M Medium
    end
    
    switch M.type
        case "Cube"
            str_candidate = ["name","type","thickness","refractive_index"];
        case "Lens"
            str_candidate = ["name","type","thickness","refractive_index"];
        case "GP"
            str_candidate = ["name","type","thickness","refractive_index",...
                            "reversed","GPMode","PRA"];
    end
    str = strings(length(str_candidate),1);
    for ii = 1:length(str_candidate)
        switch str_candidate(ii)
            case "GPMode" 
                str_temp = extract_from_GPMode(M,M.get(str_candidate(ii)));
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