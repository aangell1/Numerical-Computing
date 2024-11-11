function [x, fval, grad, exitflag, output] = modified_newtons_method(f, grad_f, hess_f, x0, c1, c2, max_iter, tol, delta)
    x = x0;
    I = eye(length(x0));
    for k = 1:max_iter
        grad = grad_f(x);
        if norm(grad) < tol
            exitflag = 1; % convergence achieved
            output.iterations = k;
            fval = f(x);
            return;
        end
        H = hess_f(x); % Hessian matrix
        H = H + delta * I; % Hessian modification
        p = -H\grad; % search direction
        [alpha, ~, ~] = linesch(f, grad_f, x, p, c1, c2);
        x = x + alpha * p; % update
    end
    exitflag = 0; % max iterations reached
    output.iterations = max_iter;
    fval = f(x);
end
