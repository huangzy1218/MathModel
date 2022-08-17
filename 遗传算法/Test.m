function flag = Test(lenchrom,bound,code)

flag = 1;
[n,~] = size(code);
for i = 1:n  
    % 基因大于上界或小于下界
    if code(i) < bound(i,1) || code(i) > bound(i,2)
        flag = 0;
    end
end