
clearvars
close all;

addpath('../datasets');
addpath('../utils');
addpath('../week2');

data = 'traffic';
[T1, nframes, dirInputs] = load_data(data);
input_files = list_files(dirInputs);
dirGT = strcat('../datasets/cdvd/dataset/cameraJitter/traffic/groundtruth/');

block_size = 10;
search_area = 20;

row1 = 150;
row2 = 200;
col1 = 40;
col2 = 90;
figure()
t = T1;
for i = 1:(nframes-1)
    filenumber1 = sprintf('%06d', t);
    filepath1 = strcat(dirInputs, 'in', filenumber1, '.jpg');
    image1 = imread(filepath1);
    
    filenumber2 = sprintf('%06d', t+1);
    filepath2 = strcat(dirInputs, 'in', filenumber2, '.jpg');
    image2 = imread(filepath2);
    
    sub_image1 = image1(row1:row2,col1:col2);
    sub_image2 = image2(row1:row2,col1:col2);
%     [flow_estimation_x, flow_estimation_y]  = block_matching(sub_image1, sub_image2, block_size, search_area);
    [flow_estimation_x, flow_estimation_y]  = block_matching(image1, image2, block_size, search_area);
    
    step = 5;
%     r1_step = (row1:step:row2) - row1 + 1;
%     r2_step = (col1:step:col2) - col1 + 1;
    r1_step = (row1:step:row2);
    r2_step = (col1:step:col2);
    flowx_step = flow_estimation_x(r1_step, r2_step);
    flowy_step = flow_estimation_y(r1_step, r2_step);
    
    
    imshow(image1)
    hold on
    plot([col1 col2], [row1 row1], 'b')
    plot([col1 col2], [row2 row2], 'b')
    plot([col1 col1], [row1 row2], 'b')
    plot([col2 col2], [row1 row2], 'b')
%     quiver(r2_step+col1-1, r1_step+row1-1, flowx_step, flowy_step, 0)
    quiver(r2_step, r1_step, flowx_step, flowy_step, 0)
    hold off
    pause(0.1)
    
    t = t + 1;
end