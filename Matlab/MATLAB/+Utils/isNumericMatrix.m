function [result] = isNumericMatrix(x);
    result = isnumeric(x) && Utils.isMatrix(x);
end
