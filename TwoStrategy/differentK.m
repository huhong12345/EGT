%clc;clear all;
figure(666);
k=8;
<<<<<<< HEAD
[t,y1]=ode45(@(t,y) odefun(t,y,k),[0,400],[0.1,0.9]);
plot(t,y1(:,1),'-x','MarkerIndices',1:10:length(y1(:,1)));
=======
[t,y]=ode45(@(t,y) odefun(t,y,k),[0,400],[0.1,0.9]);
plot(t,y(:,1),'-x','MarkerIndices',1:10:length(y(:,1)));
>>>>>>> a4f838c6f17c3c68225991a6f4c2986e68d0b50a
title('不同平均度下理论结果');
xlabel('Time t');
ylabel('转发策略占比大小xf');
hold on;

k=12;
<<<<<<< HEAD
[t,y2]=ode45(@(t,y) odefun(t,y,k),[0,400],[0.1,0.9]);
plot(t,y2(:,1),'-o','MarkerIndices',1:10:length(y2(:,1)));
hold on;

k=16;
[t,y3]=ode45(@(t,y) odefun(t,y,k),[0,400],[0.1,0.9]);
plot(t,y3(:,1),'-.','MarkerIndices',1:10:length(y3(:,1)));
hold on;

k=20;
[t,y4]=ode45(@(t,y) odefun(t,y,k),[0,400],[0.1,0.9]);
plot(t,y4(:,1),'-*','MarkerIndices',1:10:length(y4(:,1)));
=======
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
>>>>>>> a4f838c6f17c3c68225991a6f4c2986e68d0b50a
legend('k=8','k=12','k=16','k=20');
hold on;


