function[tbls, imgs] = loadLabels(folder)
% load all .txt label files under a specified folder
% tables are saved in an array of cell, each cell stores one table
% no variable names will be assumed in files.
% tables will be given column names: {'category', 'cx', 'cy', 'width', 'height'}
    files = recursiveDir(folder, 'FileType', '.txt');
    fnames = arrayfun(@(i) fullfile(files(i).folder, files(i).name), 1:size(files, 1), 'UniformOutput',false);
    tbls = arrayfun(@(i) loadOneLabelFile(fnames{i}), 1:size(fnames, 2), 'UniformOutput', false);
    imgs = arrayfun(@(i) strrep(files(i).name, '.txt', '.png'), 1:size(files, 1), 'UniformOutput', false);
end