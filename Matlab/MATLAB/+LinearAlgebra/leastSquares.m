function [x] = leastSquares(A, b)
% LEASTSQUARES finds the least squares solution to Ax = b, 
% where A is m by n and m >= n
% If A = Qhat Rhat is the reduced QR decomposition of A, then backsolving
% Rhat x = Qhat' b will be the least square solution to Ax = b
% The least squares solution of Ax = b is the vector x0 such that 
% norm(b - Ax0, 2) <= norm(b - Ax, 2) for all x in F^n

    p = inputParser;
    p.addRequired('A', @isnumeric)
    p.addRequired('b', @Utils.isNumericVector);
    p.parse(A, b);

    [Qhat, Rhat] = LinearAlgebra.reducedQR(A);
    x = LinearAlgebra.backsolve(Rhat, Qhat'*b);
end
