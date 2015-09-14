function [result] = checkAxes(x)
    result = isa(x, 'matlab.graphics.axis.Axes');
end
