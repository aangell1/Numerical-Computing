function A = tridiag(S)
    % Check if S is symmetric
    if ~isequal(S, S')
        error('Matrix S must be symmetric.');
    end

    n = size(S, 1);
    A = S;

    for k = 1:n-2
        x = A(k+1:n, k);
        e = zeros(length(x), 1); e(1) = 1;
        v = sign(x(1)) * norm(x) * e + x;
        v = v / norm(v);

        % Householder transformation
        A(k+1:n, k:n) = A(k+1:n, k:n) - 2 * v * (v' * A(k+1:n, k:n));
        A(1:n, k+1:n) = A(1:n, k+1:n) - 2 * (A(1:n, k+1:n) * v) * v';
    end
end
