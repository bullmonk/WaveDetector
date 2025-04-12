function [tbl] = fetchJSON(file, target)
    txt = fileread(file{1});
    data = jsondecode(txt);

    gapnum = data.gap;
    space = strrep(num2str(data.space), '.', '');
    legend = ['-' num2str(gapnum) '-gap-space-' space];
    legend = strcat(target, legend);

    iou = data.iou';

    switch target{1}
        case 'segp'
            tar = data.segprecision';
        case 'segr'
            tar = data.segrecall';
        case 'boxp'
            tar = data.boxprecision';
        case 'boxr'
            tar = data.boxrecall';
        otherwise
            disp('Unknown target.');
    end

    headers = cellstr(['legend' strrep(string(iou), '.', '_')]);
    tar = [0 tar];
    tbl = array2table(tar, 'VariableNames', headers);
    tbl.legend = legend;
end