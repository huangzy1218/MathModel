% 遗传算法参数
maxgen = 100;   % 迭代次数
sizepop = 100;  % 种群规模
pcross = 0.6; % 交叉概率
pmutation = 0.01; % 变异概率
lenchrom = [1,1,1,1,1];  % 变量字串长度，染色体
bound = [250,400;0.5,5;33,200;10,200;0.3,2.1];  % 变量范围

% 个体初始化
individuals = struct('fitness',zeros(1,sizepop),'chrom',[]);  % 个体结构体，含适应度和基因
avgfitness = [];   % 种群平均适应度
bestfitness = [];   % 种群最佳适应度
bestchrom = [];  % 适应度最好染色体
% 初始化种群
for i = 1:sizepop
    individuals.chrom(i,:) = RandomNum(lenchrom,bound);  % 生成随机数
    x = individuals.chrom(i,:);
    individuals.fitness(i) = fun(x);                     %个体适应度
end

% 优化求最小值
[bestfitness,bestindex] = min(individuals.fitness);  % 寻找适应度最强染色体
bestchrom = individuals.chrom(bestindex,:);  % 最好的染色体
avgfitness = sum(individuals.fitness)/sizepop;  % 染色体的平均适应度
% 记录每一代进化中最好的适应度和平均适应度
trace = []; 
%进化开始
for i = 1:maxgen
     % 选择操作
     individuals = Select(individuals,sizepop);   % 选出新种群 
     % 交叉操作
     individuals.chrom = Cross(pcross,lenchrom,individuals.chrom,sizepop,bound);
     % 变异操作
     individuals.chrom = Mutation(pmutation,lenchrom,individuals.chrom,sizepop,[i,maxgen],bound);
     avgfitness = sum(individuals.fitness)/sizepop;
    
    % 计算适应度 
    for j = 1:sizepop
        x = individuals.chrom(j,:);
        individuals.fitness(j) = fun(x);   
    end
    
  % 找到最小和最大适应度的染色体及它们在种群中的位置
    [newbestfitness,newbestindex] = min(individuals.fitness);
    [worestfitness,worestindex] = max(individuals.fitness);
    % 代替上一次进化中最好的染色体
    if bestfitness > newbestfitness
        bestfitness = newbestfitness;
        bestchrom = individuals.chrom(newbestindex,:);
    end
    individuals.chrom(worestindex,:) = bestchrom;
    individuals.fitness(worestindex) = bestfitness;
    
    avgfitness = sum(individuals.fitness)/sizepop;
    trace = [trace;avgfitness;bestfitness];    % 记录每一代进化中最好的适应度和平均适应度
end

%进化结束

% figure
% plot((1:maxgen)',trace(:,1),'r-',(1:maxgen)',trace(:,2),'b--');
% title(['函数值曲线','终止代数 = ',num2str(maxgen)]);
% xlabel('进化代数');
% ylabel('函数值');
% legen('各代平均值','各代最佳值');
% ylim([-5,5]);
X = ['最小值 = ',num2str(bestfitness)];
Y = ['变量值 = ',num2str(x)];
disp(X);
disp(Y);

