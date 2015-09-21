function [lambdaN] = calculateLebesgueConstant(n, varargin)
    p = inputParser;
    p.addRequired('n', @Utils.checkInteger);
    p.addParameter('UseSinglePrecision', false, @islogical);
    p.parse(n, varargin{:});

    k = 1:n;
    if(p.Results.UseSinglePrecision)
        lambdaN = single(1/(2*n + 1)) + single(2/pi)*sum(single(tan(k*pi/(2*n+1))));
    else
        lambdaN = 1/(2*n + 1) + 2/pi*sum(tan(k*pi/(2*n+1))./k);
    end
end
