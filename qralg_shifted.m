function [Anew, eigenvalues, record] = qralg_shifted(A)
    tol = 1e-12;
    n = size(A, 1);
    Anew = A;
    record = [];
    eigenvalues = []; % Initialize the eigenvalues array

    while n > 1
        while abs(Anew(n, n-1)) > tol
            delta = (Anew(n-1, n-1) - Anew(n, n)) / 2;
            signDelta = sign(delta);
            if signDelta == 0
                signDelta = 1;
            end
            mu = Anew(n, n) - (signDelta * Anew(n, n-1)^2) / (abs(delta) + sqrt(delta^2 + Anew(n, n-1)^2));
            
            [Q, R] = qr(Anew(1:n, 1:n) - mu * eye(n));
            Anew(1:n, 1:n) = R * Q + mu * eye(n);
            record(end+1) = abs(Anew(n, n-1));
        end
        eigenvalues(end+1) = Anew(n, n);
        n = n - 1;
    end
    eigenvalues(end+1) = Anew(1, 1);
end
