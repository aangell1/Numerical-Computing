% MATLAB code for polynomial interpolation of the Runge function

% Define the Runge function
runge = @(t) 1 ./ (1 + 25*t.^2);

% Values of n for which we perform interpolation
n_values = [5, 10, 15, 20];

% Prepare a figure
figure;

% Iterate over the specified n values
for n = n_values
    % Calculate the equally spaced points ti
    ti = linspace(-1, 1, n);
    
    % Calculate the corresponding yi values from the Runge function
    yi = runge(ti);
    
    % Calculate the polynomial coefficients using polyfit
    poly_coeff = polyfit(ti, yi, n-1);
    
    % Generate more points for plotting the curve smoothly
    t_fine = linspace(-1, 1, 50);
    
    % Evaluate the polynomial at the finer points using polyval
    poly_vals = polyval(poly_coeff, t_fine);
    
    % Plot the Runge function
    plot(t_fine, runge(t_fine), 'k', 'LineWidth', 2);
    hold on;
    
    % Plot the interpolation polynomial
    plot(t_fine, poly_vals, '--', 'LineWidth', 2);
    
    % Annotate the graph
    title(['Interpolation of the Runge function with n = ', num2str(n)]);
    legend('Runge function', 'Interpolation polynomial');
    
    % Pause to observe the plot
    pause(2);
    
    % Clear the figure for the next plot
    clf;
end
