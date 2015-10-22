%
function [Ak] = rankApproximant(A, k)
    p = inputParser;
    p.addRequired('A', @isnumeric);
    p.addRequired('k', @Utils.isPositiveInteger);
    p.parse(A, k);

    [m, n] = size(A);
    if(k > n)
        error('Rank input must be less than size of A');
    end

    [U, S, V] = LinearAlgebra.SVD(A);
    singularValues = diag(S);
    % remove extra positive singular values
    % so that only k positive singular values remain
    singularValues(k+1:end) = 0;
    Sk = diag(singularValues);
    Ak = U*Sk*V';
end
