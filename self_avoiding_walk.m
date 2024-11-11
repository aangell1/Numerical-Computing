function polymer_path = self_avoiding_walk()

    % Initialize
    polymer_path = [0, 0];
    directions = [0, 1; 0, -1; 1, 0; -1, 0];  % [up; down; right; left]

    % Continue walk until trapped
    while true
        possible_moves = directions + polymer_path(end, :);
        
        % Remove points that have been visited before
        for i = size(possible_moves, 1):-1:1
            if ismember(possible_moves(i, :), polymer_path, 'rows')
                possible_moves(i, :) = [];
            end
        end

        % Terminate if no moves are possible
        if isempty(possible_moves)
            break;
        end

        % Choose a random move from the possible moves
        next_step = possible_moves(randi(size(possible_moves, 1)), :);
        polymer_path = [polymer_path; next_step];
    end

    % Visualization
    plot(polymer_path(:, 1), polymer_path(:, 2), '-o', 'LineWidth', 1.5);
    axis equal;
    grid on;
    title('Self-Avoiding Walk (Polymer Model)');
    xlabel('X');
    ylabel('Y');

end
