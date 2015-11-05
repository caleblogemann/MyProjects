function [result] = isZeroMatrix(A)
    if(Utils.isNumericMatrix(A))
        [m, n] = size(A);
        result = sum(sum(abs(A) <= 10*eps)) == m*n;
    else 
        result = false;
    end
end
