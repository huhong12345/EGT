k=20;
[t,y]=ode45(@(t,y) odeFunFour(t,y,k),[0,400],[0.1,0.2,0.3,0.4]);
plot(t,y);
%plot(t,y,'-x');
title('��Ϣ��ɢģ������ͼ');
xlabel('ʱ����');
ylabel('������ռ����');
legend('FaFb','FaNb','NaFb','NaNb');
grid on;

function dxdt=odeFunFour(t,x,k)
Ua=[0.6,0.8;0.8,0.4];
Ub=[0.6,0.8;0.8,0.4];
U=[Ua(1,1)*Ub,Ua(1,2)*Ub;Ua(2,1)*Ub,Ua(2,2)*Ub];
U=[0.26,0.48,0.48,0.64;
    0.48,0.24,0.64,0.42;
    0.48,0.64,0.24,0.42;
    0.64,0.42,0.42,0.36];
%x=zeros(4,1);
%x(1)=xx(1);x(2)=xx(2);x(3)=xx(3);x(4)=1-xx(1)-xx(2)-xx(3);
w=0.05*(k*(k+3)*(k-2)*(k-2))/((k+1)*(k+1)*(k-1));
f=U*x;
fi=x'*f;
b=zeros(4,4);
for i=1:4
    for j= 1:4
        b(i,j)=((k+3)*U(i,i)+3*U(i,j)-3*U(j,i)-(k+3)*U(j,j))/((k+3)*(k-2));
    end
end
    g=b*x;
    dxdt=w*[x(1)*(f(1)+g(1)-fi),x(2)*(f(2)+g(2)-fi),x(3)*(f(3)+g(3)-fi),x(4)*(f(4)+g(4)-fi)]';
    qqqqqq=1;
end


















%     function y = sir(t,x)
%         y = [-beta*x(1)*x(2), beta*x(1)*x(2)-gamma*x(2),  gamma*x(2)]';        
%     end
% 
%     beta = parameter(1);
%     gamma = parameter(2);
%     N = parameter(3);
%     series_one = series/N;
% %     m = max(series_one);
%     [t,x] = ode45(@sir, [0:127], [0.99999, 0.00001, 0]);
%     %I = x(:,2).';
%     plot(t, series_one,'LineWidth',1.5);
%     hold on
%     %plot(t,I,'LineWidth',1.5);
%     %legend('ʵ������','��Ͻ��')
%     %set(gcf,'unit','centimeters','position',[10 5 9 6.67]);
% end