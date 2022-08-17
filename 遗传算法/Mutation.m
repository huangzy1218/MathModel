function ret = Mutation(pmutation,lenchrom,chrom,sizepop,pop,bound)

for i = 1:sizepop
    pick = rand;
    while pick == 0
        pick = rand;
    end
    index = ceil(pick * sizepop);  % 选中的个体
    pick = rand;
    if pick > pmutation  % 小于变异率
        continue;
    end
    flag = 0;
    while flag == 0
        pick = rand;
        while pick == 0
            pick = rand;
        end
        pos = ceil(pick * sum(lenchrom));  % 选择突变位点
        % 变异操作方法
        v = chrom(i,pos);
        v1 = v - bound(pos,1);
        v2 = bound(pos,2) - v;
        pick = rand;
        if pick > 0.5
            delta = v2 * (1-pick ^ ((1-pop(1) / pop(2)) ^  2));
            chrom(i,pos) = v + delta;
        else
            delta = v1 * (1-pick ^ ((1-pop(1) / pop(2)) ^  2));
            chrom(i,pos) = v - delta;
        end
        flag = Test(lenchrom,bound,chrom(i,:));
    end
end
ret = chrom;