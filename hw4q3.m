% MATLAB code for spline interpolation of the Runge function

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
    
    % Use the MATLAB spline function for piecewise cubic spline interpolation
    spline_coeff = spline(ti, yi);
    
    % Generate more points for plotting the curve smoothly
    t_fine = linspace(-1, 1, 50);
    
    % Evaluate the spline at the finer points
    spline_vals = ppval(spline_coeff, t_fine);
    
    % Plot the Runge function
    plot(t_fine, runge(t_fine), 'k', 'LineWidth', 2);
    hold on;
    
    % Plot the spline interpolation
    plot(t_fine, spline_vals, '--', 'LineWidth', 2);
    
    % Annotate the graph
    title(['Spline Interpolation of the Runge function with n = ', num2str(n)]);
    legend('Runge function', 'Spline interpolation', 'Location', 'Best');
    
    % Pause to observe the plot
    pause(2);
    
    % Clear the figure for the next plot
    clf;
end
