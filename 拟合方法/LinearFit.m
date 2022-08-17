x = 1:12;
y = [5,8,9,15,25,29,31,30,22,25,27,24];
a = polyfit(x,y,9);
xp = 1:0.1:12;
yp = polyval(a,xp);
plot(x,y,'.k',xp,yp,'r');