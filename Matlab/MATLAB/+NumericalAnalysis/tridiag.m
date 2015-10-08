function [y] = tridiag(n, a, b, c, v);
    % solve a tridiagonal system with Gaussian elimination
    % (a_1 c_1   0   0                  0  )(   y_1   )  (   v_1   )
    % (b_1 a_2 c_2   0                  0  )(   y_2   )  (   v_2   )
    % (  0 b_2 a_3 c_3                  0  )(   y_3   )= (   v_3   )
    % (  0                              0  )(         )= (         )
    % (  .                  a_{n-1} c_{n-1})( y_{n-1} )  ( v_{n-1} )
    % (  0                  b_{n-1}    a_n )(   y_n   )  (   v_n   )

    p = inputParser;
    p.addRequired('n', @Utils.checkPositiveInteger);
    p.addRequired('a', @Utils.checkNumericVector);
    p.addRequired('b', @Utils.checkNumericVector);
    p.addRequired('c', @Utils.checkNumericVector);
    p.addRequired('v', @Utils.checkNumericVector);
    p.parse(n, a, b, c, v);

    % error checking
    if(length(a) ~= n)
        disp('The vector a should have length n');
        return;
    end

    if(length(v) ~= n)
        disp('The vector v should have length n')
        return;
    end

    if(length(b) ~= n-1)
        disp('The vector b should have length n-1')
        return;
    end

    if(length(c) ~= n-1)
        disp('The vector c should have length n-1')
        return;
    end

    % create array zero to store solutions
    y = zeros(size(v));

    % eliminate b_i's 
    for(i=1:n-1)
        a(i+1) = a(i+1) + c(i)*(-b(i)/a(i));
        v(i+1) = v(i+1) + v(i)*(-b(i)/a(i));
    end

    % solve for y_n
    y(n) = v(n)/a(n);

    for(i=(n-1):-1:1)
        y(i) = (v(i) - c(i)*y(i+1))/a(i);
    end

end
