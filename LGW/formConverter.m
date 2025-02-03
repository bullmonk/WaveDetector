coords = load("test_LGW.txt");

figure(9)
clf
img = imread('test_LGW.png');
imshow(img);
[height,width,~] = size(img);

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
