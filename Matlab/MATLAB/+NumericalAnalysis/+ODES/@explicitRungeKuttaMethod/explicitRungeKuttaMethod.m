classdef explicitRungeKuttaMethod < NumericalAnalysis.ODES.explicitOneStepMethod
%EXPLICITRUNGEKUTTAMETHOD - The EulerMethod class represents the euler one step method for
%numerically approximating the solution of a system of ODES
%The Euler method is of order 1 and is based on the forward difference
%approximation of the derivative
%
% Syntax:  rk = NumericalAnalysis.ODES.ExplicitRungeKuttaMethod()
%
% Inputs
%    alpha - weights of average of each stage
%    lambda - weights to find each stage based on previous stages
%
% Example:
%    % Heun's Method Example
%    alpha = [1/4, 0, 3/4];
%    lambda = [0, 0, 0; 1/3, 0, 0; 0, 2/3, 0];
%    heun = NumericalAnalysis.ODES.ExplicitRungeKuttaMethod(alpha, lambda);
%    % now use heun to solve you system of ODES with heun.solveSystem
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: EXPLICITONESTEPMETHOD

% Author: Caleb Logemann
% email: logemann@iastate.edu
% Website: http://www.logemann.public.iastate.edu/
% November 2015; Last revision: 16-November-2015
    properties
        % positive integer represents the number of stages
        r

        % coefficients of weights for average
        % stored as row vector
        alpha

        % weights of previous stages used to determine next stage
        lambda

        % sum of rows of lambda
        % represents size of step to next stage
        % stored as column vector
        mu
    end

    methods
        function obj = explicitRungeKuttaMethod(alpha, lambda)
            p = inputParser();
            p.addRequired('alpha', @Utils.isNumericVector);
            p.addRequired('lambda', @(x) Utils.isLowerTriangular(x) && ...
                Utils.isSquareMatrix(x));
            p.parse(alpha, lambda);

            % check inputs further
            % for a consistent method sum of alpha must be one
            if(abs(sum(alpha) - 1) > 10*eps)
                error('For a consistent RungeKutta Method the sum of the alphas must be one');
            end

            % length of alpha must be the same as size of lambda
            if(length(alpha) ~= length(lambda))
                error('The size of alpha and lambda must agree');
            end

            % to be explicit method lambda must be lower triangular with zeros
            % on diagonal
            if(any(diag(lambda)))
                error('For explicit RungeKutta method, the diagonal of lambda must be zeros');
            end

            % make sure alpha is row vector
            if(iscolumn(alpha))
                alpha = alpha.';
            end

            obj.r = length(alpha);
            obj.alpha = alpha;
            obj.lambda = lambda;
            obj.mu = sum(lambda, 2);
        end

        phi = phi(ExplicitRungeKuttaMethod, f, x, y, h);
    end
end
