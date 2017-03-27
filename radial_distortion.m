clc;clear;
load('./variables/world_coordinates'); %%image_co (marked)
load('./variables/image_points'); %this has 'points'.


% 1+k1*r+k2+r^2 equation

si = randperm(size(image_co,1));

r1 = norm(image_co(si(1),:));
r2 = norm(image_co(si(2),:));

c1 = mean([points(si(1),1)/image_co(si(1),1),points(si(1),2)/image_co(si(1),2)]);
c2 = mean([points(si(2),1)/image_co(si(2),1),points(si(2),2)/image_co(si(2),2)]);
syms k l

eqn1 = k*r1 + l*(r1^2) == c1-1;
eqn2 = k*r2 + l*(r2^2) == c2-1;

[A,B] = equationsToMatrix([eqn1, eqn2], [k, l]);
X = linsolve(A,B);
X(1)
X(2) 

% sol = solve([eqn1, eqn2], [k, l]);
