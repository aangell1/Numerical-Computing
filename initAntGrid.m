function grid = initAntGrid(n, probAnt)
    global BORDER EMPTY
    
    grid = BORDER * ones(n+2, n+2);
    for i = 2:n+1
        for j = 2:n+1
            if rand() < probAnt
                grid(i, j) = randi([1, 5]);
            else
                grid(i, j) = EMPTY;
            end
        end
    end
end
