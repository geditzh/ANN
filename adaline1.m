clc;clear all;
tic
load x1.mat
d = [1 -1 -1 1];
w = [0.01;0.01;0.01;0.01];
eta = 0.1;epsilon = 0.00000001;
epoch = 0;
e_previous = 0;e_current = 0.1;e_temp = 0;
num = size(x);
while abs(e_current-e_previous)>epsilon
    e_previous = e_temp;
    e_temp = 0;
    u = w'*x;   
    for i=1:1:num(2)
         w = w+eta*(d(i)-u(i))*x(:,i);
         e_temp = e_temp+(d(i)-u(i))^2;
    end
    e_temp = e_temp/num(2);
    e_current = e_temp;
    epoch = epoch+1;
    plot(epoch,e_current,'*');hold on;
    if epoch >= 100000
       fprintf('The epoch is out\n');
       break;
    end   
end
epoch
d
y = sign(u)
toc
