function [result] = isRowStochastic(A)
    % A is row stochastic if the transpose of A is columnStochastic
    result = Utils.isColumnStochastic(A.');
end
