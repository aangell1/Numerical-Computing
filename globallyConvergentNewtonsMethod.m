function [root, f_vals] = globallyConvergentNewtonsMethod(fun, a, b, tol)
    f_vals = [];
    if abs(fun(a)) < abs(fun(b))
        x0 = a;
    else
        x0 = b;
    end
    
    while b - a > tol
        [f0, df0] = fun(x0);
        f_vals = [f_vals; abs(f0)]; % Store the function values
        x1 = x0 - f0 / df0;
        if x1 < a || x1 > b || fun(x1) * fun(x0) > 0
            x1 = (a + b) / 2;
        end
        if fun(a) * fun(x1) < 0
            b = x1;
        else
            a = x1;
        end
        x0 = x1;
        if abs(fun(x0)) <= tol
            root = x0;
            return;
        end
    end
end
