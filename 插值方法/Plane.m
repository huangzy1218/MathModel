% 经对比，三次样条插值最优
function Plane
x0 = [0,3,5,7,9,11,12,13,14,15];
y0 = [0,1.2,1.7,2.0,2.1,2.0,1.8,1.2,1.0,1.6];
x = 0:0.1:15;
y1 = Lagrange(x0,y0,x);  % 拉格朗日插值,Runge现象明显
y2 = interp1(x0,y0,x);  % 线性插值
y3 = interp1(x0,y0,x,'spline');  % 三次样条插值
subplot(3,1,1);
plot(x0,y0,'k+',x,y1,'r');
grid;
title('Lagrange');
subplot(3,1,2);
plot(x0,y0,'k+',x,y2,'r');
grid;
title('Piecewise Linear');
subplot(3,1,3);
plot(x0,y0,'k+',x,y3,'r');
grid;
title('Spline');
