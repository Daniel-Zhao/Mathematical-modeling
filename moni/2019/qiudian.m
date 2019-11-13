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

p = 1;
x = zeros(4960,1);
y = zeros(4960,1);
z = zeros(4960,1);
% a1 = (x - x1(1))^2 + (y - y1(1))^2 + z^2 == r1(1)^2;
% a2 = (x - x1(3))^2 + (y - y1(3))^2 + z^2 == r1(3)^2;
% a3 = (x - x1(7))^2 + (y - y1(7))^2 + z^2 == r1(7)^2;
% a1 = (x - x2(1))^2 + (y - y2(1))^2 + z^2 == r2(1)^2;
% a2 = (x - x2(6))^2 + (y - y2(6))^2 + z^2 == r2(6)^2;
% a3 = (x - x2(32))^2 + (y - y2(32))^2 + z^2 == r2(32)^2;
% a1 = (x - x3(1))^2 + (y - y3(1))^2 + z^2 == r3(1)^2;
% a2 = (x - x3(2))^2 + (y - y3(2))^2 + z^2 == r3(2)^2;
% a3 = (x - x3(3))^2 + (y - y3(3))^2 + z^2 == r3(3)^2;
for n = 1:1:32
    for m = 1:1:32
       for k = 1:1:32
          if (n~=m)&&(n~=k)&&(m~=k) == 1
              syms x0;
              syms y0;
              syms z0;
            a1 = (x0 - x2(n)).^2 + (y0 - y2(n)).^2 + z0^2 == r2(n).^2;
            a2 = (x0 - x2(m)).^2 + (y0 - y2(m)).^2 + z0^2 == r2(m).^2;
            a3 = (x0 - x2(k)).^2 + (y0 - y2(k)).^2 + z0^2 == r2(k).^2; 
            a = [a1,a2,a3];
            [x0,y0,z0] = solve(a,[x0,y0,z0]);
            if length(x0) == 1
                x(p) = x0;
                y(p) = y0;
                z(p) = z0;
                p = p + 1;
            end
            clear x0;
            clear y0;
            clear z0;
          end
       end
    end
end
% disp(x(1));
% disp(y);
% disp(z);

