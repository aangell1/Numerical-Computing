function x_star = solveKKT()
    % Define the objective function as the sum of squares of the KKT conditions
    function F = kkt_objective(z)
        x1 = z(1);
        x2 = z(2);
        lambda = z(3);
        F1 = 2*x1 + 2*lambda*(x1 - 2);
        F2 = 2*x2 + 2*lambda*x2;
        F3 = (x1 - 2)^2 + x2^2 - 1;
        F = F1^2 + F2^2 + F3^2;
    end

    % Make an initial guess for [x1, x2, lambda]
    initial_guess = [0; 0; 0];
    % Use fminsearch to minimize the objective function
    options = optimset('Display', 'iter');
    [x_star, fval, exitflag, output] = fminsearch(@kkt_objective, initial_guess, options);

    % Check if the solution was successful
    if exitflag ~= 1
        error('fminsearch did not converge. The output structure contains more information.');
    end

    % Display the output structure for more information
    disp(output);
end




