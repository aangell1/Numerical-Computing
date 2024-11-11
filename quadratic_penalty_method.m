function [x_k, f_val, grad_val] = quadratic_penalty_method(x0, mu, tau, c1, c2)
    % The main function implementing the Quadratic Penalty algorithm
    
    % Define the function that returns the original objective function and its gradient
    function [f, grad] = fgname(x)
        f = x(1)^2 + x(2)^2;
        grad = [2*x(1); 2*x(2)];
    end

    x_k = x0;
    k = 0;
    while mu > 1e-3
        k = k + 1;
        
        % Minimize the penalty function using the BFGS algorithm
        [x_k, f_val, grad_val] = bfgs(x_k, c1, c2, @penalty_function, 1);
        
        % Check for convergence
        if norm(grad_val) <= tau
            break;
        end
        
        % Update parameters
        mu = mu / 2;
        tau = tau / 2;
    end
    
    if k == 1
        disp('Converged in one iteration.');
    else
        fprintf('Converged in %d iterations.\n', k);
    end
    
    % Nested function: penalty_function
    function [f, grad] = penalty_function(x)
        % Define the penalty function for a given mu value
        [f_orig, grad_orig] = fgname(x); % Directly call fgname since it is now in scope
        h = (x(1) - 2)^2 + x(2)^2 - 1;
        f = f_orig + (mu/2)*h^2;
        
        if nargout > 1 % gradient required
            grad_h = [2*(x(1) - 2); 2*x(2)] * h;
            grad = grad_orig + mu * grad_h;
        end
    end
end

