classdef eulerMethod < NumericalAnalysis.ODES.explicitRungeKuttaMethod
%EULERMETHOD - The eulerMethod class represents the euler one step method for
%numerically approximating the solution of a system of ODES
%The Euler method is of order 1 and is based on the forward difference
%approximation of the derivative
%The Euler method can also be viewed as a one stage RungeKutta Method
%such that alpha = 1 and lambda = mu = 0
%
% Syntax:  euler = NumericalAnalysis.ODES.eulerMethod()
%
% no inputs necessary for creation of object
%
% Example: see syntax
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: EXPLICITRUNGEKUTTAMETHOD

% Author: Caleb Logemann
% email: logemann@iastate.edu
% Website: http://www.logemann.public.iastate.edu/
% November 2015; Last revision: 16-November-2015
    methods
        function [obj] = eulerMethod()
            alpha = [1];
            lambda = [0];
            obj@NumericalAnalysis.ODES.explicitRungeKuttaMethod(alpha, lambda);
        end
    end
end
