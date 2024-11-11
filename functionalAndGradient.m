function [F, gradF] = functionalAndGradient(Z, N, alpha, beta, a, b, c, d)
    % Calculate step size
    h = 1 / (N + 1);
    
    % Initialize coordinates from Z
    X = [a; Z(1:2:end); c];
    Y = [b; Z(2:2:end); d];

    % Compute forward differences for the derivatives
    dX = diff(X) / h;
    dY = diff(Y) / h;

    % Compute midpoints for the weight function rho
    midX = (X(1:end-1) + X(2:end)) / 2;
    midY = (Y(1:end-1) + Y(2:end)) / 2;
    
    % Calculate rho at the midpoints
    rho = 1 + alpha * exp(-beta * (midX.^2 + midY.^2));

    % Compute F
    F = h * sum(rho .* (dX.^2 + dY.^2));

    % Preallocate gradient vector
    gradF = zeros(2*N, 1);

    % Compute gradient of F using the chain rule
    for i = 1:N
        % Calculate partial derivatives of rho
        drho_dXi = alpha * (-2 * beta * midX(i)) * exp(-beta * (midX(i)^2 + midY(i)^2));
        drho_dYi = alpha * (-2 * beta * midY(i)) * exp(-beta * (midX(i)^2 + midY(i)^2));

        % Apply the chain rule for derivatives of F w.r.t. X and Y
        gradF(2*i-1) = 2 * h * (drho_dXi * dX(i)^2 + rho(i) * 2 * dX(i) / h);
        gradF(2*i) = 2 * h * (drho_dYi * dY(i)^2 + rho(i) * 2 * dY(i) / h);
    end
end

