function [Uhat, Shat, Vhat] = reducedSVD(A, varargin);
% REDUCEDSVD finds a reduced svd decomposition of A, where A is m by n and r = rank A
% A reduced svd decomposition of A is A = Uhat*Shat*Vhat', where Uhat and Vhat
% have orthonormal columns, Uhat is m by r and Vhat is n by r.
% Shat is r by r and is real diagonal with the singular values of A on the diagonal
% Shat = diag(\sigma_1, \sigma_2, ..., \sigma_r) such that
% \sigma_1 >= \sigma_2 >= ... >= \sigma_r
%
% Syntax:  [Uhat, Shat, Vhat] = LinearAlgebra.reducedSVD(A)
%
% Inputs:
%    A - m by n matrix, with rank A = r where 1 <= r <= n
%
% Outputs:
%    UHat - m by r matrix with orthonormal columns
%    Shat - r by r diagonal matrix where diagonal entries are nonzero singular values
%    Vhat - n by r matrix with orthonormal columns
%
% Example: 
%    A = rand(8, 6);
%    [Uhat, Shat, Vhat] = LinearAlgebra.reducedSVD(A);
%    A - Uhat*Shat*Vhat';
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: SVD, LINEARALGEBRA.SVD

% Author: Caleb Logemann
% email: logemann@iastate.edu
% Website: http://www.logemann.public.iastate.edu/
% October 2015; Last revision: 23-October-2015

    p = inputParser;
    p.addRequired('A', @isnumeric);
    p.addOptional('threshold', 10^(-13), @isnumeric);
    p.parse(A, varargin{:});

    [m, n] = size(A);

    % V is eigenvectors
    % D is diagonal with eigenvalues on diagonal
    [V, D] = eig(A'*A);

    % flip so singular values are in descending order
    %Shat = flipud(fliplr(D));
    sortedEigenvalues = flipud(diag(D));
    % threshold eigenvalues
    sortedEigenvalues = sortedEigenvalues(abs(sortedEigenvalues) > p.Results.threshold);
    singularValues = sqrt(sortedEigenvalues);

    % create Shat as diagonal matrix with singular values as diagonal
    Shat = diag(singularValues);
    % rank is same as number of postive singular values
    r = length(singularValues);

    % take eigenvectors A'A associated with r largest eigenvalues
    V = fliplr(V);
    Vhat = V(:,1:r);

    % Define u_i as (A v_i)/sigma_i
    % A*Vhat is A*v_i for all i
    % then divide by singular values
    Uhat = (A*Vhat)./repmat(singularValues', m, 1);
    %Uhat = zeros(m,r);
    %for p = 1:r
    %   Uhat(:,p) = 1/singularValues(p)*A*Vhat(:,p);
    %end
end
