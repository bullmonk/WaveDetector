coords = readtable("test.txt");

img = imread('test.png');
imshow(img);
[height,width,~] = size(img);

cx = coords{:, 2} * width;
cy = coords{:, 3} * height;
% cy = cell(1, 11);
% cy{:,1} = 0.5;
% cy = cy{:, 1} * height;
wids = coords{:, 4} * width;
heis = coords{:, 5} * height;


n = size(cx, 1);

% draw box.
drawx = zeros(n, 5);
drawx(:, 1) = (cx - wids/2)';
drawx(:, 2) = (cx - wids/2)';
drawx(:, 3) = (cx + wids/2)';
drawx(:, 4) = (cx + wids/2)';
drawx(:, 5) = (cx - wids/2)';

drawy = zeros(n, 5);
drawy(:, 1) = (cy + heis/2)';
drawy(:, 2) = (cy - heis/2)';
drawy(:, 3) = (cy - heis/2)';
drawy(:, 4) = (cy + heis/2)';
drawy(:, 5) = (cy + heis/2)';

hold on
% plot(cx', coords{:, 5} * height', 'black.', 'MarkerSize', 40);

colors = {'red-', 'yellow-', 'blue-', 'green-', 'black-', 'white-','white-','white-','white-','white-','white-'};

for i = 1:n
    plot(drawx(i, :), drawy(i, :), colors{i}, 'LineWidth',3);
end


hold off