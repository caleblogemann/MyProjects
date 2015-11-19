function [x] = backsolve(R, b)
% BACKSOLVE solves the matrix equation Rx = b, where R is upper triangular
%
% Syntax: x = LinearAlgebra.backsolve(R, b)
%
% Inputs:
%    R - m by n upper triangular matrix, with m >= n
%    b - vector of length m
%
% Outputs:
%    x - vector of length n, such that Rx = b
%
% Example: 
%    R = triu(rand(5));
%    b = rand(5,1);
%    x = LinearAlgebra.backsolve(R,b);
%
% Other m-files required: Utils.isNumericVector
% Subfunctions: none
% MAT-files required: none
%
% See also: LINEARALGEBRA.LEASTSQUARES

% Author: Caleb Logemann
% email: logemann@iastate.edu
% Website: http://www.logemann.public.iastate.edu/
% October 2015; Last revision: 23-October-2015

    p = inputParser;
    p.addRequired('R', @istriu);
    p.addRequired('b', @Utils.isNumericVector)
    p.parse(R,b)

    [m, n] = size(R);
    x = zeros(n,1);

    for i=n:-1:1
        for j=n:-1:(i+1)
            b(i) = b(i) - R(i,j)*x(j);
        end
        x(i) = b(i)/R(i,i);
    end
end
