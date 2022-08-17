function pop = DetermineDomination(pop)

    npop = numel(pop);
    
    for i=1:npop
        pop(i).Dominated = false;  % 初始化
        for j = 1:i-1   % 类似冒泡
            if ~pop(j).Dominated  % 若未被支配
                if Dominates(pop(i),pop(j))
                    pop(j).Dominated = true;  % j被i支配
                elseif Dominates(pop(j),pop(i))
                    pop(i).Dominated = true;  % i被j支配
                    break;
                end
            end
        end
    end

end