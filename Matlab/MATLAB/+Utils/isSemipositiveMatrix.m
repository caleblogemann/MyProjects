function [result] = isSemipostiveMatrix(A)
    % A is semipostive if A is nonnegative and not zero
    result = Utils.isNonnegativeMatrix(A) && ~Utils.isZeroMatrix(A);
end
