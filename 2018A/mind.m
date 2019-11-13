clc,clear;
%各材料密度
p = [300 862 74.2 1.18];

%各材料比热
c = [1377 2100 1726 1005];

%各材料导热系数
k = [0.082 0.37 0.045 0.028];

%定义步长
t_buchang = 1;
x_buchang = 1;

%定义常数r
r = le6*(t_buchang./x_buchang*x_buchang)* k./(p.*c);

%定义厚度
d2 = 0.6:0.01:25;
len = 1:length(d2);%方便选到厚度值
d2 = round(d2(len)*10);
d = [6 d2 36 55];%各层材料厚度

a = xlsread('a.xlsx','sheet2');
x_num = sum(d);%矩阵求和即是防护服总厚度
t_num = 5400;、
%将x I等分，将t J等分
temp = zeros(x_num,t_num);%离散化的方程形式（包含该方程横纵坐标个数）


