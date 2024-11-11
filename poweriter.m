
function [lam, v, error] = poweriter(A, v0)
    % Initialize parameters
    tol = 1e-6;
    error = [];
    v = v0;
    lam = 0;
    
    % Normalize the initial vector
    v = v / norm(v);
    
    % Power Iteration
    while true
        w = A * v;
        lam_new = norm(w);
        v = w / lam_new;
        err = norm(A*v - lam_new*v);
        
        % Store the error
        error = [error; err];
        
        % Check for convergence
        if err < tol
            break;
        end
        lam = lam_new;
    end
end
