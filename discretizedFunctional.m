function F = discretizedFunctional(a, b, c, d, N, alpha, beta)
    % Discretize the interval [0, 1] by N+2 equally spaced points
    h = 1 / (N + 1);
    
    % Initialize coordinates with a straight line guess between the endpoints
    X = linspace(a, c, N+2); % This includes the endpoints
    Y = linspace(b, d, N+2); % This includes the endpoints
    
    % Calculate the derivatives using forward difference for internal points
    dX = diff(X) / h; % Forward difference for x, length is N+1
    dY = diff(Y) / h; % Forward difference for y, length is N+1
    
    % We exclude the derivatives at the last point
    dX = dX(1:N);
    dY = dY(1:N);
    
    % Evaluate the weight function rho at the internal points, not including the endpoints
    rho = 1 + alpha * exp(-beta * ((X(2:N+1).^2) + (Y(2:N+1).^2)));
    
    % Composite rectangle rule to approximate the integral
    F = h * sum(rho .* (dX.^2 + dY.^2));
end


