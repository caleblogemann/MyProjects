function [Qhat, Rhat] = reducedQR(A);
%REDUCEDQR - computes the reduced QR decomposition of A
%The reduced QR decomposition of A are matrices Qhat and Rhat such that Qhat has
%orthonormal columns, Rhat is upper triangular and A = Qhat*Rhat
%
% Syntax:  [Qhat, Rhat] = LinearAlgebra.reducedQR(A)
%
% Inputs:
%    A - m by n matrix, with m > n and having full rank
%
% Outputs:
%    Qhat - m by n matrix, with orthonormal columns
%    Rhat - n by n matrix that is upper triangular
%
% Example: 
%    A = rand(3);
%    [Qhat, Rhat] = LinearAlgebra.reducedQR(A);
%
% Other m-files required: +LinearAlgebra/gramScmidt.m
% Subfunctions: none
% MAT-files required: none
%
% See also: LINEARALGEBRA.QR, LINEARALGEBRA.GRAMSCHMIDT

% Author: Caleb Logemann
% email: logemann@iastate.edu
% Website: http://www.logemann.public.iastate.edu/
% October 2015; Last revision: 22-October-2015

    p = inputParser;
    p.addRequired('A', @isnumeric)
    p.parse(A);

    [Qhat,Rhat] = LinearAlgebra.gramSchmidt(A);
end
