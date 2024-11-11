function [x, fval, grad, exitflag, output, x_history] = steepest_descent_method(f, grad_f, x0, c1, c2, max_iter, tol)
    x = x0;
    x_history = x'; % Initialize history to include initial guess
    for k = 1:max_iter
        grad = grad_f(x);
        if norm(grad) < tol
            exitflag = 1; % convergence achieved
            output.iterations = k;
            fval = f(x);
            return;
        end
        p = -grad; % search direction
        [alpha, ~, ~] = linesch(f, grad_f, x, p, c1, c2);
        x = x + alpha * p; % update
        x_history = [x_history; x']; % Save iterate to history
    end
    exitflag = 0; % max iterations reached
    output.iterations = max_iter;
    fval = f(x);
end
