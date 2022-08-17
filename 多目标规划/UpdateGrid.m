function Rep = UpdateGrid(Rep,ngrid)

ndim = size(Rep.pos_fit,2); % 2为维度，即目标函数个数
Rep.hypercube_limits = zeros(ngird+1,ndim);
for dim = 1:ndim
    % 绘制网格，取每个目标函数的最大和最小值
    Rep.hypercube_limits(:,dim) = linspace(min(Rep.pos_fit(:,dim)),max(Rep.pos_fit(:,dim)),ngrid+1)';
end

% 寻找优秀个体(帕雷托前沿上的点)
npar = size(Rep.pos_fit,1);  
Rep.grid_idx = zeros(npar,1);
Rep.grid_subidx = zeros(npar,ndim);  
for n = 1:1:npar
    idnames = [];
    for d = 1:1:ndim
        % 某点大于某条线
        Rep.grid_subidx(n,d) = find(Rep.pos_fit(n,d) <= Rep.hypercube_limits(:,d)',1,'first')-1);
        if Rep.grid_subidx(n,d) == 0
            Rep.grid_subidx(n,d) = 1;
        end
        idnames = [idnames,',',num2str(Rep.grid_subidx(n,d))];
    end
    Rep.quality = zeros(ngrid,2);  % 网格质量
    ids = unique(Rep,grid_idx);  % 质量与个体数成反比，被选中概率越低
    for i = 1:length(ids)
        Rep.quality(i,1) = ids(i);
        Rep.quality(i,2) = 10 / sum(Rep.grid_idx == ids(i));
    end
end
