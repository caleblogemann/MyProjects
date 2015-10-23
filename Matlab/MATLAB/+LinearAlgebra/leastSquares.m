function [x] = leastSquares(A, b)
% LEASTSQUARES finds the least squares solution to Ax = b, 
% where A is m by n and m >= n and rank A = n
% If A = Qhat Rhat is the reduced QR decomposition of A, then backsolving
% Rhat x = Qhat' b will be the least square solution to Ax = b
% The least squares solution of Ax = b is the vector x0 such that 
% norm(b - Ax0, 2) <= norm(b - Ax, 2) for all x in F^n
%
% Syntax:  x = LinearAlgebra.leastSquares(A,b)
%
% Inputs:
%    A - m by n matrix with m >= n and rank A = n
%    b - vector of length m
%
% Outputs:
%    x - vector of length n such that norm(b - Ax) <= norm(b - Ac) for all
%    vectors c in F^n
%
% Example: 
%    A = rand(10,5);
%    b = rand(10,1);
%    x = LinearAlgebra.leastSquares(A, b);
%
% Other m-files required: LinearAlgebra.backsolve
% Subfunctions: none
% MAT-files required: none
%
% See also: LINEARALGEBRA.BACKSOLVE

% Author: Caleb Logemann
% email: logemann@iastate.edu
% Website: http://www.logemann.public.iastate.edu/
% October 2015; Last revision: 23-October-2015

    p = inputParser;
    p.addRequired('A', @isnumeric)
    p.addRequired('b', @Utils.isNumericVector);
    p.parse(A, b);

    [Qhat, Rhat] = LinearAlgebra.reducedQR(A);
    x = LinearAlgebra.backsolve(Rhat, Qhat'*b);
end
