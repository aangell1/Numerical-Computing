% MATLAB code for trigonometric interpolation

% Define the function f(x)
f = @(x) 1 ./ (1 + 25*(x - pi).^2);

% Values of M for which we perform interpolation
M_values = [2, 5, 7];

% Prepare a figure
figure;

% Iterate over the specified M values
for M = M_values
    % Determine N
    N = 2*M + 1;
    
    % Calculate the equally spaced points xk on [0, 2*pi]
    xk = (0:N-1)*(2*pi/N);
    
    % Calculate the function values fk at xk
    fk = f(xk);
    
    % Compute the coefficients using the fft function
    c = fft(fk)/N;
    
    % A0 coefficient
    A0 = c(1);
    
    % Preallocate arrays for coefficients
    Ah = zeros(1,M);
    Bh = zeros(1,M);
    
    % Calculate coefficients Ah and Bh
    Ah(1:M) = 2*real(c(2:M+1));
    Bh(1:M) = -2*imag(c(2:M+1));
    
    % Generate more points for plotting the curve smoothly
    x_fine = linspace(0, 2*pi, 50);
    
    % Initialize the trigonometric interpolation vector
    psi_vals = A0/2 * ones(size(x_fine));
    
    % Calculate the trigonometric interpolation values
    for h = 1:M
        psi_vals = psi_vals + Ah(h)*cos(h*x_fine) + Bh(h)*sin(h*x_fine);
    end
    
    % Plot the original function
    plot(x_fine, f(x_fine), 'k', 'LineWidth', 2);
    hold on;
    
    % Plot the trigonometric interpolation
    plot(x_fine, psi_vals, '--', 'LineWidth', 2);
    
    % Annotate the graph
    title(['Trigonometric Interpolation with M = ', num2str(M)]);
    legend('f(x)', 'Trigonometric Interpolation', 'Location', 'Best');
    
    % Pause to observe the plot
    pause(2);
    
    % Clear the figure for the next plot
    clf;
end
