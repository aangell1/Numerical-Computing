function [f, grad, gradTwo] = Rosen(x)
    % Ensure that x is a column vector
    x = x(:);

    % Calculate the Rosenbrock function value at x
    f = 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;

    % Calculate the gradient of the Rosenbrock function at x
    grad = [-400*(x(2) - x(1)^2)*x(1) - 2*(1 - x(1));
             200*(x(2) - x(1)^2)];

    % Calculate the Hessian matrix of the Rosenbrock function at x
    gradTwo = [-400*(x(2) - 3*x(1)^2) + 2, -400*x(1);
               -400*x(1), 200];
end
