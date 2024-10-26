function [rects] = tbl2rectArray(tbl)
    cx = tbl.cx;
    cy = tbl.cy;
    wids = tbl.width;
    heis = tbl.height;
    r = size(tbl, 1);

    rects = zeros(r, 5);
    rects(:, 1) = cx - wids/2;
    rects(:, 2) = cy - heis/2;
    rects(:, 3) = wids;
    rects(:, 4) = heis;
end