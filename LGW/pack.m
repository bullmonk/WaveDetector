function [tbl]=pack(folder, target)
    allitems = dir(folder);
    files = allitems(~[allitems.isdir]);
    fnames = fullfile({files.folder}, {files.name});

    f = @(x, y) fetchJSON(x, y);

    targets = repelem({target}, 1, size(fnames, 2));
    tbls = arrayfun(f, fnames, targets, 'UniformOutput', false);
    tbl = vertcat(tbls{:});
end