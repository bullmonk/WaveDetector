function [tbl, cnt1, cnt2, cnt3, cnt4] = markPairBox(originTbl, predTbl, IoUthres)
% for the last column of tbl, marker:
% value 1: box from origin, that has been predicted.
% value 2: box from origin, that has not been predicted.
% value 3: box from predict, that miss all origin.
% value 4: box from predict, that hit at least one origin.

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

    % calculate IoU match matrix.
    IoUMatch = (intsec ./ ground) > IoUthres; % ground is always positive
    
    % row is pred, col is origin
    boxesPred(sum(IoUMatch, 2) > 0, 5) = 4; %4 marks correct predict.
    boxesPred(sum(IoUMatch, 2) <= 0, 5) = 3; % 3 marks false prediction.

    boxesOrigin(sum(IoUMatch, 1) > 0, 5) = 1; % 1 marks picked origin.
    boxesOrigin(sum(IoUMatch, 1) <= 0, 5) = 2; % 2 marks unpicked origin.

    cmb = [boxesOrigin; boxesPred];
    lastcol = cmb(:, 5)';
    cnt1 = sum(lastcol == 1);
    cnt2 = sum(lastcol == 2);
    cnt3 = sum(lastcol == 3);
    cnt4 = sum(lastcol == 4);

    tbl = array2table(cmb, "VariableNames", {'cx', 'cy', 'width', 'height', 'marker'});
end