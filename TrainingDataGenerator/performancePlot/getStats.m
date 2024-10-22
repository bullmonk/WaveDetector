function [tbl, precision, recall]=getStats(originFolder, predictedFolder, xmin, ymin, IoUthres)
    origins = filterTables(loadLabels(originFolder), xmin, ymin);
    predicts = filterTables(loadLabels(predictedFolder), xmin, ymin);

    npred = size(predicts, 2);
    norigin = size(origins, 2);

    assert(norigin == npred, 'should have same amount of origins and predicts');

    [totOrigin, totPred, TP_cnt, FP_cnt, FN_cnt] = arrayfun(@(i) getPairStats(origins{i}, predicts{i}, IoUthres), 1:npred, 'UniformOutput',false);

    totOrigin = cell2mat(totOrigin)';
    totPred = cell2mat(totPred)';
    TP_cnt = cell2mat(TP_cnt)';
    FP_cnt = cell2mat(FP_cnt)';
    FN_cnt = cell2mat(FN_cnt)';

    result = zeros(npred, 2);
    result(:, 1) = TP_cnt ./ (TP_cnt + FP_cnt);
    result(:, 2) = TP_cnt ./ (TP_cnt + FN_cnt);

    tbl = array2table(result, 'VariableNames', {'precision', 'recall'});
    TP = sum(TP_cnt);
    FP = sum(FP_cnt);
    FN = sum(FN_cnt);
    precision = TP / (TP + FP);
    recall = TP / (TP + FN);
end