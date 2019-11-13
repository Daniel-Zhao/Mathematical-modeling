function guiji(t)
H=120;
Ve=90;
Vw=450;
x(1)=0;y(1)=0;T(1)=0;
for i=1:10e6
    M=(Ve*T(i)-x(i))/(H-y(i));
    x1(i+1)=x(i)+Vw*t/sqrt(1+1/M.^2);
    y1(i+1)=y(i)+Vw*t/sqrt(1+M.^2);
    T(i+1)=i*t;
    x(i+1)=0.5*(x1(i+1)+x(i)+Vw*t/sqrt(1+((H-y1(i+1))/(Ve*T(i+1)-x1(i+1))).^2));
    y(i+1)=0.5*(y1(i+1)+y(i)+Vw*t/sqrt(1+((Ve*T(i+1)-x1(i+1))/(H-y1(i+1))).^2));
    if y(i+1)>=H
        break;
    end
end
[T;x;y]';
L=x(i+1);
T=x(i+1)/Ve;
