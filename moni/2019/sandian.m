clc;
clear;
x1 = xlsread('fujian.xlsx','A3:A32');
y1 = xlsread('fujian.xlsx','B3:B32');
r1 = xlsread('fujian.xlsx','D3:D32');
x2 = xlsread('fujian.xlsx','F3:F34');
y2 = xlsread('fujian.xlsx','G3:G34');
r2 = xlsread('fujian.xlsx','I3:I34');
x3 = xlsread('fujian.xlsx','K3:K14');
y3 = xlsread('fujian.xlsx','L3:L14');
r3 = xlsread('fujian.xlsx','N3:N14');
subplot(1,3,1);
scatter(x1,y1,'r');
subplot(1,3,2);
scatter(x2,y2,'g');
subplot(1,3,3);
scatter(x3,y3,'b');
l = ones(30,30);
for i = 1:30
    for j = i:30
       l = x1(i)^2;
    end
end