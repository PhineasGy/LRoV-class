function str = info_extract(M)
    arguments
        M Medium
    end
    
    switch M.type
        case "Cube"
            str_candidate = ["name","type","thickness","refractive_index"];
        case "Lens"
    end
    str = strings(length(str_candidate),1);
    for ii = 1:length(str_candidate)
        str(ii) = str_candidate(ii) + ": " + M.get(str_candidate(ii));
    end

    disp(str)
end