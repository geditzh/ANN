clc;clear all;
x = [0.75 0.75;
     0.75 0.25;
     0.25 0.75;
     0.25 0.25]';
d = [1 0 0 1];
%˫���֪����һ������3����Ԫ
%�����Ľڵ�Ϊ1,2���м�����Ľڵ�Ϊ3,4�������Ľڵ�Ϊ5��
%Ȩֵ��ʼ��
w13=0.1;w14=-0.1;w23=0.1;w24=0.1;w35=0.1;w45=-0.1;
b3=-1;b4=-1;b5=-1;
%ѡ��S�ͺ�����Ϊ�����,�������䡣
e_previous = 0;e_current = 0.1;e_temp = 0;
eta = 1;epsilon = 0.000000001;
epoch = 1;
while abs(e_current-e_previous)>epsilon
    e_previous = e_temp;
    if mod(epoch,4)>0
        n=mod(epoch,4);
    else
        n=4;
    end
    %forward
    x1=x(1,n);x2=x(2,n);
    i1=w13*x1+w23*x2+b3;y1=1/(1+exp(-i1));
    i2=w14*x1+w24*x2+b4;y2=1/(1+exp(-i2));
    i3=w35*y1+w45*y2+b5;y3=1/(1+exp(-i3));
    %backward
    delta3=(d(n)-y3)*y3*(1-y3);
    delta2=delta3*w45*y2*(1-y2);
    delta1=delta3*w35*y1*(1-y1);
    
    w35=w35+delta3*y1;
    w45=w45+delta3*y2;
    b5=b5+delta3;
    w13=w13+delta1*x1;
    w23=w23+delta1*x2;
    w14=w14+delta2*x1;
    w24=w24+delta2*x2;
    b3=b3+delta1;
    b4=b4+delta2;
    %�������
    e_temp = 1/2*(d(n)-y3)^2;
    e_current = e_temp
    epoch = epoch+1;
    if epoch >= 100000
       break;
    end
end
%������
epoch
for i=1:4
    x1=x(1,i);x2=x(2,i);
    y1=1/(1+exp(-(w13*x1+w23*x2+b3)));
    y2=1/(1+exp(-(w14*x1+w24*x2+b4)));
    y3=1/(1+exp(-(w35*y1+w45*y2+b5)))
end
%�����ָ�ͼ��A,B
figure(2)
a1=[0.75 0.25];b1=[0.75 0.25];
plot(a1,b1,'o');hold on;
a1=[0.75 0.25];b1=[0.25 0.75];
plot(a1,b1,'*');hold on;
legend('��һ��','�ڶ���');
x=-0.5:0.1:1.5;
y=-w13/w23*x-b3/w23;
plot(x,y);hold on;
x=-0.5:0.1:1.5;
y=-w14/w24*x-b4/w24;
plot(x,y);hold on;

