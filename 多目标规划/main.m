% MultiObj.fun = @(x) [-10*exp(-0.2.*sqrt(x(:,1).^2+x(:,2))+ exp(-0.2.*sqrt(x(:,2).^2+x(:,3).^2))) ...
%     sum(abs(x).^0.8 + 5.*sin(x.^3),2)];  % 句柄形式
MultiObj.nvar = 3;  % 变量个数
MultiObj.vmin = -5 .* ones(1,MultiObj.nvar);  % 变量最小值
MultiObj.vmax = 5 .* ones(1,MultiObj.nvar);   % 变量最大值

Params.Np = 2 00;  % 种群个数
Params.Nr = 150;  % 帕利托前沿显示种群数
Params.maxgen = 100;  % 迭代次数
Params.w = 0.4;
Params.c1 = 2;
Params.c2 = 2;
Params.ngrid = 20;   % 网格个数，计算拥挤距离
Params.maxv = 5;   % 最大速度
Params.u_mut = 0.5;  % 变异率

REP = MOPSO(Params,MultiObj);

