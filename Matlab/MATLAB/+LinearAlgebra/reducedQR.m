function [Qhat, Rhat] = reducedQR(A);
    p = inputParser;
    p.addRequired('A', @isnumeric)
    p.parse(A);

    [Qhat,Rhat] = LinearAlgebra.gramSchmidt(A);
end
