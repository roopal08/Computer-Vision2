clc;clear;
% code for DLT calibration.
% world coordinates and imgage ocordinates are already known.

padding = [0,0,0,0];
load('./variables/world_coordinates1');%this has 'world_co' ->4d (vec) and 'image_co' ->2d (vec) coordinates (horizontal vectors)
M=[];

for i=1:size(world_co,1)
    M=vertcat(M,[world_co(i,:),padding,-image_co(i,1)*world_co(i,:);padding,world_co(i,:),-image_co(i,2)*world_co(i,:)]);
end

[U,S,V] = svd(M);

projection_matrix = [V(1:4,end)';V(5:8,end)';V(9:12,end)']; %projection matrix.

check= projection_matrix*world_co';
x = check(1,:)./check(3,:);
y = check(2,:)./check(3,:);

im=imread('./images/measure.jpg');%measurements
figure,imshow(im);

hold on;
plot(x,y,'y*');
plot(image_co(:,1),image_co(:,2),'r.');
H = projection_matrix(:,1:3);
inv_H = inv(H);
center = -inv_H*projection_matrix(:,4);
[Q,R] = qr(inv_H);%QR decomposition Q is rotation and R is triangular.
Rotation_matrix = Q';
Internal=inv(R);

points=[x',y'];
save('./variables/image_points','points');