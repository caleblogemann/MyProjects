function [result] = isMatrix(x);
    result = ndims(x) == 2;
end
