function [result] = isFunctionHandle(x)
    result = isa(x, 'function_handle');
end
