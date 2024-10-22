function[out] = removeSmalls(in, xmin, ymin)
    out = in(in.cx >= xmin & in.cy >= ymin, :);
end