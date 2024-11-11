function [x_k, f_val, grad_val, steps, xvec] = combined_penalty_barrier_method(x0, mu, t, c1, c2, fgname, bfgs_func, linesearch_func)
    % Initialize the optimization variables
    x_k = x0;
    steps = 0;
    xvec = x_k;
    
    % Optimization loop
    while mu > 1e-3 && t > 1e-10
        % Define the combined penalty and barrier function
        function [f, grad] = combined_objective(x)
            [f_orig, grad_orig] = fgname(x); % Compute the original function and gradient
            
            % Equality constraint penalty term
            h = (x(1) - 2)^2 + x(2)^2 - 1;
            penalty = (mu/2) * h^2;
            
            % Inequality constraint barrier term
            g = x(1) + x(2) - 2;
            if g <= 0
                barrier = inf;
                grad_barrier = zeros(size(x));
            else
                barrier = -t * log(g);
                grad_barrier = -(1/g) * [1; 1];
            end
            
            % Combine terms
            f = f_orig + penalty + barrier;
            grad = grad_orig + mu * h * [2*(x(1) - 2); 2*x(2)] + t * grad_barrier;
        end
        
        % Call the BFGS function to minimize the combined objective function
        [x_k, f_val, grad_val, iter, xvec_k] = bfgs_func(x_k, c1, c2, @combined_objective, linesearch_func);
        
        % Update the optimization variables
        steps = steps + iter;
        xvec = [xvec, xvec_k]; % Collect all x_k for plotting
        
        % Update parameters
        mu = mu * 0.5; % Decrease the penalty parameter
        t = t * 0.5; % Decrease the barrier parameter
    end
end

% Usage: 
% Define the original objective function f(x) = x1^2 + x2^2 and its gradient
function [f, grad] = fgname(x)
    f = x(1)^2 + x(2)^2;
    grad = [2*x(1); 2*x(2)];
end

% Call the combined Penalty-Barrier method
x0 = [1.5; 1.5]; % Make sure this is a feasible starting point
mu = 1; % Initial penalty parameter
t = 1; % Initial barrier parameter
c1 = 1e-4; % Wolfe condition parameter for line search
c2 = 0.9; % Wolfe condition parameter for line search
[x_opt, f_opt, grad_opt, steps, xvec] = combined_penalty_barrier_method(x0, mu, t, c1, c2, @fgname, @bfgs, @linesch);
