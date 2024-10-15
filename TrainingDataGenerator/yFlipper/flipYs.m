files = recursiveDir('../labels', 'FileType', '.txt');

catname = @(i) fullfile(files(i).folder, files(i).name);
fns = arrayfun(catname, 1:size(files, 1), 'UniformOutput',false);

rewrite = @(i) yFlipper(fns{i});
arrayfun(rewrite, 1:size(fns, 2));