function [tbls, FNnorm, FPnorm, pnames, tnames, FNrank, FPrank] = markAll(originFolder, predictedFolder, xmin, ymin, IoUthres)
    [origins, opOrigin] = loadLabels(originFolder);
    origins = filterTables(origins, xmin, ymin);
    [predicts, opPred] = loadLabels(predictedFolder);
    predicts = filterTables(predicts, xmin, ymin);

    npred = size(predicts, 2);
    norigin = size(origins, 2);

    assert(norigin == npred, 'should have same amount of origins and predicts');
    assert(isequal(opOrigin, opPred));


    [tbls, cnt1, cnt2, cnt3, cnt4] = arrayfun(@(i) markPairBox(...
        origins{i}, predicts{i}, IoUthres), 1:npred, 'UniformOutput',false);

    cnt1 = cell2mat(cnt1);
    cnt2 = cell2mat(cnt2);
    cnt3 = cell2mat(cnt3);
    cnt4 = cell2mat(cnt4);

    FNnorm = cnt2 ./ (cnt1 + cnt2);
    FNnorm(isnan(FNnorm)) = 0;
    FPnorm = cnt3 ./ (cnt3 + cnt4);
    FPnorm(isnan(FPnorm)) = 0;
    
    pnames = arrayfun(@(i) fullfile('imgs', opOrigin{i}), 1:npred, 'UniformOutput', false);
    tnames = arrayfun(@(i) fullfile('marker', opOrigin{i}), 1:npred, 'UniformOutput', false);

    [~, FNrankI] = sort(FNnorm, 2, 'descend');
    FNrank = pnames(FNrankI);
    [~, FPrankI] = sort(FPnorm, 2, 'descend');
    FPrank = pnames(FPrankI);
end