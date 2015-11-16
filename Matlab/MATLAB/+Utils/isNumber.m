function [result] = isNumber(x)
    result = isnumeric(x) && all(size(x) == [1, 1]);
end
