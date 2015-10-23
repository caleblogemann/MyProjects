function [result] = isNumericVector(x)
    result = isnumeric(x) & isvector(x);
end
