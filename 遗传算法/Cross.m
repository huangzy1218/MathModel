function ret = Cross(pcross,lenchrom,chrom,sizepop,bound)

for i = 1:sizepop
    pick = rand(1,2);  % 生成一行两列随机数，即选择两个个体
    while prod(pick) == 0
        pick = rand(1,2);
    end
    index = ceil(pick .* sizepop);  % 选择两个个体进行交叉
    pick = rand;
    while pick == 0
        pick = rand;
    end
    if pick > pcross  % 小于交叉率进行交叉
        continue;
    end
    flag = 0;
    while flag == 0
        pick = rand;
        while pick == 0
            pick = rand;   % 生成随机数以确定交叉位点
        end
        pos = ceil(pick .* sum(lenchrom));  % 随机交叉位点
        pick = rand;
        v1 = chrom(index(1),pos);
        v2 = chrom(index(2),pos);
        % 随机交叉方法
        chrom(index(1),pos) = pick * v2 + (1-pick) * v1;
        chrom(index(2),pos) = pick * v1 + (1-pick) * v2;
        flag1 = Test(lenchrom,bound,chrom(index(1),:));
        flag2 = Test(lenchrom,bound,chrom(index(2),:));
        if flag1 * flag2 == 0
            flag = 0;
        else
            flag = 1;
        end
    end
end
ret = chrom;

        