function Rep = MOPSO(Params,MultiObj)
Np = Params.Np;
Nr = Params.Nr;
maxgen = Params.maxgen;
w = Params.w;
c1 = Params.c1;
c2 = Params.c2;
ngrid = Params.ngrid;
maxv = Params.maxv;
u_mut = Params.u_mut;
fun = MultiObj.fun;
nvar = MultiObj.nvar;
vmin = MultiObj.vmin(:);
vmax = MultiObj.vmax(:);

pos = repmat((vmax - vmin)',Np,1) .*  rand(Np,nvar);  % 位置
vel = zeros(Np,nar);  % 速度
pos_fit = fun(pos);  % 适应度
pbest = POS;   % 个体最优
pbest_fun = pos_fit; 
dominate = CheckDomination(pos_fit);  % 寻找多个最小值
Rep.pos = pos(~dominate,:);  % 支配其他的个体赋给种群
Rep.pos_fit = pos_fit(~dominate,:);
Rep = UpdateGrid(Rep,ngrid);  % 更新网格
maxv = (vmax - vmin) .* maxv ./ 100;
gen = 1;

disp(['Generation #0 -Repository size: ',num2str(size(Rep.pos,1))]);
condition = false;
while ~condition
    h = SelectLeader(Rep);
    vel = w .* vel + c1 * rand(Np,nvar) .* (pbest - pos) ...
        + c2 * rand(Np,nvar) .* (repmat(Rep.pos(h,:),Np,1)-pos);
    pos = pos + vel;
    % 变异
    pos = Mutation(pos,gen,maxgen,Np,vmax,vmin,nvar,u_mut);
    [pos,vel] = CheckBounderies(pos,vel,maxv,vmax,vmin);
    pos_fit = fun(pos);
end
