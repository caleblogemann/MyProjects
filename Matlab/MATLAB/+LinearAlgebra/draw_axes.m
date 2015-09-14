function [] = draw_axes(ax)
%% function [] = draw_axes(ax)
%   Draws coordinate axes on the axis object ax.
%
%   Ex. Draw the axes on a graph.
%       figure;
%       plot(-20:20, -20:20);
%       draw_axes(gca);
%


%%
xLim = get(ax, 'XLim');
xmin = xLim(1);
xmax = xLim(2);

yLim = get(ax, 'YLim');
ymin = yLim(1);
ymax = yLim(2);

% Values to plot, no big deal here
yaxisvals = floor(ymin):ceil(ymax);
xaxisvals = floor(xmin):ceil(xmax);

% Plot the axes
hold on;
plot(ax, zeros(length(yaxisvals)), yaxisvals, 'k-');
plot(ax, xaxisvals, zeros(length(xaxisvals)), 'k-');
hold off;

end
