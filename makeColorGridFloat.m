function colorGrid = makeColorGridFloat(antGrid, pherGrid)
    global MAXPHER BORDER

    n = size(antGrid, 1) - 2;
    colorGrid = zeros(n+2, n+2, 3);
    firstEls = 1 - pherGrid / MAXPHER;
    colorGrid(:, :, 1) = firstEls / 1.2;
    colorGrid(:, :, 2) = firstEls / 1.2;
    colorGrid(:, :, 3) = firstEls / 1.2;

    for i = 1:n+2
        for j = 1:n+2
            if antGrid(i, j) == BORDER
                colorGrid(i, j, 1) = 0;
                colorGrid(i, j, 2) = 0;
                colorGrid(i, j, 3) = 1; % Blue color for border
            elseif antGrid(i, j) > 0
                colorGrid(i, j, 1) = 1; % Red color for ant
                colorGrid(i, j, 2) = 0;
                colorGrid(i, j, 3) = 0;
            end
        end
    end
end
