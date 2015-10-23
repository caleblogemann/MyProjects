function [result] = isSquareNumericMatrix(x);
    result = isnumeric(x) && Utils.isSquareMatrix(x);
end
