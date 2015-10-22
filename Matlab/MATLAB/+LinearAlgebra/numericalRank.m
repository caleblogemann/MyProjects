function [r] = numericalRank(A, e, varargin)
% NUMERICALRANK calculates the numerical rank of A given a threshold e
% optionally specify the norm to use, defaults to '2'-norm.
% other possibilities include 'Frobenius' and 'Nuclear'
    TWO_NORM = '2';
    FROBENIUS = 'Frobenius';
    NUCLEAR = 'Nuclear';

    p = inputParser;
    p.addRequired('A', @isnumeric);
    p.addRequired('e', @isnumeric);
    p.addOptional('norm', '2', @validatestring(x, {TWO_NORM, FROBENIUS, NUCLEAR});
    p.parse(A, e, varargin{:});

    [~, Shat, ~] = LinearAlgebra.reducedSVD(A);
    singularValues = diag(Shat);

    rankDeterminant;
    if(strcmp(p.Results.norm, TWO_NORM))
        rankDeterminant = singularValues
    elseif(strcmp(p.Results.norm, FROBENIUS))
        rankDeterminant = sqrt(cumsum(singularValues.^2, 'reverse'));
    else % NUCLEAR
        rankDeterminant = cumsum(singularValues, 'reverse');
    end
    r = length(rankDeterminant(rankDeterminant > e));
end


