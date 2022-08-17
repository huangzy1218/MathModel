function ret = RandomNum(lenchrom,bound)

flag = 0;  %  检测选取是否合适
while flag == 0
    pick = rand(1,length(lenchrom));
    ret = bound(:,1)' + (bound(:,2) - bound(:,1))' .*  pick;  % 生成指定范围随机数
    flag = Test(lenchrom,bound,ret); 
end