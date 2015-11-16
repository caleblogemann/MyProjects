function [result] = isLowerTriangular(A)
    % if transpose if upper triangular than original is lower triangular
    result = Utils.isUpperTriangular(A.');
end
