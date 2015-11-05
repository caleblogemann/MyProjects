function [result] = isColumnStochastic(A)
    % A is column stochastic if A >= 0 and 1^t A = 1^t
    % sum of every column is 1
    if(Utils.isNonnegativeMatrix(A))
        [m, n] = size(A);
        result = sum(abs(ones(1,n)*A - ones(1,n)) < 10*eps) == n;
    else
        result = false;
    end
end
