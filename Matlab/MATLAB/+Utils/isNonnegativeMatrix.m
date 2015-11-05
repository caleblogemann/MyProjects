function [result] = isNonnegativeMatrix(A)
    if(Utils.isNumericMatrix(A))
        [m, n] = size(A);
        result = sum(sum(A >= -10*eps)) == m*n;
    else
        result = false;
    end
end
