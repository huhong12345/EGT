k=20;
[t,y]=ode45(@(t,y) odeFunFour(t,y,k),[0,1000],[0.1,0.2,0.3,0.4]);

figure(9999);
plot(t,y);
%plot(t,y,'-x');
title('信息扩散模型理论图');
xlabel('时间轴');
ylabel('策略所占比例');
legend('FaFb','FaNb','NaFb','NaNb');
grid on;
hold on;
plot(result);
% 
function dxdt=odeFunFour(t,x,k)
% U=[0.4,0.48,0.48,0.58;
%     0.48,0.24,0.62,0.32;
%     0.48,0.62,0.24,0.32;
%     0.58,0.32,0.32,0.22];
w=0.0176*(k*(k+3)*(k-2)*(k-2))/((k+1)*(k+1)*(k-1));
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
%     %legend('实锟斤拷锟斤拷锟斤拷','锟斤拷辖锟斤拷')
%     %set(gcf,'unit','centimeters','position',[10 5 9 6.67]);
% end