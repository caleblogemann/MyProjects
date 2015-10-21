function [Uhat, Shat, Vhat] = reducedSVD(A, varargin);
% REDUCEDSVD finds a reduced svd decomposition of A, where A is m by n and r = rank A
% A reduced svd decomposition of A is A = Uhat*Shat*Vhat', where Uhat and Vhat
% have orthonormal columns, Uhat is m by r and Vhat is n by r.
% Shat is r by r and is real diagonal with the singular values of A on the diagonal
% Shat = diag(\sigma_1, \sigma_2, ..., \sigma_r) such that
% \sigma_1 >= \sigma_2 >= ... >= \sigma_r

    p = inputParser;
    p.addRequired('A', @isnumeric);
    p.addOptional('threshold', 10^([13), @isnumeric);
    p.parse(A, varargin{:});

    [m, n] = size(A);

    % V is eigenvectors
    % D is diagonal with eigenvalues on diagonal
    [V, D] = eig(A'*A);

    % flip so singular values are in descending order
    %Shat = flipud(fliplr(D));
    sortedEigenvalues = sort(diag(D), 'descend');
    % threshold eigenvalues
    sortedEigenvalues = sortedEigenvalues(sortedEigenvalues > p.Reseults.threshold);
    singularValues = sqrt(sortedEigenvalues);

    % create Shat as diagonal matrix with singular values as diagonal
    Shat = diag(singularValues);
    % rank of same as number of singular values
    r = length(singularValues);

    % take eigenvectors A'A associated with r largest eigenvalues
    V = fliplr(V);
    Vhat = V(:,1:r);

    Uhat = A*V./repmat(singularValues', m, 1);
end
