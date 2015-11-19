function [y] = solveSystem(explicitOneStepMethod, f, x, yInit)
%SOLVESYSTEM - function to apply an explicit one step method to a
%system of ODEs and find a numerical solution
%This function is part of the explicitOneStepMethod Class
%As such the onject this method is attached to is passed in as first argument
%
% Where Phi is an NumericalAnalysis explicitOneStepMethod object
% Syntax:  [y] = Phi.solveSystem(f, x, yInit)
%
% Inputs:
%    f - function describing system of ODEs, must accept as input vector the
%       size of yInit
%    x - set of real numbers that the 
%    yInit - the initial value of the system at x(1);
%
% Outputs:
%    y - matrix whose columns are points found numerically to approximate
%       the solution to the system of ODEs
%
% Example: %TODO add example
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: 

% Author: Caleb Logemann
% email: logemann@iastate.edu
% Website: http://www.logemann.public.iastate.edu/
% November 2015; Last revision: 15-November-2015
    p = inputParser;
    p.addRequired('f', @Utils.isFunctionHandle);
    p.addRequired('x', @Utils.isGridFunction);
    p.addRequired('yInit', @Utils.isNumericVector);
    p.parse(f, x, yInit);

    % find all of the step sizes
    h = diff(x);
    n = length(x);

    % set up matrix to store solution
    y = zeros(length(yInit), n);
    y(:, 1) = yInit;

    for i = 1:n-1
        % find the next value of y
        y(:, i+1) = y(:,i) + h(i)*explicitOneStepMethod.phi(f, x(i), y(:,i), h(i));
    end
end
