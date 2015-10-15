function [Q] = extendToOrthonormalBasis(A)
% EXTENDTOORTHONORMALBASIS takes a m by k matrix A whose columns are an
% orthonormal set of vectors and returns a matrix Q whose first k columns are
% the same as the columns of A, but whose columns also span all of FF^m
%
% algorithm taken from MATH507 Notes Chapter 4 Remark 4.5.3

    p = inputParser;
    p.addRequired('A', @isnumeric)
    p.parse(A);

    % TODO: add check that columns of A are orthonormal

    [m, k] = size(A);
    % since the columns of A are orthonormal
    Q = zeros(m);
    Q(:,1:k) = A;

    epsilon = 5*eps;
    while k < m;
        % choose random m-vector
        w = rand(m, 1);
        % make orthogonal to vectors aleardy in Q
        v = w - Q(:,1:k)'*w;

        c = norm(v);
        % if the norm of v is too close to zero do not use as part of basis
        if(c > epsilon)
            q(:, k+1) = v/c;
            k = k+1;
        end
    end
end
