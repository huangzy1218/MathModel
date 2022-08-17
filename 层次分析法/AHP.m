% 层次分析法
A = [1,3,5;0.33,1,3;0.2,0.33,1];
[n,~] = size(A); % 得到矩阵阶数
[V,D] = eig(A); % 求得特征向量(V)和特征值(D),按对角线元素排列
% 求出最大特征值和它所对应的特征向量
tempNum = D(1,1);
pos = 1;
for h = 1:n
    if D(h,h) > tempNum
        tempNum = D(h,h);
        pos = h;   % 储存阶数
    end
end    
w = abs(V(:,pos));  % 寻找对应的特征向量
w = w/sum(w);  % 归一化处理
t = D(pos,pos);  % 最大特征值
disp('准则层特征向量w = ');disp(w);disp('准则层最大特征根t = ');disp(t);
% 一致性检验
CI = (t-n)/(n-1);
RI = [0,0,0.52,0.89,1.12,1.26,1.36,1.41,1.46,1.49,1.52,1.54,1.56,1.58,1.59,1.60,1.61,1.615,1.62,1.63];
CR = CI/RI(n);
if CR < 0.10
    disp('此矩阵的一致性可以接受!');
    disp('CI = ');disp(CI);
    disp('CR = ');disp(CR);
else
    disp('此矩阵的一致性验证失败，请重新进行评分!');
end

disp('请输入方案层各因素对准则层各因素权重的成对比较阵');
for i = 1:n
    X = sprintf('请输入第 %d 个准则层因素的判断矩阵B%d',i,i);
    B(i) = input(X);
end