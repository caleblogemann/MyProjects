function [result] = checkNumericVector(x)
    result = isnumeric(x) & isvector(x);
end
