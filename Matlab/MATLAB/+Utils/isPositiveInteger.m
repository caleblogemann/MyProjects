function [result] = isPositiveInteger(x)
    result = Utils.isInteger(x) & x > 0;
end
