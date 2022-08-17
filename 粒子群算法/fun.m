function y = fun(x)

y = sum(x.^2);

if (x(1) + x(2) > 2 && x(1) - x(2) > 0.5)
    y = y;
else
    y = y + 10000;
end