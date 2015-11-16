function [result] = isSquareMatrix(A)
    result = Utils.isMatrix(A) && all(size(A) == size(A'));
end
