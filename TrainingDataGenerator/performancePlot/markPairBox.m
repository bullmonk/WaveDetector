function [totOrigin, totPred, TP_cnt, FP_cnt, FN_cnt] = markPairBox(originTbl, predTbl, IoUthres)
    totOrigin = size(originTbl, 1);
    totPred = size(predTbl, 1);

    % calculate count of TP.
    boxesPred = tbl2rectArray(predTbl);
    boxesOrigin = tbl2rectArray(originTbl);

    % (i,j) element represent the intersection area between pred(i) and origin(j).
    intsec = rectint(boxesPred, boxesOrigin);

    % (i,j) element represent the union area of pred(i) and origin(j).
    areaPred = boxesPred(:, 3) .* boxesPred(:, 4); % align in row
    areaOrigin = (boxesOrigin(:, 3) .* boxesOrigin(:, 4))'; % align in col
    ground = zeros(totPred, totOrigin);
    ground = ground + areaPred + areaOrigin - intsec;

    % calculate IoU
    IoU = intsec ./ ground; % ground is always positive
    
    % calculate TP_cnt, which mean number of boxes in pred that found match
    % in origin.
    predFoundMatch = sum(IoU > IoUthres, 2); % each row is one record in pred.
    
    TP_cnt = sum(predFoundMatch > 0);
    FP_cnt = totPred - TP_cnt;
    FN_cnt = totOrigin - TP_cnt; % box in origin that hasn't been matched in pred.
    
end