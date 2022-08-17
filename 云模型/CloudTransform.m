
% 根据原始数据y_spor和需要的云滴个数n
% 返回n个云滴，x代表n个云滴的数据值，y代表n个云滴的确定度
%Ex En He 分布代表原始数据的 期望 熵 超熵
function [x,y,Ex,En,He] = CloudTransform(y_spor,n)
%mean函数作用：求得矩阵的平均值（期望）
Ex=mean(y_spor);
%熵的求法：sum(abs(y_spor-Ex)).*sqrt(pi/2)
En=mean(sqrt(pi/2).*abs(y_spor-Ex));
%超熵的求法：sqrt(S.^2-En.^2) var函数作用：求得矩阵方差S^2
He=sqrt(var(y_spor)-En.^2);
for i=1:n
    %生成以En为期望 以He^2为方差的正态随机数Enn
    %randn(m)生成m行m列的标准正态分布的随机数或矩阵的函数
    Enn=En+randn(1).*He;
    %生成以Ex为期望，以Enn^2为方差的正态随机数x
    x(i)=Ex+randn(1)*Enn;
    %计算隶属度（确定度）
    y(i)=exp(-(x(i)-Ex).^2/(2*Enn.^2));
end
end