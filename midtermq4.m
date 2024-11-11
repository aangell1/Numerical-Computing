% Define the optimization parameters
N = 10;
a = -1;
b = -1;
c = 1;
d = 1;
alpha = 1;
beta = 3;

% Define the initial guess for the path Z
% Use a parabola as the initial guess to avoid a straight line
t = linspace(0, 1, N+2)';
initial_guess_x = (c-a) * t + a;  % linear x-component
initial_guess_y = (4 * (t - 0.5).^2 - 1);  % parabolic y-component
Z_initial_guess = [initial_guess_x(2:end-1); initial_guess_y(2:end-1)];

% Define the step size for the steepest descent and tolerance for stopping criterion
step_size = 0.01;
tolerance = 1e-6;
max_iterations = 1000;
Z = Z_initial_guess;
F_previous = Inf;

% Run the steepest descent optimization
for iter = 1:max_iterations
    % Evaluate the functional value and its gradient at the current Z
    [F_current, gradF] = functionalAndGradient(Z, N, alpha, beta, a, b, c, d);
    
    % Check for convergence
    if abs(F_previous - F_current) < tolerance
        disp(['Converged in ', num2str(iter), ' iterations.']);
        break;
    end
    
    % Update Z by moving in the opposite direction of the gradient
    Z = Z - step_size * gradF;
    
    % Update the previous functional value
    F_previous = F_current;
end

% Check if the maximum number of iterations was reached
if iter == max_iterations
    disp('Maximum iterations reached without convergence.');
end

% Extract X and Y from the final Z
X_final = [a; Z(1:2:end); c];
Y_final = [b; Z(2:2:end); d];

% Plotting the results
% Plot the final path
figure;
plot(X_final, Y_final, 'r-', 'LineWidth', 2);
hold on;

% Create a grid for the contour plot of the weight function rho
[X_grid, Y_grid] = meshgrid(linspace(a, c, 100), linspace(b, d, 100));
rho_grid = 1 + alpha * exp(-beta * (X_grid.^2 + Y_grid.^2));

% Plot the contours of the weight function rho
contour(X_grid, Y_grid, rho_grid, 20);
hold off;
title('Approximated Minimum Path and Contours of the Weight Function');
xlabel('x');
ylabel('y');
legend('Approximated Minimum Path', 'Weight Function Contours');

% Adjust the axes for a better view
axis equal;
grid on;
