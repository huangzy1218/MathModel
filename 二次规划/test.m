h = [4,-4;-4,8];
f = [-6;-3];
A = [1,1;4,1];
b = [3;9];
[x,value] = quadprog(h,f,A,b,[],[],zeros(2,1))
