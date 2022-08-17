function ret = Select(individuals,sizepop)

individuals.fitness = 1;
sumfitness = sum(individuals.fitness);   % 适应度函数值总和
sumf = individuals.fitness ./ sumfitness;  % 每个个体被选择的概率

index = [];  % 选中的个体
% 轮盘赌
 for i = 1:sizepop
     pick = rand;
     while pick == 0
         pick = rand;
     end
     for j = 1:sizepop
         pick = pick - sumf(j);
         if pick < 0 
             index = [index,j];
             break;
         end
     end
 end
 
individuals.chrom = individuals.chrom(index,:);
individuals.fitness = individuals.fitness(index,:);
ret = individuals;