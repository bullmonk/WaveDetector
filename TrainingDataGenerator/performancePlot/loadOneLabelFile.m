function [tbl] = loadOneLabelFile(filename)
    tbl = readtable(filename, 'ReadRowNames', false, 'Delimiter', ' ');
    tbl.Properties.VariableNames = {'category', 'cx', 'cy', 'width', 'height'};
end