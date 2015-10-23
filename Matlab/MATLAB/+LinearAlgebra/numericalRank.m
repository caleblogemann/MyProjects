function [r] = numericalRank(A, e, varargin)
% NUMERICALRANK calculates the numerical rank of A given a threshold e
% optionally specify the norm to use, defaults to '2'-norm.
% other possibilities include 'Frobenius' and 'Nuclear'
%
% Syntax: r = LinearAlgebra.numericalRank(A, e)
%
% Inputs:
%    A - m by n matrix
%    e - epsilon to use for determining numerical rank
%    Optional
%       'norm' - String indicating which norm to use, '2' for 2-norm,
%       'Frobenius' for Frobenius Norm, and 'Nuclear' for Nuclear norm
%
% Outputs:
%    r - The numerical rank of A given e
%
% Example: 
%    A = rand(5,2);
%    e = 10^(-8)
%    r = LinearAlgebra.numericalRank(A,e);
%
% Other m-files required: LinearAlgebra.reducedSVD
% Subfunctions: none
% MAT-files required: none
%
% See also: LINEARALGEBRA.REDUCEDSVD, 

% Author: Caleb Logemann
% email: logemann@iastate.edu
% Website: http://www.logemann.public.iastate.edu/
% October 2015; Last revision: 22-October-2015
    TWO_NORM = '2';
    FROBENIUS = 'Frobenius';
    NUCLEAR = 'Nuclear';

    p = inputParser;
    p.addRequired('A', @Utils.isNumericMatrix);
    p.addRequired('e', @isnumeric);
    p.addOptional('norm', '2', @(x)validatestring(x, {TWO_NORM, FROBENIUS, NUCLEAR}));
    p.parse(A, e, varargin{:});

    [~, Shat, ~] = LinearAlgebra.reducedSVD(A);
    singularValues = diag(Shat);

    if(strcmp(p.Results.norm, TWO_NORM))
        rankDeterminant = singularValues;
    elseif(strcmp(p.Results.norm, FROBENIUS))
        rankDeterminant = sqrt(cumsum(singularValues.^2, 'reverse'));
    else % NUCLEAR
        rankDeterminant = cumsum(singularValues, 'reverse');
    end
    r = length(rankDeterminant(rankDeterminant > e));
end


