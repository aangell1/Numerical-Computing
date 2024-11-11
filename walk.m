function [newAntGrid, newPherGrid] = walk(antGrid, pherGrid)
    global EMPTY NORTH EAST SOUTH WEST STAY EVAPORATE DEPOSIT THRESHOLD

    n = size(antGrid, 1) - 2;
    newAntGrid = antGrid;
    newPherGrid = pherGrid;
    
    for i = 2:n+1
        for j = 2:n+1
            if antGrid(i, j) == EMPTY
                newPherGrid(i, j) = max(newPherGrid(i, j) - EVAPORATE, 0);
            else
                if antGrid(i, j) == NORTH && newAntGrid(i-1, j) == EMPTY
                    if newPherGrid(i, j) > THRESHOLD
                        newPherGrid(i, j) = newPherGrid(i, j) + DEPOSIT;
                    end
                    newAntGrid(i, j) = EMPTY;
                    newAntGrid(i-1, j) = SOUTH;
                elseif antGrid(i, j) == EAST && newAntGrid(i, j+1) == EMPTY
                    if newPherGrid(i, j) > THRESHOLD
                        newPherGrid(i, j) = newPherGrid(i, j) + DEPOSIT;
                    end
                    newAntGrid(i, j) = EMPTY;
                    newAntGrid(i, j+1) = WEST;
                elseif antGrid(i, j) == SOUTH && newAntGrid(i+1, j) == EMPTY
                    if newPherGrid(i, j) > THRESHOLD
                        newPherGrid(i, j) = newPherGrid(i, j) + DEPOSIT;
                    end
                    newAntGrid(i, j) = EMPTY;
                    newAntGrid(i+1, j) = NORTH;
                elseif antGrid(i, j) == WEST && newAntGrid(i, j-1) == EMPTY
                    if newPherGrid(i, j) > THRESHOLD
                        newPherGrid(i, j) = newPherGrid(i, j) + DEPOSIT;
                    end
                    newAntGrid(i, j) = EMPTY;
                    newAntGrid(i, j-1) = EAST;
                else
                    newAntGrid(i, j) = STAY;
                end
            end
        end
    end
end
