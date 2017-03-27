clc;clear;
% code for calibration using ransac algorithm.
% world coordinates and imgage ocordinates are already known.


padding = [0,0,0,0];
load('./variables/world_coordinates1');%this has 'world_co' ->4d (vec) and 'image_co' ->2d (vec) coordinates (horizontal vectors)

num=7;

iter= 20;
thresh=20;
max=0;
for i=1:iter
    ran = randperm(size(world_co,1));
    M=[];

    for i=ran(1:num)
        M=vertcat(M,[world_co(i,:),padding,-image_co(i,1)*world_co(i,:);padding,world_co(i,:),-image_co(i,2)*world_co(i,:)]);
    end

    [U,S,V] = svd(M);

    projection_matrix = [V(1:4,end)';V(5:8,end)';V(9:12,end)']; %projection matrix.

    check= projection_matrix*world_co';
    x = check(1,:)./check(3,:);
    y = check(2,:)./check(3,:);
    dis = sqrt((image_co(:,1)-x').^2+(image_co(:,2)-y').^2);
    inliers = find(dis<=thresh);
    if(length(inliers)>max)
        sub = inliers;
    end
    
end

M=[];
for i=sub'
        M=vertcat(M,[world_co(i,:),padding,-image_co(i,1)*world_co(i,:);padding,world_co(i,:),-image_co(i,2)*world_co(i,:)]);
end

    [U,S,V] = svd(M);

solution = [V(1:4,end)';V(5:8,end)';V(9:12,end)'];
check= solution*world_co';
    x = check(1,:)./check(3,:);
    y = check(2,:)./check(3,:);
im=imread('./images/measure.jpg');%/measurements
figure,imshow(im);

hold on;
plot(x,y,'g*');