%clc;clear all;
figure(666);
k=8;
[t,y]=ode45(@(t,y) odefun(t,y,k),[0,400],[0.1,0.9]);
plot(t,y(:,1),'-x','MarkerIndices',1:10:length(y(:,1)));
title('不同平均度下理论结果');
xlabel('Time t');
ylabel('转发策略占比大小xf');
hold on;

k=12;
[t,y]=ode45(@(t,y) odefun(t,y,k),[0,400],[0.1,0.9]);
plot(t,y(:,1),'-o','MarkerIndices',1:10:length(y(:,1)));
hold on;

k=16;
[t,y]=ode45(@(t,y) odefun(t,y,k),[0,400],[0.1,0.9]);
plot(t,y(:,1),'-.','MarkerIndices',1:10:length(y(:,1)));
hold on;

k=20;
[t,y]=ode45(@(t,y) odefun(t,y,k),[0,400],[0.1,0.9]);
plot(t,y(:,1),'-*','MarkerIndices',1:10:length(y(:,1)));
legend('k=8','k=12','k=16','k=20');
hold on;


