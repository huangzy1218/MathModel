M = [4.69 6.59 51 11.94;
    2.03 7.86 19 6.46;
    9.11 6.31 46 8.91;
    8.61 7.05 46 26.43;
    7.13 6.5 50 23.57;
    2.39 6.77 38 24.62;
    7.69 6.79 38 6.01;
    9.3 6.81 27 31.57;
    5.45 7.62 5 18.46;
    6.19 7.27 17 7.51;
    7.93 7.53 9 6.52;
    4.4 7.28 17 25.3;
    7.46 8.24 23 14.42;
    2.01 5.55 47 26.31;
    2.04 6.4 23 17.91;
    7.73 6.14 52 15.72;
    6.35 7.58 25 29.46;
    8.29 8.41 39 12.02;
    3.54 7.27 54 3.16;
    7.44 6.26 8 28.41];% 输入数据
[n,m] = size(A);
type = [1,3,2,4]; % 指标类型矩阵，1表示极大型指标，2表示极小型指标，3表示中间型指标，4表示区间型矩阵
for j = 1:m
    if type(j) == 1
        Max = -99999.9999;
        Min = 99999.9999;
        for i = 1:20
            Max = max(Max,M(i,j));
            Min = min(Min,M(i,j));
        end
        for i = 1:n
            M(i,j) = (M(i,j)-Min)/(Max-Min);
        end
    elseif type(j) == 2
        Max = -99999.9999;
        Min = 99999.9999;
        for i = 1:n
            Max = max(Max,M(i,j));
            Min = min(Min,M(i,j));
        end
        for i = 1:n
            M(i,j) = (Max-M(i,j))/(Max-Min);
        end
    elseif type(j) == 3
        Max = -99999.9999;
        for i = 1:n
            Max = max(Max,abs(M(i,j)-7));
        end
        for i = 1:n
            M(i,j) = 1-abs(M(i,j)-7)/Max;
        end
    elseif type(j) == 4
        Max = -99999.9999;
        Min = 99999.9999;
        down = 10;  % 最优区间
        up = 20;
        for i = 1:n
            Max = max(Max,M(i,j));
            Min = min(Min,M(i,j));
        end
        T = max(down - Min,Max - up);
        for i = 1:n
            if M(i,j)<10
                M(i,j) = 1-(down-M(i,j))/T;
            elseif M(i,j)>20
                M(i,j) = 1-(M(i,j)-up)/T;
            else
                M(i,j) = 1;
            end
        end
    end
end
% 以上是讨论四种类型指标，分别进行正向化
A = zeros(n,m);
for j = 1:4
    sum = 0;
    for i = 1:n
        sum = sum+M(i,j)^2;
    end
    sum = sqrt(sum);
    for i=1:20
        A(i,j)=M(i,j)/sum;
    end
end
% 以上是将正向化处理得到的矩阵进行标准化，加权矩阵
C=[1 1 7 5;
   1 1 7 5;
   1/7 1/7 1 1/3;
   1/5 1/5 3 1];
[Omega,Lambda] = eig(C);
mx = -99999.99999;
id = 0;
for i = 1:m
    if Lambda(i,i)>mx
        mx = Lambda(i,i);
        id = i;
    end
end
W = zeros(4,1);
sum = 0;
for i = 1:m
    sum = sum+Omega(i,id);
end
for i = 1:m
    W(i,1) = Omega(i,id)/sum;
end
%以上是求得权重向量W
R = zeros(n,m);
for j = 1:m
    for i = 1:n
        R(i,j) = W(j,1)*A(i,j);
    end
end
% 求得加权决策矩阵R
Z_plus = [-99999.9999 -99999.9999 -99999.9999 -99999.9999];
Z_minus = [99999.9999 99999.9999 99999.9999 99999.9999 99999.9999];
for j = 1:m
    for i = 1:n
        Z_plus(j) = max(Z_plus(j),R(i,j));
        Z_minus(j) = min(Z_minus(j),R(i,j));
    end
end
% 求得每个参数对应的最大最小值、
d_plus = zeros(20,1);
d_minus = zeros(20,1);
for i = 1:n
    for j = 1:m
        d_plus(i) = d_plus(i)+(Z_plus(j)-R(i,j))^2;
        d_minus(i) = d_minus(i)+(Z_minus(j)-R(i,j))^2;
    end
    d_plus(i) = sqrt(d_plus(i));
    d_minus(i) = sqrt(d_minus(i));
end
% 计算每个方案距离最优最劣解的距离
v = zeros(n,2);
for i = 1:n
    v(i,1) = d_minus(i)/(d_plus(i)+d_minus(i));
    v(i,2) = i;
end
% 计算每个方案的优劣值
for i = 1:n
    MaxId = i;
    for j = i+1:20
        if v(j,1)>v(MaxId,1)
            MaxId = j;
        end
    end
    temp = v(i,1);
    v(i,1) = v(MaxId,1);
    v(MaxId,1) = temp;
    temp = v(i,2);
    v(i,2) = v(MaxId,2);
    v(MaxId,2) = temp;
end
% 进行优劣值排序
% v的第二列即为排序结果
