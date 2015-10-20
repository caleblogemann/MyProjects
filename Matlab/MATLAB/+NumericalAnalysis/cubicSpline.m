function [c0, c1, c2, c3] = cubicSpline(x, f)
    p = inputParser;
    p.addRequired('x', @Utils.checkNumericVector);
    p.addRequired('f', @Utils.checkNumericVector);
    p.parse(x, f);

    % error checking
    if(length(x) ~= length(f))
        error('The lengths of x and f do not match');
    end

    % find deltaX and first divided differences
    deltaX = diff(x); % for 1 <= 1 <= n-1, deltaX(i) = x_{i+1} - x_i
    ddf = diff(f)./deltaX; % ddf(i) = [x_i, x_{i+1}]f = (f_{i+1} - f_i)(x_{i+1} - x_i)

    n = length(x);
    % cubicSpline results in tridiagonal system, so need to find a, b, c, and v for
    % m = tridiag(n, a, b, c, v), where m is coefficients for Hermite interpolation on
    % each interval
    a = zeros(n, 1);
    b = zeros(n-1,1);
    c = b;

    % common parts determined by continuity of second derivative at x_i for 2 <= i <= n-1
    % center diagonal
    a(2:n-1) = 2*(deltaX(2:n-1) + deltaX(1:n-2));
    b(1:n-2) = deltaX(2:n-1);
    c(2:n-1) = deltaX(1:n-2);
    v(2:n-1) = 3*(deltaX(1:n-2).*ddf(2:n-1) + deltaX(2:n-1).*ddf(1:n-2));

    % special by type of cubic spline
    % TODO: create more options than just natural cubic spline and
    % allow use to select type of cubic spline in input

    % natural cubic spline
    % first point p_1''(x_1) = 0
    a(1) = 2;
    c(1) = 1;
    v(1) = 3*ddf(1);
    % second point p_{n-1}''(x_n) = 0
    a(n) = 2;
    b(n-1) = 1;
    v(n) = 3*ddf(n-1);

    % tridiagonal system fully formed 
    m = NumericalAnalysis.tridiag(n, a, b, c, v);

    % now that the values of m have been found, the coefficients of the interpolating
    % polynomials can be found.
    c0 = f(1:n-1);
    c1 = m(1:n-1);
    c2 = (3*ddf(1:n-1) - 2*m(1:n-1) - m(2:n))./deltaX(1:n-1);
    c3 = (m(2:n) + m(1:n-1) - 2*ddf(1:n-1))./(deltaX(1:n-1).^2);
end
