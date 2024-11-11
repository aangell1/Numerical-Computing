
function [lam, v, error] = Rayleigh(A, v0)
    % Initialize parameters
    tol = 1e-6;
    error = [];
    v = v0;
    lam = 0;
    n = length(v);
    I = eye(n);
    
    % Normalize the initial vector
    v = v / norm(v);
    
    % Rayleigh Quotient Iteration
    while true
        % Compute the Rayleigh quotient
        lam_new = (v')*A*v;
        
        % Solve the shifted linear system (A - lam*I)*w = v
        w = (A - lam_new*I) \ v;
        
        % Normalize w to get the next approximation of the eigenvector
        v = w / norm(w);
        
        % Calculate the error
        err = norm(A*v - lam_new*v);
        
        % Store the error
        error = [error; err];
        
        % Check for convergence
        if err < tol
            lam = lam_new;
            break;
        end
    end
end
