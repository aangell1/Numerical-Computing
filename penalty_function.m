function [f, grad] = penalty_function(x, mu)
    % Define the original objective function and constraint
    f_original = x(1)^2 + x(2)^2;
    g_constraint = (x(1) - 2)^2 + x(2)^2 - 1;
    
    % Calculate the penalty term
    penalty = (1/(2*mu)) * max(0, g_constraint)^2;
    
    % The augmented Lagrangian function value
    f = f_original + penalty;
    
    % Gradient of the original objective function
    grad_f_original = [2*x(1); 2*x(2)];
    
    % Gradient of the constraint
    grad_g_constraint = [2*(x(1) - 2); 2*x(2)];
    
    % Gradient of the penalty term
    grad_penalty = (g_constraint > 0) * grad_g_constraint; % Only add if constraint is violated
    
    % The augmented Lagrangian gradient
    grad = grad_f_original + (1/mu) * grad_penalty;
end

