function [x] = backsolve(R, b)
% BACKSOLVE solves the matrix equation Rx = b, where R is upper triangular
% Assume R is m by n and m >= n

    p = inputParser;
    p.addRequired('R', @istriu);
    p.addRequired('b', @Utils.isNumericVector)
    p.parse(R,b)

    [m, n] = size(R);
    x = zeros(n,1);

    for i=n:-1:1
        for j=n:-1:(i+1)
            b(i) = b(i) - R(i,j)*x(j);
        end
        x(i) = b(i)/R(i,i);
    end
end
