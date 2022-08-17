function dom_vector = CheckDomination(fitness)

Np = size(fitness,1);
dom_vector = zeros(Np,1);  % 被支配为1，否则为0
all_perm = nchoosek(1:Np,2);  % 选中两个进行全排列(前小后大)
all_perm = [all_perm;[all_perm(:,2),all_perm(:,1)]];  % 选中两个进行全排列(前大后小)

d = Domination(fitness(all_perm(:,1),:),fitness(all_perm(:,2),:));
dominated_particles = unique(all_perm(d==1,2));  % 取消重复
dom_vector(dominated_particles) = 1;   % 优秀个体设为1

