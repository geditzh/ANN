clc; clear all;
%初始化数据
x = [-1 0.75 0.75;
     -1 0.75 0.25;
     -1 0.25 0.75;
     -1 0.25 0.25;]';
d = [0.2 0.8 0.8 0.2];

%初始化参数
w1 = [10.8857    7.2190
      2.4844    8.5641
      2.9204   11.4759];
w2 = [-10.8464
      7.0810];
% w1 = random('norm',0.1,0.02,3,2);w2 = random('norm',0.1,0.02,2,1);

%初始化学习率，停止误差
eta = 1;epsilon = 0.000000000001;
epoch = 1;
e_previous = 0;e_current = 0.1;e_temp = 0;
num = size(x);
while abs(e_current-e_previous)>epsilon
    if mod(epoch,4)>0
        n=mod(epoch,4);
    else
        n=4;
    end
    e_previous = e_temp;
    %正向传播
    i1 = w1(:,1)'*x(:,n);y1 = 1/(1+exp(-i1));
    i2 = w1(:,2)'*x(:,n);y2 = 1/(1+exp(-i2));
    i3 = w2(1)*y1+w2(2)*y2;y3 = 1/(1+exp(-i3));    
    %反向传播
    delta3 = (d(n)-y3)*y3*(1-y3);
    w2(2) = w2(2)+eta*delta3*y2;
    w2(1) = w2(1)+eta*delta3*y1; 
    
    delta2 = delta3*w2(2)*y2*(1-y2);
    w1(1,2) = w1(1,2)+eta*delta2*x(1,n);
    w1(2,2) = w1(2,2)+eta*delta2*x(2,n);
    w1(3,2) = w1(3,2)+eta*delta2*x(3,n);
    
    delta1 = delta3*w2(1)*y1*(1-y1);
    w1(1,1) = w1(1,1)+eta*delta1*x(1,n);
    w1(2,1) = w1(2,1)+eta*delta1*x(2,n);
    w1(3,1) = w1(3,1)+eta*delta1*x(3,n);

    e_temp = 1/2*(d(n)-y3)^2;
    e_current = e_temp;
    %plot(epoch,e_current);hold on;
    epoch = epoch+1;
    if epoch >= 100000
       break;
    end
end
y = zeros(4,1);
for n=1:4
    i1 = w1(:,1)'*x(:,n);y1 = 1/(1+exp(-i1));
    i2 = w1(:,2)'*x(:,n);y2 = 1/(1+exp(-i2));
    i3 = w2(1)*y1+w2(2)*y2;y3 = 1/(1+exp(-i3));
    y(n) = y3;
end
epoch
y'
d

%画出图像
figure(2)
a1=[0.75 0.25];b1=[0.75 0.25];
plot(a1,b1,'o');hold on;
a1=[0.75 0.25];b1=[0.25 0.75];
plot(a1,b1,'*');hold on;
legend('第一类','第二类');
x = -0.5:0.1:1.5;
y1 = -w1(2,1)*x/w1(3,1)+w1(1,1)/w1(3,1);
plot(x,y1);hold on;
y2 = -w1(2,2)*x/w1(3,2)+w1(1,2)/w1(3,2);
plot(x,y2);