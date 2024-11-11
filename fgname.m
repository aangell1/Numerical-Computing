% Define the objective function for the optimization problem
function [f, grad] = fgname(x)
    % Objective function f(x) = x1^2 + x2^2
    f = x(1)^2 + x(2)^2;
    % Gradient of the objective function
    grad = [2*x(1); 2*x(2)];
end

