function [result] = isOddInteger(x)
    result = Utils.isInteger(x) && abs(abs(mod(x, 2)) - 1) <= eps('double');
end
