% BFGS Method Function
function [x, fval, grad, exitflag, output] = bfgs_method(f, grad_f, x0, c1, c2, max_iter, tol)
    x = x0;
    I = eye(length(x0)); % Identity matrix
    B = I; % Initial approximation to the Hessian is the identity matrix
    for k = 1:max_iter
        grad = grad_f(x);
        if norm(grad) < tol
            exitflag = 1; % convergence achieved
            output.iterations = k;
            fval = f(x);
            return;
        end
        p = -B\grad; % search direction using the BFGS approximation
        [alpha, ~, grad_new] = linesch(f, grad_f, x, p, c1, c2);
        s = alpha * p;
        x_new = x + s;
        y = grad_new - grad;
        rho = 1 / (y' * s);
        B = (I - rho * s * y') * B * (I - rho * y * s') + rho * s * s'; % BFGS update
        x = x_new;
        grad = grad_new;
    end
    exitflag = 0; % max iterations reached
    output.iterations = max_iter;
    fval = f(x);
end

