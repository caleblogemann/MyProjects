function [result] = checkFunctionHandleCell(x)
    if(iscell(x))
        for i=1:length(x)
            if(~isa(x{i}, 'function_handle'))
                result = false;
                return;
            end
        end
        result = true;
    else
        result = false;
    end
end
