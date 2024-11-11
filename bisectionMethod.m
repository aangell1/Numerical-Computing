function [root, f_vals] = bisectionMethod(f, a, b, tol)
    f_vals = [];
    while (b - a) / 2 > tol
        c = (a + b) / 2;
        f_val = f(c);
        f_vals = [f_vals; abs(f_val)]; % Store the function values
        if f_val == 0
            a = c;
            b = c;
        elseif f(a) * f_val < 0
            b = c;
        else
            a = c;
        end
    end
    root = (a + b) / 2;
end

