function [rle] = RunLengthEncoding(BW)
    BW = BW(:)';  % Flatten binary mask (column-major order)
    changes = [1, find(diff(BW) ~= 0) + 1, numel(BW) + 1];  % Find transitions
    lengths = diff(changes);  % Compute run lengths
    values = BW(changes(1:end-1));  % Get the run values (0 or 1)
    
    % Ensure first run always starts with background (0)
    if values(1) == 1
        rle = [0, lengths];  % Prepend a 0 run if the first value is 1
    else
        rle = lengths;
    end
end