clear;
clc;

h = 8.322;

%各材料密度
p = [300 862 74.2 1.18];

%各材料比热
c = [1377 2100 1726 1005];

%各材料导热系数
k = [0.082 0.37 0.045 0.028];

%傅里叶公式常数
nmd[1] = k1/(c1*p1);
nmd[2] = k2/(c2*p2);
nmd[3] = k3/(c3*p3);
nmd[4] = k4/(c4*p4);

x1 = 6;
x2 = 80;
x3 = 36;
x4 = 55;
x_num = x1+x2+x3+x4;
t_num = 72001;

jj = 10000;

a = xlsread('a','sheet2');
for x2 = 80:1:80%250
   x_num = x1+x2+x3+x4;
   data = ones(t_num,x_num);
   data(:,1) = 65;     %初始值
   data(t_num,:) = 37; %初始值
   
   for k = 1:1:t_num-1
        for m = 1:1:x_num-2
            if m > 0
                data(t_num-k,1+m) = data(t_num+1-k , 1+m) + nmd1*1e6*(data(t_num+1-k , m) - 2*data(t_num+1-k , m+1) + data(t_num+1-k,m+2));
                data(t_num-k,1+m) = round(data(t_num-k,1+m)*jj);
            elseif m > x && m < (x1+x2)
                data(t_num-k,1+m) = data(t_num+1-k,1+m) + nmd2*1e6*(data(t_num+1-k,m) - 2*data(t_num+1-k,m+1) + data(t_num+1-k,m+2));
                data(t_num-k,1+m) = round(data(t_num-k,1+m)*jj);
            elseif m>(x1+x2) && m<(x1+x2+x3)
                data(t_num-k,1+m) = data(t_num+1-k,1+m) + nmd3*1e6*(data(t_num+1-k,m) - 2*data(t_num+1-k,m+1) + data(t_num+1-k,m+2));
                data(t_num-k,1+m) = round(data(t_num-k,1+m)*jj);
            elseif m>(x1+x2+X3)
                data(t_num-k,1+m) = data(t_num+1-k,1+m) + nmd4*1e6*(data(t_num+1-k,m) - 2*data(t_num+1-k,m+1) + data(t_num+1-k,m+2));
                data(t_num-k,1+m) = round(data(t_num-k,1+m)*jj);
            end
            if m>x_num-3
                data(t_num-k,1+m) = data(t_num+1-k,1+m) + nmd4*1e6*(data(t_num+1-k,m) - 2*data(t_num+1-k,m+1) + data(t_num+1-k,m+2));
                data(t_num-k,1+m) = round(data(t_num-k,1+m)*jj);
                data(t_num-k,2+m) = -(data(t_num+1-k,2+m) - h*data(t_num-k,1+m))/(h-1);
                data(t_num-k,2+m) = round(data(t_num-k,2+m)*jj/10)*10;
                 %plot(1,1);
            end
        end
        if mod(k,1000) == 0
            x = 1;
        end
    end
end

data_r = ones(t_num,1);
for k = 1:1:5400
    for n = 1:1:10
        m = t_num+11-k*10-n;
        data_r(m,1) = a(k,2);
    end
    m = t_num+1-k;
    data_r(m,1) = a(k,2);
end
clear a;
data_l = ones(t_num,1)*75;
data_d = ones(1,x_num)*37;
data = ones(t_num,x_num);
data(:,1) = data_l(:,1);
data(:,x_num) = data_r(:,1);
data(t_num,:) = data_d(1,:);
for k = 1:1:t_num-1
    for m = 1:1:x_num-2
        if m>0
            data(t_num-k,1+m) =  data(t_num+1-k,1+m)+nmd1*1e6*(data(t_num+1-k,m)-2*data(t_num+1-k,m+1)+data(t_num+1-k,m+2));
        elseif m>6&&m<66
            data(t_num-k,1+m) =  data(t_num+1-k,1+m)+nmd2*1e6*(data(t_num+1-k,m)-2*data(t_num+1-k,m+1)+data(t_num+1-k,m+2));
        elseif m>66&&m<102
            data(t_num-k,1+m) =  data(t_num+1-k,1+m)+nmd3*1e6*(data(t_num+1-k,m)-2*data(t_num+1-k,m+1)+data(t_num+1-k,m+2));
        elseif m>102
            data(t_num-k,1+m) =  data(t_num+1-k,1+m)+nmd4*1e6*(data(t_num+1-k,m)-2*data(t_num+1-k,m+1)+data(t_num+1-k,m+2));
        end
    end
end
x = 1:1:x_num;
y = 1:1:t_num/10;
y = -y+54000;
data(1,153) = 48;
data_t = ones(5400,153);
for k = 1:1:5400
    data_t(k,:) = data(k*10,:);
end

x_x = 1:153;
y_y = data_t(5400-2000,:);
plot(x_x,y_y,'-');
% mesh(x,y,data_t);
% data_finally = ones(153,2);
% data_fiially = data(1,:);
% clear data;
 title({'2000秒时防热服各位置的温度变化曲线'});
 xlabel('0<=x<=15.2毫米');
 ylabel('37<=U<=75摄氏度');
% zlabel('37<=z<=75摄氏度');
