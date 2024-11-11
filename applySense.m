function newAntGrid = applySense(antGrid, pherGrid)
    global EMPTY STAY
    
    n = size(antGrid, 1) - 2;
    newAntGrid = antGrid; % MATLAB copies arrays by value
    
    for i = 2:n+1
        for j = 2:n+1
            if antGrid(i, j) == EMPTY
                newAntGrid(i, j) = EMPTY;
            else
                neighbors = [antGrid(i-1, j), antGrid(i, j+1), antGrid(i+1, j), antGrid(i, j-1)];
                lst = [pherGrid(i-1, j), pherGrid(i, j+1), pherGrid(i+1, j), pherGrid(i, j-1)];
    
                % Don't allow ant to turn to the previous cell
                if antGrid(i, j) < STAY
                    lst(antGrid(i, j)) = -2;
                end
                
                % Don't allow ant to turn to cell with another ant
                for inx = 1:4
                    if neighbors(inx) > EMPTY
                        lst(inx) = -2;
                    end
                end
                
                [mx, mxInd] = max(lst); % Maximum value of Pheromone and its index
                
                if mx < 0
                    newAntGrid(i, j) = STAY;
                else
                    posList = find(lst == mx); % Find positions with maximum Pheromone
                    lng = length(posList);
                    rndPos = randi([1, lng]);
                    newAntGrid(i, j) = posList(rndPos);
                end
            end
        end
    end
end
