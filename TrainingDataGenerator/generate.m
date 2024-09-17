% generate 100 images with labels, 80 train 20 validation.

folders = {
    './data', ...
    './data/images', ...
    './data/images/train', ...
    './data/images/val', ...
    './data/labels', ...
    './data/labels/train', ...
    './data/labels/val'
};

for i = 1:length(folders)
    mkdir(folders{i});
end

for i=1:80
    createOneSample(5, 'data/images/train', 'data/labels/train', ['trainImg' num2str(i)]);
end

for i=1:5
    createOneSample(5, 'data/images/val', 'data/labels/val', ['valImg' num2str(i)]);
end