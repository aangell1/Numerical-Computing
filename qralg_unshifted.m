function [Anew, eigenvalues, record] = qralg_unshifted(A)
    tol = 1e-12;
    n = size(A, 1);
    Anew = A;
    record = [];
    eigenvalues = []; % Initialize the eigenvalues array

    while n > 1
        while abs(Anew(n, n-1)) > tol
            [Q, R] = qr(Anew(1:n, 1:n));
            Anew(1:n, 1:n) = R * Q;
            record(end+1) = abs(Anew(n, n-1));
        end
        eigenvalues(end+1) = Anew(n, n);
        n = n - 1;
    end
    eigenvalues(end+1) = Anew(1, 1);
end
