function [root, f_vals] = newtonsMethod(fun, x0, tol)
    f_vals = [];
    while true
        [f_val, df_val] = fun(x0);
        f_vals = [f_vals; abs(f_val)]; % Store the function values
        if abs(f_val) <= tol
            root = x0;
            return;
        end
        x0 = x0 - f_val / df_val;
    end
end
