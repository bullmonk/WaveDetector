function [] = row2f(row)
% write table row to file.
%   row: 1 row table
%     - cols: start_time, end_time, start_frequency, end_frequency, fce,
%     name.

    % p1(x, y) left buttom point.
    p1x = row.start_time{1};
    p1y = 1 - row.start_frequency{1};
    % p2(x, y) top right point.
    p2x = row.end_time{1};
    p2y = 1 - row.end_frequency{1};
    
    % n - # of boxes.
    n = length(p1x);

    % target text file.
    target = fullfile("trainChorus", "labels", "train", ...
        strrep(strrep(row.name, 'snr_sweep', 'waveform_fft'), 'png', 'txt'));

    % box.
    cx = (p1x + p2x) / 2;
    cy = (p1y + p2y) / 2;
    wid = abs(p2x - p1x);
    hei = abs(p2y - p1y);

    box = zeros(n, 5);
    box(:, 2) = cx';
    box(:, 3) = cy';
    box(:, 4) = wid';
    box(:, 5) = hei';

    T = array2table(box);

    writetable(T, target, "WriteVariableNames", false);

end