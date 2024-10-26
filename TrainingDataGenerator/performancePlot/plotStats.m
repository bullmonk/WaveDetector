close all; clear; clc;

predFolder = 'pred';
originFolder = 'origin';


xlim = 0:0.01:0.2;
ylim = 0:0.025:0.5;
IoUthres = 0.4;

[~, prec, recall] = arrayfun(@(i) getStats(originFolder, predFolder, xlim(i), ylim(i), IoUthres), 1:size(xlim,2), 'UniformOutput', false);
prec = cell2mat(prec)';
recall = cell2mat(recall)';

F1 = 2 ./ (1./prec + 1./recall);

figure
plot(xlim, prec, 'blue-', 'LineWidth', 4);
hold on
plot(xlim, recall, 'red-', 'LineWidth', 4);
hold off
legend('precision','recall');
xlabel('width threshold');
ylabel('precision/recall')

figure
plot(ylim, prec, 'blue-', 'LineWidth', 4);
hold on
plot(ylim, recall, 'red-', 'LineWidth', 4);
hold off
legend('precision','recall');
xlabel('height threshold');
ylabel('precision/recall')

figure
plot(prec, recall, 'blue-', 'LineWidth', 4);
xlabel('precision');
ylabel('recall');

figure
plot(F1, 'blue-', 'LineWidth', 4);
legend('F1')