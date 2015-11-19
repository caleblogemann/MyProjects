classdef (Abstract) explicitOneStepMethod
%EXPLICITONESTEPMETHOD - Abstract class to represent the generic way to solve
%a system of ODEs via an explicit one step method
%
%A method is one step if it only considers the information from the previous step
%A method is explicit if the next step can be found using current information
%An implicit method generally requires solving an system of equations
%
% This is an abstract class and cannot be instantiated
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none

% Author: Caleb Logemann
% email: logemann@iastate.edu
% Website: http://www.logemann.public.iastate.edu/
% November 2015; Last revision: 16-November-2015

    methods (Abstract)
        phi = phi(f, x, y, h);
    end

    methods 
        y = solveSystem(ExplicitOneStepMethod, f, x, yInit);
    end
    
end

