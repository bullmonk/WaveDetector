function [] = resizeImage(fname, oname)
    rgb = imread(fname);
    rgbm = RemoveWhiteSpace(rgb);
    rgbm = imresize(rgbm, [640 640]);

    if nargin < 2
        imwrite(rgbm, fname);
    else
        imwrite(rgbm, oname);
    end
end

