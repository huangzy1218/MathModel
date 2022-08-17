function selected = SelectLeader(Rep)
% 类似轮盘赌算法
prob = cunsum(Rep.quality(:,2));
sel_hyp = Rep.quality(find(rand(1,1) * max(prob) <= prob,1,'first'),1);
idx = 1:1:length(Rep.grid_idx);
selected = idx(Rep.grid_idx == sel_hyp);
selected = Selected(randi(length(selected)));
