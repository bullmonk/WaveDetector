coords = load("test_LGW.txt");
% contains 10x84 numbers
% 10 represents 10 LGW signals
% 84 represents 42 x coordinates, and 42 y coordinates
% x1,x2,x3...,x42, y1,y2,y3,...y42

figure(9)
clf
img = imread('test_LGW.png');
imshow(img);
[height,width,~] = size(img);

sz=size(coords);
nrec=sz(1);
np=sz(2)/2;

cx = coords(:, 1:np) * width;
cy = (1-coords(:, np+1:2*np)) * height;


n = size(cx, 1);


hold on
% plot(cx', coords{:, 5} * height', 'black.', 'MarkerSize', 40);

colors = {'red-', 'yellow-', 'blue-', 'green-', 'black-', 'white-'};

for i = 1:nrec
    plot(cx(i, [1:end,1]), cy(i, [1:end,1]), colors{mod(i,6)+1}, 'LineWidth',3);
    % to form a polygon, the first coordinate is added to the end.
end

hold off