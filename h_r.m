% Define the Rosenbrock function
rosenbrock = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;

% Define the gradient of the Rosenbrock function
gradient = @(x) [-400*(x(2) - x(1)^2)*x(1) - 2*(1 - x(1));
                 200*(x(2) - x(1)^2)];

% Define the Hessian of the Rosenbrock function
hessian = @(x) [-400*(x(2) - 3*x(1)^2) + 2, -400*x(1);
                -400*x(1), 200];

% Starting point for the optimization (can be random or a guess)
x0 = [-1.2, 1];

% Use fminsearch to find the minimum
[x_min, fval] = fminsearch(rosenbrock, x0);

% Display the results
disp('The local minimum is at:')
disp(x_min)
disp('The function value at this minimum is:')
disp(fval)

% Evaluate the gradient at the minimum
grad_at_min = gradient(x_min);
disp('The gradient at the minimum is:')
disp(grad_at_min)

% Evaluate the Hessian at the minimum
hessian_at_min = hessian(x_min);
disp('The Hessian at the minimum is:')
disp(hessian_at_min)
