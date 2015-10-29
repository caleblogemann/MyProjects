function [T] = rombergIntegration(f, a, b, n)
%ROMBERGINTEGRATION - Generate Romberg n by n matrix of integration
%approximations of f on the interval (a, b)
%Optional file header info (to give more details about the function than in the H1 line)
%Optional file header info (to give more details about the function than in the H1 line)
%Optional file header info (to give more details about the function than in the H1 line)
%
% Syntax:  T = NumericalAnalysis.rombergIntegration(f, a, b, n)
%
% Inputs:
%    a - beginning of interval
%    b - end of interval
%    n - number of rows to generate
%    f - function to integrate - must be function handle that accepts single
%       variable input
%
% Outputs:
%    T - n by n lower triangular matrix containing approximations of integral of
%       f(x) from x = a to x = b. T(n, n) should be best approximation or 
%       approximation of highest order
%
% Example: 
%    a = 1;
%    b = 2;
%    n = 10;
%    f = @(x) exp(x)/x;
%    T = NumericalAnalysis.rombergIntegration(f, a, b, n);
%    T(n, n)
%
% Other m-files required: none
% Subfunctions: trapRule, midPointRule, computeHk
% MAT-files required: none
%
% See also: 

% Author: Caleb Logemann
% email: logemann@iastate.edu
% Website: http://www.logemann.public.iastate.edu/
% October 2015; Last revision: 29-October-2015
    p = inputParser;
    p.addRequired('a', @isnumeric);
    p.addRequired('b', @isnumeric);
    p.addRequired('n', @Utils.isPositiveInteger);
    p.addRequired('f', @Utils.isFunctionHandle);
    p.parse(a, b, n, f);

    T = zeros(n);

    T(1,1) = trapRule(a, b, 0, f);
    % iterate down rows
    for i = 2:n
        T(i,1) = 1/2 * (trapRule(a, b, i-1, f) + midPointRule(a, b, i-1, f));
        % iterate down columns to diagonal
        for j = 2:i
            T(i,j) = T(i,j-1) + (T(i,j-1) - T(i-1, j-1))/(4^i - 1);
        end
    end
end

function t = trapRule(a, b, k, f)
    hk = computeHK(a, b, k);
    r = 1:(2^k-1);
    functionValues = arrayfun(f, a + r * hk);
    t = hk*(1/2 * f(a) + sum(functionValues) + 1/2 * f(b));
end

function m = midPointRule(a, b, k, f)
    hk = computeHK(a, b, k);
    r = 1:2^k;
    functionValues = arrayfun(f, a + (r - 1/2) * hk);
    m = hk * sum(functionValues);
end

function hk = computeHK(a, b, k)
    hk = (b-a)/2^k;
end
