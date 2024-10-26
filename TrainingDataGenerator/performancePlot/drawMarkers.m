clear; close all; clc;

[tbls, FNnorm, FPnorm, pnames, tnames, FNrank, FPrank] = markAll('origin', 'pred', 0.2, 0.5, 0.4);

nRows = size(FNnorm, 2);
varNames = {'undiscoveredRank', 'misspredictionRank'};
varTypes = {'string', 'string'};

tbl = table('Size', [nRows, numel(varNames)], 'VariableTypes', varTypes, 'VariableNames', varNames);
tbl.undiscoveredRank = FNrank';
tbl.misspredictionRank = FPrank';

arrayfun(@(i) drawOneMarker(tbls{i}, pnames{i}, tnames{i}), 1:nRows, 'UniformOutput', false);

writetable(tbl, fullfile('marker', 'rank.csv'), 'WriteVariableNames', true);