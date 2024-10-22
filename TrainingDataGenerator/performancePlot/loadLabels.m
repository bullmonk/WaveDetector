function[tbls] = loadLabels(folder)
% load all .txt label files under a specified folder
% tables are saved in an array of cell, each cell stores one table
% no variable names will be assumed in files.
% tables will be given column names: {'category', 'cx', 'cy', 'width', 'height'}
    files = recursiveDir(folder, 'FileType', '.txt');
    catname = @(i) fullfile(files(i).folder, files(i).name);
    fnames = arrayfun(catname, 1:size(files, 1), 'UniformOutput',false);

    readtbl = @(i) loadOneLabelFile(fnames{i}); 
    tbls = arrayfun(readtbl, 1:size(fnames, 2), 'UniformOutput', false);
end