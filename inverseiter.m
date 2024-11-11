
function [lam, v, error] = inverseiter(A, v0, mu)
    % Initialize parameters
    tol = 1e-6;
    error = [];
    v = v0;
    lam = mu;
    
    % Normalize the initial vector
    v = v / norm(v);
    
    % Inverse Iteration
    while true
        % Solve the shifted system
        w = (A - mu * eye(size(A))) \ v;
        
        % Update the eigenvalue approximation if w is not zero
        if norm(w) > 0
            v = w / norm(w);
            lam_new = v' * A * v;
        else
            break;
        end
        
        % Compute the error
        err = norm(A*v - lam_new*v);
        
        % Store the error
        error = [error; err];
        
        % Check for convergence
        if err < tol
            break;
        end
        
        % Update the eigenvalue and eigenvector
        lam = lam_new;
    end
end
