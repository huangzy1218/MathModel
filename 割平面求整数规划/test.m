A = [0.01,0.01,0.01,0.03,0.03,0.03,1,0,0,0;0.02,0,0,0.05,0,0,0,1,0,0; ...
    0,0.02,0,0,0.05,0,0,0,1,0;0,0,0.03,0,0,0.08,0,0,0,1];
c = [-20;-14;-16;-36;-32;-30];
b = [850;700;100;900];
[intx,intf] = DividePlane(A,c,b,[7 8 9 10]);  % 7 8 9 10指松弛变量的下标
    