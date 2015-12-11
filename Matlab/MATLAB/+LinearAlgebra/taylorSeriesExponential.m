function [eA] = taylorSeriesExponential(A, l)
    eA = eye(size(A));
    for i=1:l
        eA = eA + 1/factorial(i) * A^i;
    end
end
