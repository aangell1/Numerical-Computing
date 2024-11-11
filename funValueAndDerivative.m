function [value, derivative] = funValueAndDerivative(x)
    value = exp(2*sin(x)) - x; % The function value
    if nargout > 1
        derivative = 2*exp(2*sin(x)).*cos(x) - 1; % The derivative
    end
end
