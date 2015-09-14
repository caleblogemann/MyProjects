function [] = plot_circle(ax, x0, y0, r, varargin)
%% function [] = plot_circle(ax, x0, y0, r, S)
%   Plots a circle on axis object ax with center at (x0,y0) and radius r.
%   Optionally, a format specifier S (see >> help plot) can be passed.
%
%   Ex. Plot a circle onto the current axis object
%
%       figure;
%       axis equal;
%       plot(1:20, 1:20);
%       plot_circle(gca, 10, 10, 5);
%
%   Ex. Plot a black circle, radius 4, at (3,1) onto a specifed axis object
%       
%       figure;
%       ax = axes;
%       axis equal;
%       plot_circle(ax, 3, 1, 4, 'k');
%

%%
% Set up a partition of [0,2*pi]
t = linspace(0,2*pi,100);

% x- and y-values to plot
xvals = x0 + r*cos(t);
yvals = y0 + r*sin(t);

% Plot the circle
if length(varargin) == 1
    plot(ax, xvals, yvals, varargin{1});
else
    plot(ax, xvals, yvals);
end

end
