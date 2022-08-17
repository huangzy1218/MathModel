% 首先进行级数比检验 λ(k) < 0.1
syms a b;  % 建立发展系数和灰作用量
c = [a,b];
% 原始数列 A
A = [174,179,183,189,207,234,220.5,256,270,285];  % 原始数据
start_time = 1995;  % 开始年份
deadline = 2004;  % 截至年份
n = length(A);
predict = 10; % 预测对象数

% 对原始数列 A 做累加得到数列 B
B = cumsum(A);

% 对数列 B 做紧邻均值生成
for i = 2:n
    C(i) = (B(i) + B(i - 1))/2; 
end
C(1) = [];

%构造数据矩阵 
B = [-C;ones(1,n-1)];
Y = A; Y(1) = []; Y = Y';

%使用最小二乘法计算参数发展系数和灰作用量
c = inv(B*B')*B*Y;
c = c';
a = c(1); 
b = c(2);

%预测后续数据
F = []; 
F(1) = A(1);
for i = 2:(n+10)
    F(i) = (A(1)-b/a)/exp(a*(i-1))+ b/a;
end

%对数列 F 累减还原,得到预测出的数据
G = []; G(1) = A(1);
for i = 2:(n+predict)
    G(i) = F(i) - F(i-1); %得到预测出来的数据
end

disp(['预测数据为：',num2str(G)]);

%模型检验

H = G(1:predict);
%计算残差序列，实际值减去预测值
epsilon = A - H;

% 相对残差Q检验
% 计算相对误差序列
delta = abs(epsilon./A);
% 计算相对误差Q
Q = mean(delta);

% 方差比C检验
C = std(epsilon, 1)/std(A, 1);

% 小误差概率P检验
S1 = std(A, 1);
tmp = find(abs(epsilon - mean(epsilon))< 0.6745 * S1);
disp('小误差概率P检验：')
P = length(tmp)/n;

%绘制曲线图

t1 = start_time:deadline;
t2 = start_time:deadline+predict;

plot(t1, A,'ro'); hold on;
plot(t2, G, 'g-');
xlabel('年份'); ylabel('预测值');
legend('实际值','预测值');
title('灰色预测模型');
grid on;

