clear;
clc;

h = 8.66;

%各材料密度
p1 = 300;
p2 = 862;
p3 = 74.2;
p4 = 1.18;

%各材料比热
c1 = 1377;
c2 = 2100;
c3 = 1726;
c4 = 1005;

%各材料导热系数
k1 = 0.082;
k2 = 0.37;
k3 = 0.045;
k4 = 0.028;

%傅里叶公式常数
nmd1 = k1/(c1*p1);
nmd2 = k2/(c2*p2);
nmd3 = k3/(c3*p3);
nmd4 = k4/(c4*p4);

x1 = 6;
x2 = 80;
x3 = 36;
x4 = 55;
x_num = x1+x2+x3+x4;
t_num = 72001;

jj = 2000;
p = ones(21,2);
%a = xlsread('a.xlsx','sheet2');
for x2 = 140:1:160
   x_num = x1+x2+x3+x4;
   data = ones(t_num,x_num);
   data(:,1) = 65;
   data(t_num,:) = 37;
   for k = 1:1:t_num-1
        for m = 1:1:x_num-2
            if m>0
                data(t_num-k,1+m) = data(t_num+1-k,1+m)+nmd1*1e6*(data(t_num+1-k,m)-2*data(t_num+1-k,m+1)+data(t_num+1-k,m+2));
                if data(t_num-k,1+m)<data(t_num-k+1,1+m)||data(t_num-k,1+m)>data(t_num-k,m)
                   data(t_num-k,1+m) = data(t_num-k,m)+(data(t_num-k,m)-data(t_num-k+1,1+m))/2; 
                end
                %data(t_num-k,1+m) = round(data(t_num-k,1+m)*jj)/jj;
            elseif m>x&&m<(x1+x2)
                data(t_num-k,1+m) = data(t_num+1-k,1+m)+nmd2*1e6*(data(t_num+1-k,m)-2*data(t_num+1-k,m+1)+data(t_num+1-k,m+2));
                if data(t_num-k,1+m)<data(t_num-k+1,1+m)||data(t_num-k,1+m)>data(t_num-k,m)
                   data(t_num-k,1+m) = data(t_num-k,m)+(data(t_num-k,m)-data(t_num-k+1,1+m))/2; 
                end
                %data(t_num-k,1+m) = round(data(t_num-k,1+m)*jj)/jj;
            elseif m>(x1+x2)&&m<(x1+x2+x3)
                data(t_num-k,1+m) = data(t_num+1-k,1+m)+nmd3*1e6*(data(t_num+1-k,m)-2*data(t_num+1-k,m+1)+data(t_num+1-k,m+2));
                if data(t_num-k,1+m)<data(t_num-k+1,1+m)||data(t_num-k,1+m)>data(t_num-k,m)
                   data(t_num-k,1+m) = data(t_num-k,m)+(data(t_num-k,m)-data(t_num-k+1,1+m))/2; 
                end
                %data(t_num-k,1+m) = round(data(t_num-k,1+m)*jj)/jj;
            elseif m>(x1+x2+X3)
                data(t_num-k,1+m) = data(t_num+1-k,1+m)+nmd4*1e6*(data(t_num+1-k,m)-2*data(t_num+1-k,m+1)+data(t_num+1-k,m+2));
                if data(t_num-k,1+m)<data(t_num-k+1,1+m)||data(t_num-k,1+m)>data(t_num-k,m)
                   data(t_num-k,1+m) = data(t_num-k,m)+(data(t_num-k,m)-data(t_num-k+1,1+m))/2; 
                end
                %data(t_num-k,1+m) = round(data(t_num-k,1+m)*jj)/jj;
            end
            if m>x_num-3
                data(t_num-k,1+m) = data(t_num+1-k,1+m)+nmd4*1e6*(data(t_num+1-k,m)-2*data(t_num+1-k,m+1)+data(t_num+1-k,m+2));
                %data(t_num-k,1+m) = round(data(t_num-k,1+m)*jj)/jj;
                data(t_num-k,2+m) = -(data(t_num+1-k,2+m)-h*data(t_num-k,1+m))/(h-1);
                %data(t_num-k,2+m) = round(data(t_num-k,2+m)*jj)/jj;
                if data(t_num-k,1+m)<data(t_num-k+1,1+m)||data(t_num-k,1+m)>data(t_num-k,m)
                   data(t_num-k,1+m) = data(t_num-k,m)+(data(t_num-k,m)-data(t_num-k+1,1+m))/2; 
                end
                if data(t_num-k,2+m)<data(t_num-k+1,2+m)||data(t_num-k,2+m)>data(t_num-k,1+m)
                   data(t_num-k,2+m) = data(t_num-k,1+m)+(data(t_num-k,1+m)-data(t_num-k+1,2+m))/2; 
                end
            end
        end
        if mod(k,1000) == 0
            x = 1;
        end
   end
    p(x2-139,1) = data(6000,x_num);
    p(x2-139,2) = data(1,x_num);
end
x = 141:161;
y1 = p(:,1);
%y1 = 1:21;
y2 = p(:,2);
%y2 = (1:21)+2;
plot(x,y1,'red');
hold on
plot(x,y2,'blue');
legend('55分钟时体表温度','60分钟时体表温度');
hold on
plot([140,155],[y1(15),y1(15)],'green');
plot([155,155],[40,y1(15)],'green');
plot([140,155],[y2(15),y2(15)],'green');
plot([155,155],[40,y2(15)],'green');
title({'不同的第Ⅱ层介质厚度下的皮肤温度'});
xlabel('140<d<160');
ylabel('40<y<50');
text(150,y1(15)+0.5,'d=15.5mm,t=60min,U<47');
text(150,y2(15)+0.5,'d=15.5mm,t=55min,U<44');

