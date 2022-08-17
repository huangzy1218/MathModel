% 非线性回归
x = 2:16;
y = [6.42 8.20 9.58 9.5 9.7 10 9.93 9.99 10.49 10.59 10.60 10.80 10.60 10.90 10.76];
beta0 = [8 2]';
[beta,r,J] = nlinfit(x',y','volume',beta0);
[Y,delta] = nlpredci('volume',x',beta,r,J);
plot(x,y,'k+',x,Y,'r');