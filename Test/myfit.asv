%y=I1*exp((x-y*Rs)/0.026/n1)+I2*exp((x-y*Rs)/0.026/n2)+(x-y*Rs)/Rsh-I1-I2+IL

%clear;clc 
F=@(p,H)((p(1)+1)*log(H(:,2))-p(1)*log(1-H(:,2))+log(-H(:,2)-p(1)))/(p(1)*(p(1)+1))+p(2)*exp(-p(3)*H(:,1))/p(3)+p(4);
%F=@(p,x)p(1)*exp((x(:,1)-x(:,2)*p(4))/0.026/p(6))+p(2)*exp((x(:,1)-x(:,2)*p(4))/0.026/p(7))+(x(:,1)-x(:,2)*p(4))/p(5)-p(1)-p(2)+p(3)-x(:,2); 

p0=[1 2 3 4];%%因为你这个函数很变态，初值选择不好得不到好结果，这个初值不错 

warning off 

p=nlinfit(H(:,1),H(:,2),F,p0); 

disp('I1、I2、IL、Rs、Rsh、n1、n2分别为：'); 

disp(num2str(p)); 

plot(x(:,1),x(:,2),'ro');hold on;  

ezplot(@(x,y)F(p,[x,y]),[0,312,0,200000]); 

title('曲线拟合');legend('样本点','拟合曲线')