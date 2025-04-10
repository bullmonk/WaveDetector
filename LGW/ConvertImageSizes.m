folderPath = 'lgw1';
files = dir(folderPath);
files = files(~[files.isdir]);
fullfn = fullfile(folderPath, {files.name});

rsz = @(i) resizeImage(fullfn{i});
arrayfun(rsz, 1:size(fullfn, 2));