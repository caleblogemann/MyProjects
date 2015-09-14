function [householderMatrix] = generateHouseholderMatrix(inputVector)
    p = inputParser;
    p.addRequired('inputVector', @Utils.checkNumericVector);
    p.parse(inputVector);

    inputVector = inputVector/norm(inputVector);
    n = length(inputVector);
    householderMatrix = eye(n) - 2*inputVector*inputVector';
end
