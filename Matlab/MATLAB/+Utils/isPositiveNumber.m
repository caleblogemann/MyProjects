function [result] = isPositiveNumber(x)
    result = Utils.isNumber(x) && x > 0;
end
