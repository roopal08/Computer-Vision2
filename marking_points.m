clc;clear;
%code to mark the world points and their respective image points. 

x=0:4;
y=0:2;
z=0:4;
world_co=[];


for i=0:4;
    for j=0:2
            world_co=vertcat(world_co,[i,j,0,1]);
    end
end
for i=0:4
    for j=1:4
            world_co=vertcat(world_co,[i,0,j,1]);
    end
end

im = imread('../Images/measurement.jpeg');
figure,imshow(im);
[x,y]=getpts();
image_co = horzcat(x,y);

save('./variables/world_coordinates','world_co','image_co')