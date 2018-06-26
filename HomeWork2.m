clc;clear;
%加载训练数据
load('x.mat');

%训练集与测试集的个数
num_all_data = length(x);

% 前80%的数据作为训练数据，后20%作为测试数据
num_train = floor(num_all_data*0.8);
num_test = num_all_data - num_train;

% 转化为TDNN需要的序列数据
x_train = num2cell(x(1:num_train));
x_test = num2cell(x(1+num_train:end));
y_train = x_train;
y_test = x_test;

% 设置延迟，即当前值依赖于过去的多少个值
feedback_delays_1 = 1:5;
feedback_delays_2 = 1:10;
feedback_delays_3 = 1:15;

% 隐含层节点的个数
num_hd_neuron_1 = 10;
num_hd_neuron_2 = 15;
num_hd_neuron_3 = 25;

%构件TDNN-1网络
net1 = timedelaynet(feedback_delays_1, num_hd_neuron_1);
[Xs,Xi,Ai,Ts] = preparets(net1,x_train,y_train,{});
net1 = train(net1,Xs,Ts,Xi,Ai);
Y = net1(x_test,Xi,Ai);
TDNN1_perf = perform(net1,y_test,Y);
fprintf( 'TDNN-1(perform): mse on training set : %.6f\n', TDNN1_perf);
view(net1)

%构件TDNN-2网络
net2 = timedelaynet(feedback_delays_2, num_hd_neuron_2);
[Xs,Xi,Ai,Ts] = preparets(net2,x_train,y_train,{});
net2 = train(net2,Xs,Ts,Xi,Ai);
Y = net2(x_test,Xi,Ai);
TDNN2_perf = perform(net2,y_test,Y);
fprintf( 'TDNN-2(perform): mse on training set : %.6f\n', TDNN2_perf);
view(net2)

%构件TDNN-3网络
net3 = timedelaynet(feedback_delays_3, num_hd_neuron_3);
[Xs,Xi,Ai,Ts] = preparets(net3,x_train,y_train,{});
net3 = train(net3,Xs,Ts,Xi,Ai);
Y = net3(x_test,Xi,Ai);
TDNN3_perf = perform(net3,y_test,Y);
fprintf( 'TDNN-3(perform): mse on training set : %.6f\n', TDNN3_perf);
view(net3)