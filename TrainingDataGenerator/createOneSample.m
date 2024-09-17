function [] = createOneSample(n, imageFolder, labelFolder, sampleName) % n represent number of triangles
    boxes = triangleGenerator(n, 'imageFolder', imageFolder, 'fileName', [sampleName '.png']);
    dat = zeros(n, 5);
    dat(:,2:5) = boxes;
    tbl = array2table(dat, 'VariableNames', {'label', 'cx', 'cy', 'width', 'height'});
    writetable(tbl, fullfile(labelFolder, [sampleName '.txt']), 'Delimiter', ' ', 'WriteVariableNames', false);
end