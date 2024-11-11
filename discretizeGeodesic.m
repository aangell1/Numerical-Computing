function Z = discretizeGeodesic(a, b, c, d, N)
    % This function discretizes the geodesic problem
    % a, b: Starting point coordinates (x_0, y_0)
    % c, d: Ending point coordinates (x_{N+1}, y_{N+1})
    % N: Number of internal points to discretize the curve
    
    % Calculate mesh size
    h = 1 / (N + 1);
    
    % Initialize the vectors for x and y coordinates
    X = zeros(N, 1);
    Y = zeros(N, 1);
    
    % Combine X and Y into a single vector Z
    Z = reshape([X'; Y'], 2*N, 1);
end

