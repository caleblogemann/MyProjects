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
%   For reduced QR decomposition
%   [Qhat, Rhat] = gramSchmidt(A);
%
%   A is a complex m by n matrix 
%   needs to be of full rank, that is the columns of A need to be linearly
%   independent
%
%   Q is matrix with orthonormal columns that span the column space of A
%   R is upper triangular matrix with coefficients of projection
%   notation used to model the fact that this algorithm can be used to create
%   reduced QR decomposition

% TODO: put check in to be able to throw away vectors if not linearly
% independent
    p = inputParser;
    p.addRequired('A', @isnumeric);
    p.parse(A);

    [m,n] = size(A);
    W = A;
    Q = zeros(m, n);
    R = zeros(n);

    for i=1:n
        % normalize next vector
        % know that this vector is orthogonal to all preceding vectors
        R(i,i) = norm(W(:,i));
        % TODO: check if R(i,i) or norm is zero
        Q(:,i) = W(:,i)/R(i,i);

        % remove orthogonal projection of q_i from all future vectors
        for j=i+1:n
            % find projection of q_i onto w_j
            R(i,j) = W(:,j)' * Q(:,i);
            % remove projection from w_j
            W(:,j) = W(:,j) - R(i,j)*Q(:,i);
        end
    end

    % possibly return R as well
    varargout{1} = R;
end

function [Q, vararginout] = gramSchmidt2(A)
% GRAMSCHMIDT2 - see description of GRAMSCHMIDT
% same input, output, and usage just different slightly worse algorithm
% kept for intuitive/completeness purposes
    p = inputParser;
    p.addRequired('A', @isnumeric);
    p.parse(A);

    [m, n] = size(A);
    Q = zeros(m, n);
    R = zeros(n);
    for j=1:n
        % get next vector in set
        Q(:,j) = A(:,j);

        % make vector orthogonal to all vectors arleady in orthonormal set
        for i=1:j-1
            R(i,j) = A(:,j)' * Q(:,j);
            Q(:,j) = Q(:,j) - R(i,j)*Q(:,j);
        end
        % vector is now orthogonal to set, now normalize
        R(j,j) = norm(Q(:,j));
        % TODO: check if R(j,j) or norm is zero
        Q(:,j) = Q(:,j)/R(j,j);
    end
end
