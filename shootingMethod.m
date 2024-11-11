function x_opt = shootingMethod(t0, tf, target, h)
    % Initialize shooting parameters
    x_low = -20; % Lower bound of x
    x_high = 20; % Upper bound of x
    tol = 1e-3; % Tolerance for zero at t = 1
    
    while (x_high - x_low > tol)
        x_mid = (x_low + x_high) / 2;
        y0 = [0, x_mid]; % Initial condition with current guess
        y = forwardEuler(t0, tf, y0, h); % Solve ODE with Forward Euler
        if y(1, end) > target % Check the boundary condition at t = 1
            x_high = x_mid;
        else
            x_low = x_mid;
        end
    end
    x_opt = (x_low + x_high) / 2; % Optimal x found
end
