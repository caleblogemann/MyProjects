function [result] = isPositiveMatrix(A)
    if(Utils.isNumericMatrix(A))
        [m, n] = size(A);
        result = sum(sum(A > 0)) == m*n;
    else
        result = false;
    end
end
