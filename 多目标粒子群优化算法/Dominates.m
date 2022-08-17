function dom = Dominates(x,y)

    if isstruct(x)
        x = x.Cost;
    end

    if isstruct(y)
        y = y.Cost;
    end
    % x至少一个目标比y好同时x所有目标不比y差
    dom = all(x<=y) && any(x<y);

end