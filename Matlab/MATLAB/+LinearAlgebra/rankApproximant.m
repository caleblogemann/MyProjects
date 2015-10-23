function [Ak] = rankApproximant(A, k)
%RANKAPPROXIMANT - creates the best approximant of A of rank k
%that is finds A_k such that norm(A - A_k) <= norm(A - B) for all matrices B
%with rank B = k.
%
% Syntax:  Ak = LinearAlgebra.rankApproximant(A, k)
%
% Inputs:
%    A - any matrix
%    k - rank of approximant
%
% Outputs:
%    Ak - matrix of same size as A, such that rank Ak = k
%    and norm(A - Ak) < norm(A - B) for all matrices B with rank k
%
% Example: 
%    A = rand(7);
%    A5 = rankApproximant(A, 5);
%    rank(A5) == 5
%
% Other m-files required: LinearAlgebra.SVD
% Subfunctions: none
% MAT-files required: none
%
% See also: LINEARALGEBRA.NUMERICALRANK, LINEARALGEBRA.SVD

% Author: Caleb Logemann
% email: logemann@iastate.edu
% Website: http://www.logemann.public.iastate.edu/
% October 2015; Last revision: 22-October-2015
    p = inputParser;
    p.addRequired('A', @Utils.isNumericMatrix);
    p.addRequired('k', @Utils.isPositiveInteger);
    p.parse(A, k);

    [m, n] = size(A);
    if(k > n)
        error('Rank input must be less than size of A');
    end

    [U, S, V] = LinearAlgebra.SVD(A);
    singularValues = diag(S);
    % remove extra positive singular values
    % so that only k positive singular values remain
    singularValues(k+1:end) = 0;
    Sk = diag(singularValues);
    Ak = U*Sk*V';
end
