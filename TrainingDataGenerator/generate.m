% generate 100 images with labels, 80 train 20 validation.

for i=1:80
    createOneSample(5, 'data/images/train', 'data/labels/train', ['trainImg' num2str(i)]);
end

for i=1:20
    createOneSample(5, 'data/images/val', 'data/labels/val', ['valImg' num2str(i)]);
end