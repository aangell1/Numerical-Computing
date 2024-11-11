function [x_opt, f_opt, grad_opt, steps, xvec] = optimize_with_log_barrier(x0, t_start, mu, fgname, bfgs, linesch, c1, c2)
    % Initialize variables
    t = t_start; % Initial barrier parameter
    x_k = x0; % Current point starts at initial guess
    steps = 0; % Count of iterations
    xvec = x_k; % Collect points for plotting
    
    % Main optimization loop
    while t > 1e-10
        % Define the barrier-augmented objective function for the current 't'
        barrier_obj = @(x) barrierObjective(x, t, fgname);
        
        % Call BFGS to minimize the barrier-augmented objective function
        [x_k, f_k, grad_k, iter, xvec_k] = bfgs(x_k, c1, c2, barrier_obj, linesch);
        
        % Update 't' for the next iteration
        t = mu * t;
        
        % Update other variables as needed...
    end
    
    % Finalize outputs
    x_opt = x_k;
    f_opt = f_k;
    grad_opt = grad_k;
    steps = iter; % Assuming 'bfgs' returns the number of iterations
    xvec = [xvec, xvec_k]; % Assuming you want to track all x_k over iterations
end

function [f, grad] = barrierObjective(x, t, fgname)
    % Calculate the original function value and gradient
    [f_orig, grad_orig] = fgname(x);
    
    % Define the inequality constraint (example: x1 + x2 - 2 >= 0)
    g_x = x(1) + x(2) - 2;
    
    % Ensure we are in the feasible region
    if g_x < 0
        f = inf;
        grad = [0; 0];
    else
        % Calculate the barrier term and its gradient
        barrier = -log(g_x);
        barrier_grad = -(1 / g_x) * [1; 1];
        
        % Combine the original function with the barrier term
        f = f_orig + t * barrier;
        grad = grad_orig + t * barrier_grad;
    end
end


