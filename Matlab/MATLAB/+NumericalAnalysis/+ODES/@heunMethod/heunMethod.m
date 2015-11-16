classdef heunMethod < NumericalAnalysis.ODES.explicitRungeKuttaMethod
%HEUNMETHOD - The heunMethod class represents the heun three stage method for
%numerically approximating the solution of a system of ODES
%The heun method is of order 3
%The Heun method can also be viewed as a three stage RungeKutta Method
%such that alpha = [1/4, 0, 3/4] and lambda = [0, 0, 0; 1/3, 0, 0; 0, 2/3, 0]
%and mu = [0, 1/3, 2/3]
%
% Syntax:  heun = NumericalAnalysis.ODES.heunMethod()
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
        function [obj] = heunMethod()
            alpha = [1/4, 0, 3/4];
            lambda = [0, 0, 0; 1/3, 0, 0; 0, 2/3, 0];
            obj@NumericalAnalysis.ODES.explicitRungeKuttaMethod(alpha, lambda);
        end
    end
end
