function [x] = gmres(A, b, x, max_iterations, tolerance)
    n = length(x);
    m = max_iterations;

    % residual
    r = b - A*x;

    b_norm = norm(b);
    r_norm = norm(r);

    err = r_norm/b_norm;

    sn = zeros(m, 1);
    cs = zeros(m, 1);
    e1 = zeros(n, 1);
    e1(1) = 1;

    Q = zeros(n, m);
    Q(:,1) = r/r_norm;
     = r_norm*e1;

    for k = 1:m

    end
end
