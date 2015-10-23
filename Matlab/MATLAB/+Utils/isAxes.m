function [result] = isAxes(x)
    result = isa(x, 'matlab.graphics.axis.Axes');
end
