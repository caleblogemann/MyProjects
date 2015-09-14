function [U, T] = schurUnitaryTriangulation(A)
% Apply Schur's Unitary triangulation to matrix A
% See AppliedLinearAlgebra notes Theorem 1.2.2
    p = inputParser;
    p.addRequired('A', @Utils.checkSquareNumericMatrix);
    p.parse(A);

    n = length(A);
    A_k = A;
    U = eye(n);
    for k=1:n
        % find length of vectors for current iteration
        l = n - k + 1;
        [V, D] = eig(A_k);
        % get eigenvector
        x = V(:, 1);
        % get eigenvalue
        lambda = D(1, 1);
        % make sure x_1 is nonnegative
        if(x(1) < 0)
            x = -1 * x;
        end
        % normalize x
        x = x./norm(x);

        v = (x + eye(l, 1));
        v = v./norm(v);

        u = [zeros(n - l, 1); v];

        H_u = LinearAlgebra.generateHouseholderMatrix(u);

        % update U by right multiplying H_u
        U = U*H_u;

        % find the new A_k
        temp = U'*A*U;
        A_k = temp((k + 1):n, (k + 1):n);
    end

    T = U'*A*U;
end
