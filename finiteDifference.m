function finiteDifference
    % Function to plot finite difference solutions for different grid resolutions
    ns = [20, 40, 80, 160]; % Array of different n values to test
    for i = 1:length(ns)
        n = ns(i);
        h = 1 / (n - 1); % Step size
        x = linspace(0, 1, n); % Grid points
        A = -2*eye(n) + diag(ones(n-1,1),1) + diag(ones(n-1,1),-1); % Tridiagonal matrix
        A = A / h^2; % Scale by h^2
        A(1,:) = zeros(1, n); A(1,1) = 1; % Boundary condition at t=0
        A(end,:) = zeros(1, n); A(end,end) = 1; % Boundary condition at t=1
        
        b = cos(pi*x).^2 + 2*pi^2*cos(2*pi*x); % Right-hand side
        b(1) = 0; % Boundary condition at t=0
        b(end) = 0; % Boundary condition at t=1
        
        u = A \ b'; % Solve the linear system

        % Plot the results
        figure;
        plot(x, u, 'b-'); % Finite difference solution
        hold on;
        % Include plot command for exact solution if available
        title(['Finite Difference Solution with n = ', num2str(n)]);
        xlabel('t');
        ylabel('u(t)');
        legend('Finite Difference'); % Add 'Exact Solution' if exact plot is added
    end
end
