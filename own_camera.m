clc;clear;
%code to mark the world points and their respective image points. 

x=0:2;
y=0:2;
z=0:2;
world_co=[];


for i=0:2;
            world_co=vertcat(world_co,[i,0,0,1]);
end
for i=1:2;
            world_co=vertcat(world_co,[0,i,0,1]);
end
for i=1:2;
            world_co=vertcat(world_co,[0,0,1,1]);
end
im = imread('./images/measure.jpg');
figure,imshow(im);
[x,y]=getpts();
image_co = horzcat(x,y);

save('./variables/world_coordinates1','world_co','image_co')