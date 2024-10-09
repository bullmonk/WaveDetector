coords = load("chorus_label.mat").chorus_label;

dumpfn = @(i) row2f(coords(i,:));
arrayfun(dumpfn, 1:size(coords, 1));