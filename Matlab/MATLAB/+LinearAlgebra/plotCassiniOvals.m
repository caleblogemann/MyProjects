function [f] = plotCassiniOvals(A)
    p = inputParser;
    p.addRequired('A', @Utils.checkSquareNumericVector);
    p.parse(A);

    f = figure
end
