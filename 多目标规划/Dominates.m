function d = Dominates(x,y)
% x至少一个目标比y好同时x所有目标不比y差
d = all(x <= y,2) & any(x < y,2);
