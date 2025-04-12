tbl = pack('plotdata', 'segp');

iouStr = tbl.Properties.VariableNames(2:end);
iou = cellfun(@str2double, strrep(iouStr, '_', '.'));
clear iouStr
legends = cell(1, height(tbl));

figure;
hold on;
lineHandles = gobjects(height(tbl), 1);

for i = 1:height(tbl)
    legends(i) = table2array(tbl(i, 1));
    row = table2array(tbl(i, 2:end));
    lineHandles(i) = plot(iou, row, 'LineWidth', 3);
end
hold off

legend(lineHandles, legends, 'FontSize', 16);

xlabel('IoU threshold', 'FontSize', 16);
ylabel('segment precision', 'FontSize', 16);
title('precision - IoU threshold');