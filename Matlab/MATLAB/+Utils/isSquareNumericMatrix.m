function [result] = checkSquareNumericMatrix(x);
    result = isnumeric(x) & Utils.checkSquareMatrix(x);
end
