[x,y] = fmincon('fun1',rand(3,1),[],[],[],[],zeros(3,1),[],'fun2');
% rand(n,1):n个未知量