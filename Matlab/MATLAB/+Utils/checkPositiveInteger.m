function [result] = checkPositiveInteger(x)
    result = Utils.checkInteger(x) & x > 0;
end
