clc;clear;
%����ѵ������
load('x.mat');

%ѵ��������Լ��ĸ���
num_all_data = length(x);

% ǰ80%��������Ϊѵ�����ݣ���20%��Ϊ��������
num_train = floor(num_all_data*0.8);
num_test = num_all_data - num_train;

% ת��ΪTDNN��Ҫ����������
x_train = num2cell(x(1:num_train));
x_test = num2cell(x(1+num_train:end));
y_train = x_train;
y_test = x_test;

% �����ӳ٣�����ǰֵ�����ڹ�ȥ�Ķ��ٸ�ֵ
feedback_delays_1 = 1:5;
feedback_delays_2 = 1:10;
feedback_delays_3 = 1:15;

% ������ڵ�ĸ���
num_hd_neuron_1 = 10;
num_hd_neuron_2 = 15;
num_hd_neuron_3 = 25;

%����TDNN-1����
net1 = timedelaynet(feedback_delays_1, num_hd_neuron_1);
[Xs,Xi,Ai,Ts] = preparets(net1,x_train,y_train,{});
net1 = train(net1,Xs,Ts,Xi,Ai);
Y = net1(x_test,Xi,Ai);
TDNN1_perf = perform(net1,y_test,Y);
fprintf( 'TDNN-1(perform): mse on training set : %.6f\n', TDNN1_perf);
view(net1)

%����TDNN-2����
net2 = timedelaynet(feedback_delays_2, num_hd_neuron_2);
[Xs,Xi,Ai,Ts] = preparets(net2,x_train,y_train,{});
net2 = train(net2,Xs,Ts,Xi,Ai);
Y = net2(x_test,Xi,Ai);
TDNN2_perf = perform(net2,y_test,Y);
fprintf( 'TDNN-2(perform): mse on training set : %.6f\n', TDNN2_perf);
view(net2)

%����TDNN-3����
net3 = timedelaynet(feedback_delays_3, num_hd_neuron_3);
[Xs,Xi,Ai,Ts] = preparets(net3,x_train,y_train,{});
net3 = train(net3,Xs,Ts,Xi,Ai);
Y = net3(x_test,Xi,Ai);
TDNN3_perf = perform(net3,y_test,Y);
fprintf( 'TDNN-3(perform): mse on training set : %.6f\n', TDNN3_perf);
view(net3)