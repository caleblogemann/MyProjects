function [indexOfMaximum] = findLocalMax(list, window)

    p = inputParser;
    p.addRequired('list', @Utils.checkNumericVector);
    p.addRequired('window', @Utils.checkPositiveInteger);
    p.parse(list, window);

    l = length(list);

    a = 1;
    b = window + 1;
    c = 2*window + 1;

    % four possibilites
    % list(a) > list(b) > list(c) - descending
    % list(a) < list(b) < list(c) - ascending
    % list(a) > list(b) & list(b) < list(c) - local minimum
    % list(a) < list(b) & list(b) > list(c) - local maximum **

    while c < l 
        if(min(list(b) - list(a), list(b) - list(c)) > eps('double'))
            indexOfMaximum = b;
            return;
        end
        a = a + 1;
        b = b + 1;
        c = c + 1;
    end

    indexOfMaximum = -1;
end
