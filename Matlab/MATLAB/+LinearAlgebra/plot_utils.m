%% Miscellaneous plotting utilities for MATH 407/507
%   Written by Kevin Palmowski

%% Detailed example with lots of comments
figure;
hold on;

% Make the aspect ratio of the axes correct
axis equal;

% Plot some dummy data
plot(-20:20, -20:20);

% Draw a circle at (0,0) with radius 5
LinearAlgebra.plot_circle(gca, 0, 0, 5);

% Draw a magenta ('m') circle at (3,4) with radius 2
LinearAlgebra.plot_circle(gca, 3, 4, 2, 'm')
hold off;

% Draw the coordinate axes (always do this last)
LinearAlgebra.draw_axes(gca);

% Labels
title('Plot of dummy data and circles')
xlabel('x')
ylabel('y')


%% Another example
figure;
hold on; axis equal;
plot(3,3,'r.');
LinearAlgebra.plot_circle(gca, 3, 3, 20, 'b');
hold off;
LinearAlgebra.draw_axes(gca);
title('Fake Gershgorin disk')
xlabel('x')
ylabel('y')




