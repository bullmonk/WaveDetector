function [] = drawOneMarker(tbl, pname, tname)

    tbl = tbl(tbl.marker < 4, :);
    img = imread(pname);
    imshow(img);
    
    [height,width,~] = size(img);
    cx = tbl.cx * width;
    cy = tbl.cy * height;
    wids = tbl.width * width;
    heis = tbl.height * height;
    n = size(cx, 1);

    % draw box.
    drawx = zeros(n, 5);
    drawx(:, 1) = cx';
    drawx(:, 2) = cx';
    drawx(:, 3) = (cx + wids)';
    drawx(:, 4) = (cx + wids)';
    drawx(:, 5) = cx';
    
    drawy = zeros(n, 5);
    drawy(:, 1) = (cy + heis)';
    drawy(:, 2) = cy';
    drawy(:, 3) = cy';
    drawy(:, 4) = (cy + heis)';
    drawy(:, 5) = (cy + heis)';

    
    hold on
    colors = {'green', 'red', 'yellow'}; % green for match, red for unpicked, yellow for miss predicted.
    
    for i = 1:n
        plot(drawx(i, :), drawy(i, :), colors{tbl.marker(i)}, 'LineWidth',3);
    end
    
    hold off
    saveas(gcf, tname);
    close gcf;
end