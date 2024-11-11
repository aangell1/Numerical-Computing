% Define the objective function (this could be a separate function file if you prefer)
objective_function = @(x) x(1)^2 + x(2)^2;
% Define the constraint function (also could be separate if you prefer)
constraint_function = @(x) (x(1) - 2)^2 + x(2)^2 - 1;

% Initialize parameters for the Quadratic Penalty Algorithm
x0 = [4, 2]; % Initial guess
mu = 1.0; % Initial penalty coefficient
tau = 1e-3; % Tolerance for stopping criterion
c1 = 1e-6; % Wolfe parameter
c2 = 0.99; % Wolfe parameter

% Run the Quadratic Penalty Algorithm
while true
    % Minimize the augmented Lagrangian using BFGS
    [x, f, grad, steps, xvec] = bfgs(x0, c1, c2, @(x) penalty_function(x, mu), 1);
    
    % Check convergence
    if norm(grad) <= tau
        break;
    end
    
    % Update parameters for the next iteration
    mu = mu / 2;
    tau = tau / 2;
    x0 = x; % New initial guess for BFGS
end

% Output the solution
disp('Optimized solution:');
disp(x);

% Here you could also add plotting commands if you want to visualize the trajectory.
