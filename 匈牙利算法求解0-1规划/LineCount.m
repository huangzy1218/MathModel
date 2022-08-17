function [num,M_min,DelHang,DelLie] = LineCount(M)
[a,~] = size(M);
num = 0;
h = 0;
DelHang = zeros(a,1);
DelLie = zeros(a,1);
for ii = 1:a
    del = ii-h;
    [~,b] = size(find(M(del,:)==0));
    if   b >= 2
        M(del,:)=[];
        h=h+1;
        DelHang(ii)=ii;    %得到被覆盖的行数
        num=num+1;
    end
end
l=0;
for ii=1:a
    del=ii-l;
    [b,~]=size(find(M(:,del)==0));
    if  b >= 1
        M(:,del) = [];
        l = l+1;
        DelLie(ii) = ii;    %得到被覆盖的列数
        num = num+1;
    end
end
M_min = min(min(M));
