function u_galerkin = galerkinMethod(n)
    h = 1 / (n - 1);
    A = zeros(n-2, n-2);
    b = zeros(n-2, 1);
    
    % Construct the matrix A and vector b
    for i = 1:n-2
        for j = max(1, i-1):min(n-2, i+1)
            % Integral of phi_i' * phi_j'
            A(i, j) = integral(@(t) phi_prime(t, i, h) .* phi_prime(t, j, h), max(0, (i-1)*h), min(1, (i+1)*h), 'ArrayValued', true);
        end
        % Integral of the right-hand side against phi_i
        b(i) = integral(@(t) (cos(pi*t).^2 + 2*pi^2*cos(2*pi*t)) .* phi(t, i, h), (i-1)*h, (i+1)*h, 'ArrayValued', true);
    end
    
    % Solve the linear system
    u_galerkin = A \ b;
end

function val = phi(t, i, h)
    % Correctly vectorized local basis function
    t_i = h * i;
    val = zeros(size(t));
    inLeft = (t >= (t_i - h) & t < t_i);
    inRight = (t >= t_i & t < (t_i + h));
    val(inLeft) = (t(inLeft) - (t_i - h)) / h;
    val(inRight) = ((t_i + h) - t(inRight)) / h;
end

function val = phi_prime(t, i, h)
    % Correctly vectorized derivative of the basis function
    t_i = h * i;
    val = zeros(size(t));
    inLeft = (t >= (t_i - h) & t < t_i);
    inRight = (t >= t_i & t < (t_i + h));
    val(inLeft) = 1 / h;
    val(inRight) = -1 / h;
end


