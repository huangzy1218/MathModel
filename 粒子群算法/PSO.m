% 更新函数
% 求解最小值，最大值在原函数前加-
c1 = 1.49445;
c2 = 1.49445;
w = 1;

maxgen = 200;  % 最大运行代数
sizepop = 50;  % 种群数量
nvar = 2;  % 参数个数
vmax = 5;  % 速度最大值
vmin = -5; % 速度最小值
popmax = 100;  % 搜索范围最大值
popmin = -100;  % 搜索范围最小值

for i = 1:sizepop
    pop(i,:) = (popmax - popmin) * rand(1,nvar) + popmin;
    v(i,:) = (vmax - vmin) * rand(1,nvar) + vmin;
    fitness(i) = fun(pop(i,:));    % 越小适应度越好
end

[bestfitness,bestindex] = max(fitness);
gbest = pop(bestindex,:);  % 全局最优
pbest = pop;  % 个体最优
fitnesspbest = fitness;  % 个体最优解
fitnessgbest = bestfitness;  % 全局最优解

for i = 1:maxgen
    for j = 1:sizepop
        % 速度更新函数
        v(j,:) = w .* v(j,:) + c1 * rand * (pbest(j,:) - pop(j,:)) + c2 * rand * (gbest - pop(j,:));
        v(j,find(v(j,:) > vmax)) = vmax;   % 限定速度，若大于最大速度，为最大速度
        v(j,find(v(j,:) < vmin)) = vmin;   % 限定速度，若小于最小速度，为最小速度
        
        pop(j,:) = pop(j,:) + v(j,:);
        pop(j,find(pop(j,:) > popmax)) = popmax;
        pop(j,find(pop(j,:) < popmin)) = popmin;
        
        fitness(j) = fun(pop(j,:));
    end
    
    for j = 1:sizepop
        if fitness(j) < fitnesspbest(j)
            pbest(j,:) = pop(j,:);
            fitnesspbest(j) = fitness(j);
        end
        if fitness(j) < fitnessgbest
            gbest = pop(j,:);
            fitnessgbest = fitness(j);
        end
    end
    yy(i) = fitnessgbest;
end

X = ['函数值 = ',num2str(fitnessgbest)];
Y = ['变量 = ',num2str(gbest)];
disp(X);
disp(Y);
    