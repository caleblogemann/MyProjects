function [A] = createTridiag(a, b, c)
    % create a tridiagonal matrix with main diagonal a,
    % lower diagonal b and upper diagonal c

    p = inputParser;
    p.addRequired('a', @Utils.checkNumericVector);
    p.addRequired('b', @Utils.checkNumericVector);
    p.addRequired('c', @Utils.checkNumericVector);
    p.parse(a, b, c);

    if(length(b) ~= length(a) - 1)
        disp('b is not the proper length');
        return;
    end

    if(length(c) ~= length(a) - 1)
        disp('c is not the proper length');
        return;
    end

    A = diag(a);

    for(i=1:length(a)-1);
        A(i+1,i) = b(i);
        A(i,i+1) = c(i);
    end
end
