function [U, S, V] = SVD(A, varargin)
%SVD - computes a singular value decomposition of A
%A singular value decomposition of A a set of matrices, U, S, V
%where U and V are unitary, S is diagonal, and A = USV'
%
% Syntax:  [U, S, V] = LinearAlgebra.SVD(A)
%
% Inputs:
%    A - m by n matrix
%
% Outputs:
%    U - m by m unitary matrix
%    S - m by n diagonal matrix with the singular values of A on the diagonal
%    V - n by n unitary matrix
%
% Example: 
%    A = rand(8,6);
%    [U, S, V] = LinearAlgebra.SVD(A);
%    A - U*S*V'
%
% Other m-files required: LinearAlgebra.reducedSVD, Utils.isNumericMatrix
% Subfunctions: none
% MAT-files required: none
%
% See also: SVD, LINEARALGEBRA.REDUCEDSVD, LINEARALGEBRA.NUMERICALRANK

% Author: Caleb Logemann
% email: logemann@iastate.edu
% Website: http://www.logemann.public.iastate.edu/
% October 2015; Last revision: 23-October-2015

    p =inputParser;
    p.addRequired('A', @Utils.isNumericMatrix);
    p.addOptional('threshold', 10^(-13), @isnumeric);
    p.parse(A, varargin{:});

    [Uhat, Shat, Vhat] = LinearAlgebra.reducedSVD(A, p.Results.threshold);
    U = LinearAlgebra.extendToOrthonormalBasis(Uhat);
    V = LinearAlgebra.extendToOrthonormalBasis(Vhat);

    r = length(Shat);
    S = zeros(size(A));
    S(1:r, 1:r) = Shat;
end
