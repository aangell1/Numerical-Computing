function newpherGrid = applyDiffusion(pherGrid, diffusionRate)
    n = size(pherGrid, 1) - 2;
    newpherGrid = pherGrid; % MATLAB copies arrays by value, so this is equivalent to deepcopy
    
    for i = 2:n+1
        for j = 2:n+1
            newpherGrid(i, j) = max(pherGrid(i, j) + diffusionRate/4 * (pherGrid(i-1, j) + pherGrid(i, j+1) + pherGrid(i+1, j) + pherGrid(i, j-1) - 4 * pherGrid(i, j)), 0);
        end
    end
end
