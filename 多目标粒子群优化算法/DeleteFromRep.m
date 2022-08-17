function rep = DeleteFromRep(rep,extra,gamma)

    if nargin < 3
        gamma = 1;
    end
    
    for k = 1:extra
        [occ_cell_index,occ_cell_member_count] = GetOccupiedCells(rep);

        p = occ_cell_member_count.^gamma;  % 每个网格的粒子个数×伸缩倍数 
        p = p/sum(p);   % 计算权重

        selected_cell_index = occ_cell_index(RouletteWheelSelection(p));  % 计算网格

        GridIndices = [rep.GridIndex];   % 网格下标

        selected_cell_members = find(GridIndices==selected_cell_index);  % 计算选中网格粒子个数

        n = numel(selected_cell_members);   

        selected_memebr_index = randi([1,n]);  % 生成伪随机数

        j = selected_cell_members(selected_memebr_index);
        
        rep = [rep(1:j-1); rep(j+1:end)];  % 删除j元素
    end
    
end