function [squares] = TrangleGenerator(n, varargin)
    
    ip = inputParser;
    addRequired(ip, 'n');

    addParameter(ip, 'sideRange', [0.5, 1]);
    addParameter(ip, 'sideDeltaRange', [0, 0.1]);
    addParameter(ip, 'rightSidePloarAngleRange', [250, 290]);
    addParameter(ip, 'topAngleRange', [10, 45]); % Restriction: within (0, 180)
    
    parse(ip, n, varargin{:});

    range = ip.Results.sideRange;
    deltaRange = ip.Results.sideDeltaRange;
    rightSidePloarAngleRange = ip.Results.rightSidePloarAngleRange;
    topAngleRange = ip.Results.topAngleRange;

    % 2. set length range of 2 sides
    % 3. set angle range of 2 sides
    % 4. random pick 2 sides for all tops.
    % 5. plot all trangles.
    % optional: make sure some overlapped trangles.

    % the figure will preserve a 16:9 ratio. so the trangle tops will be
    % limitied in the band of [7, 8] in y axis range.
    topy = 7 + rand(1, n);
    % divide x range into 4 * n even distributed candidate points, and
    % randomely pick n of them as top point x values.
    pm = randperm(4 * n, n);
    topx  = 16 * pm / (4 * n);

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

    % return squares that enclose the trangles.
    ptsx = [topx', rx', lx'];
    ptsy = [topy', ry', ly'];

    rightBond = max(ptsx, [], 2);
    leftBond = min(ptsx, [], 2);
    upperBond = max(ptsy, [], 2);
    lowerBond = min(ptsy, [], 2);

    squares = zeros(n, 4);
    squares(:, 1) = upperBond;
    squares(:, 2) = leftBond;
    squares(:, 3) = lowerBond;
    squares(:, 4) = rightBond;
    
    % examine to make sure all squares are accurate.
    % drawx = zeros(n, 5);
    % drawx(:, 1) = leftBond;
    % drawx(:, 2) = leftBond;
    % drawx(:, 3) = rightBond;
    % drawx(:, 4) = rightBond;
    % drawx(:, 5) = leftBond;
    % 
    % drawy = zeros(n, 5);
    % drawy(:, 1) = upperBond;
    % drawy(:, 2) = lowerBond;
    % drawy(:, 3) = lowerBond;
    % drawy(:, 4) = upperBond;
    % drawy(:, 5) = upperBond;

    % convert square coord to pixle coord.

    % create figure.
    [~, ~] = getNextFigure(1, 'sample', 'wcut', 2, 'hcut', 2);
    
    for i = 1:n
        hold on
        fill([topx(i) rx(i) lx(i)], [topy(i) ry(i) ly(i)], 'r');
        % plot(drawx(i, :), drawy(i, :), 'b-', 'LineWidth',3);
    end
    axis off
end