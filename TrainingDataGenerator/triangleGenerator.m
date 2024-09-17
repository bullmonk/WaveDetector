function [boxes] = triangleGenerator(n, varargin)
    
    ip = inputParser;
    addRequired(ip, 'n');

    addParameter(ip, 'sideRange', [0.2, 0.25]);
    addParameter(ip, 'sideDeltaRange', [0.01, 0.02]);
    addParameter(ip, 'rightSidePloarAngleRange', [250, 290]);
    addParameter(ip, 'topAngleRange', [10, 45]); % Restriction: within (0, 180)
    addParameter(ip, 'imageWidth', 10);
    addParameter(ip, 'imageHeight', 10);
    addParameter(ip, 'fileName', 'test.png');
    addParameter(ip, 'imageFolder', '../plot');
    addParameter(ip, 'showSquare', false);
    addParameter(ip, 'keepScreenPlot', false);

    
    parse(ip, n, varargin{:});

    imageWidth = ip.Results.imageWidth;
    imageHeight = ip.Results.imageHeight;
    range = ip.Results.sideRange * imageHeight;
    deltaRange = ip.Results.sideDeltaRange * imageHeight;
    rightSidePloarAngleRange = ip.Results.rightSidePloarAngleRange;
    topAngleRange = ip.Results.topAngleRange;

    % TODO: make sure some overlapped trangles.

    % the figure will preserve a imageWidth:imageHeight ratio. so the trangle tops will be
    % limitied in the band of [2/5, 4/5] in y axis range.
    topy = 0.4*imageHeight + rand(1, n)*0.4*imageHeight;
    % divide x range into 4 * n even distributed candidate points, and
    % randomely pick n of them as top point x values.
    pm = randperm(4 * n, n);
    topx  = imageWidth * pm / (4 * n);

    % right bottom of trangles.
    rightSide = range(1) + (range(2) - range(1)) * rand(1, n);
    rightSideAngle = deg2rad(rightSidePloarAngleRange(1) + (rightSidePloarAngleRange(2) ...
        - rightSidePloarAngleRange(1)) * rand(1, n));
    [dx, dy] = pol2cart(rightSideAngle, rightSide);
    rx = topx + dx;
    ry = topy + dy;
    clear dx dy;

    % left bottom of trangles.
    delta = deltaRange(1) + (deltaRange(2) - deltaRange(1)) * rand(1, n);
    leftSide = rightSide - delta;
    topAngle = deg2rad(topAngleRange(1) + (topAngleRange(2) ...
        - topAngleRange(1)) * rand(1, n));
    [dx, dy] = pol2cart(rightSideAngle + topAngle, leftSide);
    lx = topx + dx;
    ly = topy + dy;
    clear dx dy;

    % x and y coordinate of triangles.
    ptsx = [topx', rx', lx'];
    ptsy = [topy', ry', ly'];

    % bondbox of all triangles.
    rightBond = max(ptsx, [], 2);
    rightBond(rightBond > imageWidth) = imageWidth;
    leftBond = min(ptsx, [], 2);
    leftBond(leftBond < 0) = 0;
    upperBond = max(ptsy, [], 2);
    upperBond(upperBond > imageHeight) = imageHeight;
    lowerBond = min(ptsy, [], 2);
    lowerBond(lowerBond < 0) = 0;
    
    % draw the bond box if required.
    if ip.Results.showSquare
        drawx = zeros(n, 5);
        drawx(:, 1) = leftBond;
        drawx(:, 2) = leftBond;
        drawx(:, 3) = rightBond;
        drawx(:, 4) = rightBond;
        drawx(:, 5) = leftBond;
    
        drawy = zeros(n, 5);
        drawy(:, 1) = upperBond;
        drawy(:, 2) = lowerBond;
        drawy(:, 3) = lowerBond;
        drawy(:, 4) = upperBond;
        drawy(:, 5) = upperBond;
    end

    % calculate the training input.
    % the input is in form of (center_x, center_y, width, height)
    boxes = zeros(n, 4);
    % center x coord
    boxes(:, 1) = (leftBond + rightBond) / 2 / imageWidth;
    % center y coord
    boxes(:, 2) = (lowerBond + upperBond) / 2 / imageHeight;
    % width
    boxes(:, 3) = (rightBond - leftBond) / imageWidth;
    % height
    boxes(:, 4) = (upperBond - lowerBond) / imageHeight;

    % create figure.
    fig = figure;
    set(fig, 'Position', [100 100 740 740]);
    axis equal
    ax = gca;

    % plot triangles
    for i = 1:n
        hold on
        fill([topx(i) rx(i) lx(i)], [topy(i) ry(i) ly(i)], 'r');
        if ip.Results.showSquare
            plot(drawx(i, :), drawy(i, :), 'b-', 'LineWidth',3);
        end
        % grid on
    end
    xlim([0 imageWidth]);
    ylim([0 imageHeight]);

    set(gca, 'DataAspectRatio', [1 1 1]);
    ax.Units = 'normalized';
    ax.Position = [0 0 1 1];

    % save plot.
    saveeps(fullfile(ip.Results.imageFolder, ip.Results.fileName))

    if ~ip.Results.keepScreenPlot
        close all
    end
end