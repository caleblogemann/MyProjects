function [phi] = phi(explicitRungeKuttaMethod, f, x, y, h)
%PHI - calculates phi for the ExplicitRungeKuttaMethod class
%
% Syntax:  phi = rk.phi(f, x, y, h)
% rk is a NumericalAnalysis.ODES.ExplicitRungeKuttaMethod object
%
% Inputs:
%    f - function that defines the system of ODEs
%    x - number representing current place on grid function
%    y - current value of system at x
%    h - step size to next value of x
%
% Outputs:
%    phi - next value of y is calculated as y + h*phi
%
% Example: 
%    % alpha and lambda for Heun's method
%    alpha = [1/4, 0, 3/14];
%    lambda = [0, 0, 0; 1/3, 0, 0; 0, 2/3, 0];
%    rk = NumericalAnalysis.ODES.ExplicitRungeKuttaMethod(alpha, lambda);
%    f = @(x, y) x*y;
%    x = 1;
%    y = 2;
%    h = 1;
%    phi = rk.phi(f, x, y, h);
%    yNext = y + h*phi;
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: ODEEXPLICITONESTEPMETHOD, ODEEXPLICITONESTEPMETHOD.SOLVESYSTEM

% Author: Caleb Logemann
% email: logemann@iastate.edu
% Website: http://www.logemann.public.iastate.edu/
% November 2015; Last revision: 16-November-2015
    p = inputParser();
    p.addRequired('f', @Utils.isFunctionHandle);
    p.addRequired('x', @Utils.isNumber);
    p.addRequired('y', @Utils.isNumericVector);
    p.addRequired('h', @Utils.isNumber);
    p.parse(f, x, y, h);


    k = zeros(length(y), explicitRungeKuttaMethod.r);
    for i=1:explicitRungeKuttaMethod.r
        k(:,i) = f(x + explicitRungeKuttaMethod.mu(i)*h, y + h*k*explicitRungeKuttaMethod.lambda(i, :).');
    end
    phi = k*explicitRungeKuttaMethod.alpha.';
end
