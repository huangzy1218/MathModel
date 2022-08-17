% 数据导出
a = xlsread('\附件1 近5年402家供应商的相关数据.xlsx',1,'A2:IH403');
b = xlsread('\附件1 近5年402家供应商的相关数据.xlsx',2,'A2:IH403');

[~,n1] = xlsread('\附件1 近5年402家供应商的相关数据.xlsx',1,'A1:A403');
% 数据导入
a2 = a*2;
b2 = b*2;
xlswrite('\新建 XLSX 工作表.xlsx',a2,'sheet1');


