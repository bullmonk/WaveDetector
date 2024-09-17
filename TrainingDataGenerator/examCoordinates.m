img = imread('../plot/test.png');
imshow(img);
axis on
[height,width,~] = size(img);
hold on
center = [boxes(:,1) * width, height - boxes(:,2) * height];
plot(center(:,1), center(:, 2), 'g.', 'MarkerSize', 40);
hold off