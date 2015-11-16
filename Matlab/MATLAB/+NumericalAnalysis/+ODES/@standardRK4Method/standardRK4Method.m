classdef standardRK4Method < NumericalAnalysis.ODES.explicitRungeKuttaMethod
%STANDARDRK4METHOD - The standardRK4Method class represents the standard Runge
%Kutta four stage method for
%numerically approximating the solution of a system of ODES
%The standard RungeKutta four stage method is of order 4
%
% Syntax:  rk4 = NumericalAnalysis.ODES.standardRK4Method()
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
        function [obj] = standardRK4Method()
            alpha = [1/6, 1/3, 1/3, 1/6];
            lambda = [0, 0, 0, 0; 1/2, 0, 0, 0; 0, 1/2, 0, 0; 0, 0, 1, 0];
            obj@NumericalAnalysis.ODES.explicitRungeKuttaMethod(alpha, lambda);
        end
    end
end
