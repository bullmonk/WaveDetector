[hf, encl_pts]=buildTrainingData(1);

figure(9)
clf
img = imread('LGW/LGW_00001_LGW.png');
imshow(img);
[height,width,~] = size(img);

sz=size(encl_pts);
nrec=sz(1);
np=sz(2)/2;

cx = encl_pts(:, 1:np) * width;
cy = (1-encl_pts(:, np+1:2*np)) * height;


n = size(cx, 1);

% define annotation json
example.image = 'LGW/LGW_00001_LGW.png';
example.width = width;
example.height = height;
example.category_id = 0;
example.rle = '';

% create array of annotaions
annotations = createArray(1,n,Like=example);

for i=1:n
    BW = roipoly(img, cx(i,:), cy(i,:));
    stats = regionprops(BW, 'BoundingBox');
    

    annotation.id = i;
    annotation.image_id = 1;
    annotation.segmentation.size = [width, height];
    annotation.segmentation.counts = rle_code;
    annotation.category_id = 0;
    annotations(i) = annotation;

    % build a josn item
end

% combine json item
image_data.id = 1;
image_data.file_name="LGW/LGW_00001_LGW";
image_data.width = width;
image_data.height = height;
num_regions = n;

% only 1 category which is lgw
category.id = 0;
category.name = "LGW";
categories = createArray(1,1,Like=category);
categories(1) = category;

% put all together
json_data.image = image_data;
json_data.annotations = annotations;
json_data.categories = categories;

json_text = jsonencode(json_data, 'PrettyPrint', true);
fid = fopen('training.json','w');
fprintf(fid, '%s', json_text);
fclose(fid);
