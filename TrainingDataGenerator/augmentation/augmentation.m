% ==== flip images ====
files = recursiveDir('images', 'FileType', '.png');
catname = @(i) fullfile(files(i).folder, files(i).name);

% input file names.
fns = arrayfun(catname, 1:size(files, 1), 'UniformOutput',false);

% target file names.
augname = @(i) fullfile(files(i).folder, ['aug_' files(i).name]);
tns = arrayfun(augname, 1:size(files, 1), 'UniformOutput', false);

% add flip augmentation.
flipx = @(i) flipImageX(fns{i}, tns{i});
arrayfun(flipx, 1:size(files, 1));

% ==== create labels ====
txts = recursiveDir('labels', 'FileType', '.txt');
catname = @(i) fullfile(txts(i).folder, ['aug_' txts(i).name]);
tts = arrayfun(catname, 1:size(txts, 1), 'UniformOutput',false);
T = table();
creatempty = @(i) writetable(T, tts{i}, "WriteVariableNames", false);
arrayfun(creatempty, 1:size(txts, 1));
