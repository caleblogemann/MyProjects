classdef standardRK3Method < NumericalAnalysis.ODES.explicitRungeKuttaMethod
%STANDARDRK3METHOD - The standardRK3Method class represents the standard Runge
%Kutta three stage method for
%numerically approximating the solution of a system of ODES
%The standard RungeKutta three stage method is of order 3
%
% Syntax:  rk3 = NumericalAnalysis.ODES.standardRK3Method()
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
        function [obj] = standardRK3Method()
            alpha = [1/6, 2/3, 1/6];
            lambda = [0, 0, 0; 1/2, 0, 0; -1, 2, 0];
            obj@NumericalAnalysis.ODES.explicitRungeKuttaMethod(alpha, lambda);
        end
    end
end
