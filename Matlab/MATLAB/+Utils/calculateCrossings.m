function [crossingsArray] = calculateCrossings(data)
    p = inputParser;
    p.addRequired('data', @Utils.checkNumericVector);
    p.parse(data);

    nIterations = 100;
    nElements = length(data);
    nCrossingsArray = zeros(1, nIterations);

    difference = max(data) - min(data);
    heightArray = linspace(max(data) + .01*difference,...
        min(data) - .01*difference, nIterations);

    for i = 1:nIterations
        height = heightArray(i);
        nCrossings = 0;
        isHeightAbove = height > data(1);
        for j = 1:nElements
            if(isHeightAbove && data(j) > height)
                isHeightAbove = false;
                nCrossings = nCrossings + 1;
            elseif(~isHeightAbove && data(j) < height)
                isHeightAbove = true;
                nCrossings = nCrossings + 1;
            %elseif(abs(data(j) - height) < eps) % if data(j) is equal to height
            %    if(j == 1)
            %        nCrossings = nCrossings + 1;
            %        isHeightAbove = data(j + 1) > height;
            %    elseif(j == nElements)
            %        nCrossings = nCrossings + 1;
            %    elseif(~xor(data(j - 1) > height, data(j + 1) > height)) 
            %        % if before and after are same
            %        % intersect a local max or local min
            %        nCrossings = nCrossings + 1;
            %    end
            end
        end
        nCrossingsArray(i) = nCrossings;
    end

    crossingsArray = [heightArray; nCrossingsArray];
end
