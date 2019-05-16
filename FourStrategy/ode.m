k=20;
[t,y]=ode45(@(t,y) odeFunFour(t,y,k),[0,400],[0.1,0.2,0.3,0.4]);
plot(t,y);
%plot(t,y,'-x');
title('ÀíÂÛÇé¿öÍ¼');
xlabel('Time t');
ylabel('²ßÂÔËùÕ¼±ÈÀý');
legend('FaFb','FaNb','NaFb','NaNb');



















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
%     %legend('Êµï¿½ï¿½ï¿½ï¿½ï¿½ï¿½','ï¿½ï¿½Ï½ï¿½ï¿½')
%     %set(gcf,'unit','centimeters','position',[10 5 9 6.67]);
% end