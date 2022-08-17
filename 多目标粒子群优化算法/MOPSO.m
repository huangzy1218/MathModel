CostFunction = @(x) MyCost(x);
nVar = 3;  % 变量个数
VarMin = -4;  % 变量最大值
VarMax = 4;   % 变量最小值

VarSize = [1,nVar];

VelMax = (VarMax-VarMin)/10;  % 速度最大值

% MOPSO设置

nPop = 100;   % 种群大小

nRep = 100;   % 仓库规模
MaxIt = 100;  % 最大迭代次数
phi1 = 2.05;
phi2 = 2.05;
phi = phi1 + phi2;
chi = 2 / (phi-2+sqrt(phi^2-4*phi));

% 粒子群算法相关参数
w = chi;              
wdamp = 1;           
c1 = chi*phi1;        
c2 = chi*phi2;        

alpha = 0.1;  % 网格膨胀参数

nGrid = 10;   % 每一维度的网格数

beta=4;     % 支配参数
gamma = 2;    % 删除仓库参数

% 初始化
particle = CreateEmptyParticle(nPop);

for i = 1:nPop
    particle(i).Velocity = 0;   % 初始化粒子运动速度
    particle(i).Position = unifrnd(VarMin,VarMax,VarSize);  % 生成随机分布的值
    particle(i).Cost = CostFunction(particle(i).Position);  % 粒子开销
    particle(i).Best.Position = particle(i).Position;  % 个体最优位置
    particle(i).Best.Cost = particle(i).Cost;  % 个体最优解
end

particle = DetermineDomination(particle);  % 确定支配关系
rep = GetNonDominatedParticles(particle);  % 存放未被支配的个体

rep_costs = GetCosts(rep);  % 计算未被支配粒子(精英粒子)的开销
G = CreateHypercubes(rep_costs,nGrid,alpha);  % 创建超立方

for i = 1:numel(rep)  % 返回仓库中的元素个数
    [rep(i).GridIndex,rep(i).GridSubIndex] = GetGridIndex(rep(i),G);  % 设置所在网格数
end
    
% 主循环
for it = 1:MaxIt
    for i = 1:nPop
        rep_h = SelectLeader(rep,beta);  % 选择优秀个体
        % 粒子群算法
        particle(i).Velocity  = w*particle(i).Velocity ...
                             + c1*rand*(particle(i).Best.Position - particle(i).Position) ...
                             + c2*rand*(rep_h.Position -  particle(i).Position);
        % 随机生成粒子运动速度
        particle(i).Velocity = min(max(particle(i).Velocity,-VelMax),+VelMax);
        % 粒子运动速度
        particle(i).Position = particle(i).Position + particle(i).Velocity;
        flag = (particle(i).Position < VarMin | particle(i).Position > VarMax);  % 判断该位置是否合法
        particle(i).Velocity(flag) = -particle(i).Velocity(flag);
        particle(i).Position = min(max(particle(i).Position,VarMin),VarMax);
        particle(i).Cost = CostFunction(particle(i).Position);
        
        if Dominates(particle(i),particle(i).Best)  % 如果个体最优
            particle(i).Best.Position = particle(i).Position;
            particle(i).Best.Cost=particle(i).Cost;
            
        elseif ~Dominates(particle(i).Best,particle(i))  % 若被支配
            if rand < 0.5
                particle(i).Best.Position = particle(i).Position;
                particle(i).Best.Cost = particle(i).Cost;
            end
        end

    end

    particle = DetermineDomination(particle);   % 支配个体
    nd_particle = GetNonDominatedParticles(particle);   % 优秀个体
    
    rep = [rep;nd_particle];
    
    % 再一次支配选择
    rep = DetermineDomination(rep);  
    rep = GetNonDominatedParticles(rep);
    
    for i = 1:numel(rep)
        [rep(i).GridIndex,rep(i).GridSubIndex] = GetGridIndex(rep(i),G);
    end
    
    if numel(rep) > nRep   % 超出精英库容量
        extra = numel(rep) - nRep;
        rep = DeleteFromRep(rep,extra,gamma);  % 删除多余数据
        
        rep_costs = GetCosts(rep);   % 单独列出开销（个体最优），便于后续可视化
        G = CreateHypercubes(rep_costs,nGrid,alpha);
    end
   
%   disp(['Iteration ' num2str(it) ': Number of Repository Particles = ' num2str(numel(rep))]);
    % 惯性量随迭代次数而减少
    w = w * wdamp;
end

% 运算结果
costs = GetCosts(particle);
rep_costs = GetCosts(rep);

figure;

plot(costs(1,:),costs(2,:),'b.');
hold on;
plot(rep_costs(1,:),rep_costs(2,:),'rx');
legend('Main Population','Repository');
