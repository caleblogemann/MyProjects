function [Q] = extendToOrthonormalBasis(A)
% EXTENDTOORTHONORMALBASIS takes an m by k matrix A whose columns are an
% orthonormal set of vectors and returns a matrix Q whose first k columns are
% the same as the columns of A, but whose columns also span all of FF^m
%
% algorithm taken from MATH507 Notes Chapter 4 Remark 4.5.3
%
% Syntax:  Q = LinearAlgebra.extendToOrthonormalBasis(A)
%
% Inputs:
%    A - m by k matrix whose columns are an orthonormal set of vectors
%
% Outputs:
%    Q - m by m unitary matrix whose first k columns are A
%
% Example: 
%    A = rand(8, 4);
%    % make columns of A orthonormal
%    A = LinearAlgebra.gramSchmidt(A);
%    Q = LinearAlgebra.extendToOrthonormalMatrix(A);
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: LINEARALGEBRA.GRAMSCHMIDT

% Author: Caleb Logemann
% email: logemann@iastate.edu
% Website: http://www.logemann.public.iastate.edu/
% October 2015; Last revision: 23-October-2015

    p = inputParser;
    p.addRequired('A', @Utils.isNumericMatrix)
    p.parse(A);

    % TODO: add check that columns of A are orthonormal
    % Possibly gramSchmidt A so that columns are orthonormal

    [m, k] = size(A);

    % since the columns of A are orthonormal
    Q = zeros(m);
    Q(:,1:k) = A;

    epsilon = 5*eps;
    while k < m;
        % choose random m-vector
        w = rand(m, 1);
        % make orthogonal to vectors already in Q
        v = w - Q(:, 1:k)*Q(:,1:k)'*w;

        c = norm(v);
        % if the norm of v is too close to zero do not use as part of basis
        if(c > epsilon)
            Q(:, k+1) = v/c;
            k = k+1;
        end
    end
end
