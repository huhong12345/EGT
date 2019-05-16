%clc;clear all;
figure(666);
k=8;
[t,y]=ode45(@(t,y) odefun(t,y,k),[0,400],[0.1,0.9]);
plot(t,y(:,1),'-x');
title('Solution with ODE45');
xlabel('Time t');
ylabel('xf');
hold on;

k=12;
[t,y]=ode45(@(t,y) odefun(t,y,k),[0,400],[0.1,0.9]);
plot(t,y(:,1),'-o');
hold on;

k=16;
[t,y]=ode45(@(t,y) odefun(t,y,k),[0,400],[0.1,0.9]);
plot(t,y(:,1),'-.');
hold on;

k=20;
[t,y]=ode45(@(t,y) odefun(t,y,k),[0,400],[0.1,0.9]);
plot(t,y(:,1),'-*');
legend('k=8','k=12','k=16','k=20');
hold on;


