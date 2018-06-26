clc;clear all;
tic
x = [-1 0.1 0.4 0.7;
     -1 0.3 0.7 0.2;
     -1 0.6 0.9 0.8;
     -1 0.5 0.7 0.1]';
% load x1.mat
d = [1 -1 -1 1];
w = [0.1;0.1;0.1;0.1];
eta = 0.1;
epoch = 0;
error = 0;
num = size(x);
while error==0
    u = w'*x;
    y = sign(u);
    if ~isequal(y,d)
        for i=1:1:num(2)
             w = w+eta*(d(i)-y(i))*x(:,i);
             epoch = epoch+1;
        end
    else
        error = 1;
    end   
   if epoch >= 100000
       fprintf('The epoch is out\n');
       error = 1;
       break;
   end
end
epoch
d
y = sign(w'*x)
toc
