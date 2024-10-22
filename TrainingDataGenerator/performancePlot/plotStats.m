predFolder = 'pred';
originFolder = 'origin';

lim = [0.1, 0.15, 0.2, 0.25, 0.3];
IoUthres = 0.5;

[~, prec, recall] = arrayfun(@(i) getStats(originFolder, predFolder, lim(i), lim(i), IoUthres), 1:5, 'UniformOutput', false);

figure
plot(prec, 'blue-')
hold on
plot(recall, 'red-')
hold off