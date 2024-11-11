% Define a range of N values to test
N_values = [5, 10, 20];

% Define different sets of alpha and beta values to test
alpha_beta_pairs = [1, 3; 0.5, 5; 2, 2];

% Define a range of start and end points to test
start_end_points = [-1, -1, 1, 1; -2, -2, 2, 2; 0, 0, 3, -1];

% Test the optimization with different initial guesses
for i = 1:length(N_values)
    for j = 1:size(alpha_beta_pairs, 1)
        for k = 1:size(start_end_points, 1)
            % Set the parameters for this test
            N = N_values(i);
            a = start_end_points(k, 1);
            b = start_end_points(k, 2);
            c = start_end_points(k, 3);
            d = start_end_points(k, 4);
            alpha = alpha_beta_pairs(j, 1);
            beta = alpha_beta_pairs(j, 2);
            
            % Set a random initial guess
            Z_initial_guess = rand(2*N, 1) - 0.5;
            
            % Perform the optimization using the steepest descent function
            [Z_optimal, F_min] = optimizePath(N, alpha, beta, a, b, c, d, Z_initial_guess);
            
            % Extract X and Y from the optimal Z
            X_optimal = [a; Z_optimal(1:2:end); c];
            Y_optimal = [b; Z_optimal(2:2:end); d];
            
            % Plot the results
            figure;
            plot(X_optimal, Y_optimal, 'r-', 'LineWidth', 2);
            hold on;
            
            % Create a grid for the contour plot of the weight function rho
            [X_grid, Y_grid] = meshgrid(linspace(min(a, c), max(a, c), 100), linspace(min(b, d), max(b, d), 100));
            rho_grid = 1 + alpha * exp(-beta * (X_grid.^2 + Y_grid.^2));
            
            % Plot the contours of the weight function rho
            contour(X_grid, Y_grid, rho_grid, 20);
            hold off;
            
            % Configure the plot
            title(['Optimal Path (N=' num2str(N) ', \alpha=' num2str(alpha) ', \beta=' num2str(beta) ')']);
            xlabel('x');
            ylabel('y');
            legend('Optimal Path', 'Weight Function Contours');
            axis equal;
            grid on;
        end
    end
end
