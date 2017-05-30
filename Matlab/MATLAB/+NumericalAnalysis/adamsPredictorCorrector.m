function [u] = adamsPredictorCorrector(f, a, b, y0, N)
%ADAMSPREDICTORCORRECTOR - function to apply the 4 step explicit Adams Predictor correct method
%to a ODE
%The Predictor Corrector method first uses the explicit four step Adams Bashforth
%method to approximate the next step, then uses the implicit Adams Moulton method
%to correct this this value.
%It uses the previously found value in the implicit method and so does not
%require solving a system of equations.
%
%
% Syntax: u = NumericalAnalysis.adamsBashforth(f, a, b, y0, N);
%
% Inputs:
%    f - function that takes two inputs x and y and defines the ODE
%    a - beginning of interval to integrate
%    b - end of interval to integrate must be greater than a
%    y0 - initial value for solution, y(a)
%    N - total number of points to use in the interval [a, b]
%
% Outputs:
%    u - output solution numerical approximation of ODE 
%
% Example:
%    f = @(x, y) y;
%    a = 0;
%    b = 1;
%    y0 = 1;
%    N = 100;
%    u = NumericalAnalysis.adamsPredictorCorrector(f, a, b, y0, N);
%    x = linspace(a, b, N);
%    % plot exact and numerical solution
%    plot(x, exp(x), 'r', x, u, 'bo');
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: ADAMSBASHFORTH4

% Author: Caleb Logemann
% email: logemann@iastate.edu
% Website: http://www.logemann.public.iastate.edu/
% December 2015; Last revision: 3-December-2015
    p = inputParser;
    p.addRequired('f', @Utils.isFunctionHandle);
    p.addRequired('a', @isnumeric);
    p.addRequired('b', @isnumeric);
    p.addRequired('y0', @isnumeric);
    p.addRequired('N', @Utils.isPositiveInteger);
    p.parse(f, a, b, y0, N);

    % error checking
    if(a >= b)
        error('a must be less than b in order to define the interval');
    end
    if(N < 4)
        error('adamsPredictorCorrector4 must be applied on more than 4 steps');
    end

    % find even spacing
    h = (b - a)/(N-1);

    % create column vector to store solution
    u = zeros(N, 1);

    % create vector for x values
    x = a:h:b;

    % initialize first 4 values with RK4 method
    rk4 = NumericalAnalysis.ODES.standardRK4Method();
    u(1:4) = rk4.solveSystem(f, x(1:4), y0);

    % perform 4-th order Adams Bashforth for remainder of interval
    f4 = f(x(1), u(1));
    f3 = f(x(2), u(2));
    f2 = f(x(3), u(3));
    for n=5:N
        % calculate f1
        % f2, f3, f4 were calculated previously
        f1 = f(x(n-1), u(n-1));

        % calculate next predicted value of u
        uStar = u(n-1) + h/24*(55*f1 - 59*f2 + 37*f3 - 9*f4);

        fStar = f(x(n), uStar);
        % correct next value of u with Adams Moulton method
        u(n) = u(n-1) + h/24*(9*fStar + 19*f1 - 5*f2 + f3);

        % move f values back one
        % reassign so that the values don't have to be recomputed
        f4 = f3;
        f3 = f2;
        f2 = f1;
    end
end
