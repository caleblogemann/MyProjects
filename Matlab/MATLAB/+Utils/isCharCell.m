function [result] = isCharCell(x)
    if(iscell(x))
        for i=1:length(x)
            if(~ischar(x{i}))
                result = false;
                return;
            end
        end
        result = true;
    else
        result = false;
    end
end

