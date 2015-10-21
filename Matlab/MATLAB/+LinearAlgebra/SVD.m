function [U, S, V] = SVD(A, varargin)
    p =inputParser;
    p.addRequired('A', @isnumeric);
    p.addOptional('threshold', 10^(-13), @isnumeric);
    p.parse(A, varargin{:});

    [Uhat, Shat, Vhat] = LinearAlgebra.reducedSVD(A, p.Results.threshold);
    U = LinearAlgebra.extendToOrthonormalBasis(Uhat);
    V = LinearAlgebra.extendToOrthonormalBasis(Vhat);

    r = length(Shat);
    S = zeros(size(A));
    S(1:r, 1:r) = Shat;
end
