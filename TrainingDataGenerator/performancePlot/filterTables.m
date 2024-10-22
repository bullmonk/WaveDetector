function[out] = filterTables(in, xmin, ymin)
    filterOp = @(i) removeSmalls(in{i}, xmin, ymin);
    out = arrayfun(filterOp, 1:size(in, 2), 'UniformOutput', false);
end