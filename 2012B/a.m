lux_x = xlsread('a.xlsx','P4:P8763');
lux_y = xlsread('a.xlsx','Q4:Q8763');
lux_z = xlsread('a.xlsx','R4:R8763');
L_d = zeros(1000000,1);
i = 1;
for a1 = 0 : 0.01*pi : pi
    for a2 = 0 : 0.01*pi : pi
        for a3 = 0 : 0.01*pi : pi
            l_d = lux_x * sin(a1) + lux_y * sin(a2) + lux_z * sin(a3);
            L_d(i) = l_d;
            i = i + 1;
        end
    end
end