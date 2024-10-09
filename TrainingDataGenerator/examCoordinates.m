% load data.
coords = load("chorus/chorus_label.mat").chorus_label;


for id = 1:size(coords, 1)

    % load image.
    img = imread(fullfile("chorus", strrep(coords.name{id}, 'snr_sweep', 'waveform_fft')));
    imshow(img);
    [height,width,~] = size(img);
    
    % load box data.
    p1x = coords.start_time{id} * width;
    p1y = height - coords.start_frequency{id} * height;
    p2x = coords.end_time{id} * width;
    p2y = height - coords.end_frequency{id} * height;
    
    n = length(p1x);
    
    % box center.
    cx = (p1x + p2x) / 2;
    cy = (p1y + p2y) / 2;
    wid = p2x - p1x;
    hei = p2y - p1y;
    
    % draw box.
    drawx = zeros(n, 5);
    drawx(:, 1) = p1x';
    drawx(:, 2) = p1x';
    drawx(:, 3) = p2x';
    drawx(:, 4) = p2x';
    drawx(:, 5) = p1x';
    
    drawy = zeros(n, 5);
    drawy(:, 1) = p2y';
    drawy(:, 2) = p1y';
    drawy(:, 3) = p1y';
    drawy(:, 4) = p2y';
    drawy(:, 5) = p2y';
    
    
    hold on
    % draw boxes in blue.    for i = 1:n
    for i = 1:n
        plot(drawx(i, :), drawy(i, :), 'black-', 'LineWidth',3);
    end
    % draw center in blue.
    plot(cx', cy', 'black.', 'MarkerSize', 40);
    hold off
    
    imwrite(img, fullfile("check", ['check_' int2str(id) '.png']));
end

close all; clear; clc;