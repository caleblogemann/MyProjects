function [Q, varargout] = gramSchmidt(A)
% GRAMSCHMIDT performs Gram-Schmidt orthogonalization
%   that is given a set of vectors as the columns of A, create an orthonormal
%   set of vectors whose span is the same as that of the columns of A.
%   Additionally possibly return upper triangular matrix needed for creating
%   reduced QR factorization of A
% Note that the notation/algorithm comes from the Handbook of Linear Algebra
%
% Examples/Sample Usage
%   For creation of orthonormal set
%   U = gramSchmidt(A);
%   For reduced QR factorization
%   [Qhat, Rhat] = gramSchmidt(A);
%
%   A is a complex m by n matrix 
%   needs to be of full rank, that is the columns of A need to be linearly
%   independent

% TODO: put check in to be able to throw away vectors if not linearly
% independent
    p = inputParser;
    p.addRequired('A', @isnumeric);
    p.parse(A);

    [~,n] = size(A);
    W = A;
    Q = zeros(m, n);
    R = zeros(n);

    for i=1:n
        R(i,i) = norm(W(:,i));
        Q(:,i) = W(:,i)/R(i,i);
        for j=i+1:n
            R(i,j) = W(:,j)' * Q(:,i);
            W(:,j) = W(:,j) - R(i,j)*Q(:,i);
        end
    end

    if(nargout >= 2)
        varargout{2} = R;
    end
end

function [Q, vararginout] = gramSchmidt2(A)
% GRAMSCHMIDT2 - see description of GRAMSCHMIDT
% same input, output, and usage just different slightly worse algorithm
% kept for intuitive/completeness purposes
    p = inputParser;
    p.addRequired('A', @isnumeric);
    p.parse(A);
end
