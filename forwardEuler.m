function y = forwardEuler(t0, tf, y0, h)
    % Initialize variables
    t = t0:h:tf; % Time vector
    n = length(t); % Number of time steps
    y = zeros(2, n); % Initialize solution array
    y(:,1) = y0; % Set initial condition
    
    % Forward Euler integration
    for i = 1:n-1
        f = [y(2, i); 
             y(1, i) + cos(pi * t(i))^2 + 2 * pi^2 * cos(2 * pi * t(i))];
        y(:, i+1) = y(:, i) + h * f;
    end
end
