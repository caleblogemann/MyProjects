function [result] = checkInteger(x)
    result = isnumeric(x) && abs(round(x) - x) <= eps('double');
end
