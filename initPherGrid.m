function grid = initPherGrid(n)
    global MAXPHER
    
    grid = zeros(n+2, n+2);
    
    % Set border of -0.01
    grid(1, :) = -0.01;
    grid(n+2, :) = -0.01;
    grid(:, 1) = -0.01;
    grid(:, n+2) = -0.01;
    
    mid = round(n / 2) + 1; % Adjust for MATLAB's 1-based indexing
    for i = 2:n+1
        grid(mid, i) = MAXPHER * (i - 1) / n; % Adjust for MATLAB's 1-based indexing
    end
end
