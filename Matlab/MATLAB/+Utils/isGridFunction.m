function [result] = isGridFunction(x)
    % issorted checks if increasing
    result = Utils.isNumericVector(x) && issorted(x);
end
