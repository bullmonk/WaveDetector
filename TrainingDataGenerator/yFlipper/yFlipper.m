function []=yFlipper(fname)
    T = readtable(fname);
    T{:,3} =  1 - T{:,3};
    writetable(T, fname, "WriteVariableNames", false, "Delimiter", ' ');
end