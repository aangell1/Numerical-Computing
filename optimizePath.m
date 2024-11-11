function [Z_optimal, F_min] = optimizePath(N, alpha, beta, a, b, c, d, Z_initial_guess)
    % Initialize parameters for the steepest descent
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
    
    % Return the optimal path Z and the minimum functional value found
    Z_optimal = Z;
    F_min = F_current;
end
