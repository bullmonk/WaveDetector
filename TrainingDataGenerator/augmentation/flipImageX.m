function [] = flipImageX(fname, oname)

    img = imread(fname);
    img = flip(img, 2);

    if nargin < 2
        imwrite(img, fname);
    else
        imwrite(img, oname);
    end
    
end