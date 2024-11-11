function [eigenvalues, record] = findEigenvalues(S, qralgFunc)
    A = tridiag(S); % Convert S to tridiagonal form
    [Anew, eigenvalues, record] = qralgFunc(A);
end
