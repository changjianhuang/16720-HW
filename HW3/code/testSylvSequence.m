load(fullfile('..','data','sylvseq.mat'));
load(fullfile('..','data','sylvbases.mat'));

rects = [102,62,156,108];
rects1 = rects;
rects2 = rects;
corner_points1 = zeros(2,4);
corner_points2 = zeros(2,4);
[height, width, frame_num] = size(frames);

for i = 1:frame_num - 1
    corner_points1(:,1) = [rects1(1);rects1(2)];
    corner_points1(:,2) = [rects1(1);rects1(4)];
    corner_points1(:,3) = [rects1(3);rects1(4)];
    corner_points1(:,4) = [rects1(3);rects1(2)];
    corner_points2(:,1) = [rects2(1);rects2(2)];
    corner_points2(:,2) = [rects2(1);rects2(4)];
    corner_points2(:,3) = [rects2(3);rects2(4)];
    corner_points2(:,4) = [rects2(3);rects2(2)];
    img = double(frames(:,:,i));
    imshow(frames(:,:,i));
    hold on;
    line(corner_points1(1,1:2),corner_points1(2,1:2), 'Color','yellow','LineWidth',1);
    line(corner_points1(1,2:3),corner_points1(2,2:3), 'Color','yellow','LineWidth',1);
    line(corner_points1(1,3:4),corner_points1(2,3:4), 'Color','yellow','LineWidth',1);
    line([corner_points1(1,4);corner_points1(1,1)],[corner_points1(2,4);corner_points1(2,1)], 'Color','yellow','LineWidth',1);
    line(corner_points2(1,1:2),corner_points2(2,1:2), 'Color','green','LineWidth',1);
    line(corner_points2(1,2:3),corner_points2(2,2:3), 'Color','green','LineWidth',1);
    line(corner_points2(1,3:4),corner_points2(2,3:4), 'Color','green','LineWidth',1);
    line([corner_points2(1,4);corner_points2(1,1)],[corner_points2(2,4);corner_points2(2,1)], 'Color','green','LineWidth',1);
    hold off;
    pause(0.02);
    img_next = double(frames(:,:,i+1));
    [u1,v1] = LucasKanadeBasis(img, img_next, rects1, bases);
    [u2,v2] = LucasKanade(img, img_next, rects2);
    rects1 = [rects1(1)+u1 rects1(2)+v1 rects1(3)+u1 rects1(4)+v1];
    rects2 = [rects2(1)+u2 rects2(2)+v2 rects2(3)+u2 rects2(4)+v2];
    rects1 = round(rects1);
    rects2 = round(rects2);
end

save(fullfile('..','results','sylvseqrects.mat', 'rects'));
