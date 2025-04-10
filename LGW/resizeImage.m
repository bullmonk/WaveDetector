function [] = resizeImage(fname, oname)
    rgb = imread(fname);
    rgbm = RemoveWhiteSpace(rgb);
    rgbm = imresize(rgbm, [640 640]);

    if nargin < 2
        oname = strrep(fname, "lgw1", "lgw2");
    end
    imwrite(rgbm, oname);
end

