function [Q, R] = QR(A)
%QR - creates a QR decomposition of A
%A QR decomposition of a matrix, A, is a unitary matrix Q and an upper triangular
%matrix R, such that A = QR.
%
% Syntax:  [Q, R] = LinearAlgebra.QR(A)
%
% Inputs:
%    A - m by n matrix, with m > n and full rank, that is rank A = n
%    TODO: allow for n <= m and A not to have full rank
%
% Outputs:
%    Q - m by m unitary matrix
%    R - m by n upper triangular matrix
%
% Example: 
%    A = rand(5);
%    [Q, R] = LinearAlgebra.SVD(A);
%    norm(A - Q*R)
%
% Other m-files required: LinearAlgebra.extendToOrthonormalBasis, LinearAlgebra.reducedQR
% Subfunctions: none
% MAT-files required: none
%
% See also: LINEARALGEBRA.REDUCEDQR, LINEARALGEBRA.GRAMSCHMIDT 

% Author: Caleb Logemann
% email: logemann@iastate.edu
% Website: http://www.logemann.public.iastate.edu/
% October 2015; Last revision: 23-October-2015
    p = inputParser;
    p.addRequired('A', @Utils.isNumericMatrix)
    p.parse(A);

    % TODO: add check for m > n and full rank

    [Qhat, Rhat] = LinearAlgebra.reducedQR(A);

    % extend Qhat to a basis
    Q = LinearAlgebra.extendToOrthonormalBasis(Qhat);
    % fill in zeros of Rhat
    R = zeros(size(A));
    n = length(Rhat);
    R(1:n,1:n) = Rhat;
end
