function [result] = isStochasticMatrix(A)
    result = Utils.isColumnStochastic(A);
end
