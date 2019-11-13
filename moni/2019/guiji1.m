clc;
clear;
function [t,x,y] = guiji(x0,y0,f,g,h,a)
k = 1;
t(1) = 0;
x(1) = x0;
y(1) = y0;
h = 0.001;
end
while x <= a
    xp = x(k)+h*feval(f,t(k),x(k),y(k));
    yp = y(k)+h*feval(g,t(k),x(k),y(k));
    t(k+1) = k*h;
    xq = x(k)+h*feval(f,t(k+1),xp,yp);
    yq = y(k)+h*feval(g,t(k+1),xp,yp);
    x(k+1) = (xp+xq)/2;
    y(k+1) = (yp+yq)/2;
    k = k+1;
end
t = t(end);
x = x(end);
y = y(end);