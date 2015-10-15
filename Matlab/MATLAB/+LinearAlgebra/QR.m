function [Q, R] = QR(A);
    p = inputParser;
    p.addRequired('A', @isnumeric)
    p.parse(A);

    [Qhat, Rhat] = LinearAlgebra.reducedQR(A);

    % extend Qhat to a basis
    Q = LinearAlgebra.extendToOrthonormalBasis(Qhat);
    % fill in zeros of Rhat
    R = ;
end
