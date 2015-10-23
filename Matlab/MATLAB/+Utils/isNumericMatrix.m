function [] = isNumericMatrix(x);
    result = isnumeric(x) && Utils.isMatrix(x);
end
