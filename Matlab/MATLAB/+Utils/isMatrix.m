function [] = isNumericMatrix(x);
    validateattributes(x, {'numeric'}, {'ndims', 2});
end
