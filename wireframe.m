clear;clc;

load('./variables/image_points'); %this has 'points'.

distances = pdist2(points,points);
one=[];
two=[];
for i=1:size(distances,1)
    [sorted,indices]=sort(distances(:,i));
    one=vertcat(one,[i;i;i;i]);
    two=vertcat(two,indices(1:4));
end

im=imread('./images/measurements.jpg');
figure,imshow(im);
hold on
points=floor(points);
x = horzcat(points(one(:,1),1),points(two(:,1),1));
y = horzcat(points(one(:,1),2),points(two(:,1),2));   
plot(x',y');
