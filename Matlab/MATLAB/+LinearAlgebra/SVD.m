function [U, S, V] = SVD(A)
    p =inputParser;
    p.addRequired('A', @isnumeric);
    p.parse(A);



end
