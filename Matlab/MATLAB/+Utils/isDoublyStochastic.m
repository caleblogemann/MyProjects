function [result] = isDoublyStochastic(A)
    % A is doubly stochastic if it is both row and column stochastic
    result = Utils.isColumnStochastic(A) && Utils.isRowStochastic(A);
end
