function [] = buildFolder(parent)
    items = dir(parent);

    isSubDir = [items.isdir] & ~ismember({items.name}, {'.', '..'});
    subDirs = items(isSubDir);
    folders = fullfile({subDirs.folder}, {subDirs.name});

    arrayfun(@(f) mkdir(fullfile(f, "images")), folders);
    arrayfun(@(f) mkdir(fullfile(f, "images", "train")), folders);
    arrayfun(@(f) mkdir(fullfile(f, "images", "val")), folders);
    arrayfun(@(f) mkdir(fullfile(f, "labels")), folders);
    arrayfun(@(f) mkdir(fullfile(f, "labels", "train")), folders);
    arrayfun(@(f) mkdir(fullfile(f, "labels", "val")), folders);
end