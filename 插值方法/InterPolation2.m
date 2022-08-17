% 立方插值更优
x = 1:5;
y = 1:3;
% 3行5列，数组赋值从上到下
z = [82,81,80,82,84;79,63,61,65,81;84,84,82,85,86];
% 绘制网格曲面图
figure(1);
mesh(x,y,z); 
% 插点坐标
xi = 1:0.2:5;
yi = 1:0.2:3;
zi = interp2(x,y,z,xi,yi,'cubic');
figure(2);
mesh(xi,yi,zi);
figure(3);
contour(xi,yi,zi,20,'r');  % 等高线
[i,j] = find(zi == min(min(zi)));
x = xi(j); y = yi(i); zmin = zi(x,y);
[i,j] = find(zi == max(max(zi)));
x = xi(j); y = yi(i); zmax = zi(x,y);
