% 准备好训练集

% 人数(单位：万人)
numberOfPeople = [20.55 22.44 25.37 27.13 29.45 30.10 30.96 34.06 36.42 38.09 39.13 39.99 41.93 44.59 47.30 52.89 55.73 56.76 59.17 60.63];
% 机动车数(单位：万辆)
numberOfAutomobile = [0.6 0.75 0.85 0.9 1.05 1.35 1.45 1.6 1.7 1.85 2.15 2.2 2.25 2.35 2.5 2.6 2.7 2.85 2.95 3.1];
% 公路面积(单位：万平方公里)
roadArea = [0.09 0.11 0.11 0.14 0.20 0.23 0.23 0.32 0.32 0.34 0.36 0.36 0.38 0.49 0.56 0.59 0.59 0.67 0.69 0.79];
% 公路客运量(单位：万人)
passengerVolume = [5126 6217 7730 9145 10460 11387 12353 15750 18304 19836 21024 19490 20433 22598 25107 33442 36836 40548 42927 43462];
% 公路货运量(单位：万吨)
freightVolume = [1237 1379 1385 1399 1663 1714 1834 4322 8132 8936 11099 11203 10524 11115 13320 16762 18673 20724 20803 21804];

% 输入数据矩阵
p = [numberOfPeople; numberOfAutomobile; roadArea];
% 目标（输出）数据矩阵
t = [passengerVolume; freightVolume];

% 对训练集中的输入数据矩阵和目标数据矩阵进行归一化处理
[pn,inputStr] = mapminmax(p);
[tn,outputStr] = mapminmax(t);

% 建立一个前馈反向传播（BP）网络
net = newff(pn,tn,[3,7,2],{'purelin', 'logsig', 'purelin'});
% purlin 线性传递，tansig 正切S型函数，losig对数S型函数
% 每10轮回显示一次结果
net.trainParam.show = 10;
% 最大训练次数
net.trainParam.epochs = 5000;
% 网络的学习速率
net.trainParam.lr = 0.05;
% 训练网络所要达到的目标误差
net.trainParam.goal = 0.65 * 10^(-3);
% 网络误差如果连续6次迭代都没变化，则matlab会默认终止训练。为了让程序继续运行，用以下命令取消这条设置
net.divideFcn = '';

% 开始训练网络
net = train(net,pn,tn);

% 使用训练好的网络，基于训练集的数据对BP网络进行仿真得到网络输出结果
% (因为输入样本（训练集）容量较少，否则一般必须用新鲜数据进行仿真测试)
answer = sim(net, pn);

% 反归一化
answer1 = mapminmax('reverse', answer, outputStr);

%绘制测试样本神经网络输出和实际样本输出的对比图(figure(1))
t = 1990:2009;

%测试样本网络输出客运量
a1 = answer1(1,:); 
%测试样本网络输出货运量
a2 = answer1(2,:);

figure(1);
subplot(2, 1, 1); plot(t, a1, 'ro', t, passengerVolume, 'b+');
legend('网络输出客运量', '实际客运量');
xlabel('年份'); ylabel('客运量/万人');
title('神经网络客运量学习与测试对比图');
grid on;

subplot(2, 1, 2); plot(t, a2, 'ro', t, freightVolume, 'b+');
legend('网络输出货运量', '实际货运量');
xlabel('年份'); ylabel('货运量/万吨');
title('神经网络货运量学习与测试对比图');
grid on;

%使用训练好的神经网络对新输入数据进行预测

%新输入数据(2010年和2011年的相关数据)
newInput = [73.39 75.55; 3.9635 4.0975; 0.9880 1.0268]; 

%利用原始输入数据(训练集的输入数据)的归一化参数对新输入数据进行归一化
newInput = mapminmax('apply', newInput, inputStr);

% 进行仿真
newOutput = sim(net, newInput);

% 反归一化
newOutput = mapminmax('reverse',newOutput, outputStr);

disp('预测2010和2011年的公路客运量分别为(单位：万人)：');
newOutput(1,:)
disp('预测2010和2011年的公路货运量分别为(单位：万吨)：');
newOutput(2,:)

% 在figure(1)的基础上绘制2010和2011年的预测情况
figure(2);
t1 = 1990:2011;

subplot(2, 1, 1); plot(t1, [a1 newOutput(1,:)], 'ro', t, passengerVolume, 'b+');
legend('网络输出客运量', '实际客运量');
xlabel('年份'); ylabel('客运量/万人');
title('神经网络客运量学习与测试对比图(添加了预测数据)');
grid on;

subplot(2, 1, 2); plot(t1, [a2 newOutput(2,:)], 'ro', t, freightVolume, 'b+');
legend('网络输出货运量', '实际货运量');
xlabel('年份'); ylabel('货运量/万吨');
title('神经网络货运量学习与测试对比图(添加了预测数据)');
grid on;