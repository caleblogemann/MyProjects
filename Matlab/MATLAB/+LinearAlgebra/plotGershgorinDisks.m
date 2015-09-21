function [f] = plotGershgorinDisks(A, varargin)
    p = inputParser;
    p.addRequired('A', @Utils.checkSquareNumericMatrix);
    p.addParameter('Axes', -1, @Utils.checkAxes);
    p.addParameter('DiskColor', 'k', @ischar);
    p.addParameter('FigureTitle', 'Gershgorin Disks', @ischar);
    p.parse(A, varargin{:});

    % Determine if a
    if(p.Results.Axes == -1)
        f = figure('units', 'normalized', 'outerposition', [0 0 1 1]);
        axis equal;
        ax = gca;
    else
        ax = p.Results.Axes;
    end

    hold on

    n = length(A);
    % get eigenvalues
    lambda = eig(A);
    for i=1:n
        % compute row sum
        r = sum(abs(A(i, :))) - abs(A(i, i));
        % compute center
        x = real(A(i, i));
        y = imag(A(i, i));

        LinearAlgebra.plot_circle(ax, x, y, r, p.Results.DiskColor);

        % get ith eigenvalue
        lambdaX = real(lambda(i));
        lambdaY = imag(lambda(i));
        plot(lambdaX, lambdaY, 'k.', 'MarkerSize', 30);
    end

    LinearAlgebra.draw_axes(ax);
    xlabel('Real Axis');
    ylabel('Imaginary Axis');
    title('Gershgorin Disks');
    hold off
end

