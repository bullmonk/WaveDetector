coords = load("chorus_label.mat").chorus_label;

dumpfn = @(i) row2f(coords(i,:), 'rbsp_snr_sweep', 'rbsp_waveform_snr');
arrayfun(dumpfn, 1:size(coords, 1));