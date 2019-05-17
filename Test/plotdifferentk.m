matlab_blue = [0,114,189]/255;
matlab_orange = [217,83,25]/255;
matlab_purple = [126, 47, 142]/255;
matlab_green = [119, 172, 48]/255;
p1 = plot(ESS(1, :),'^--', 'Color', matlab_blue, 'LineWidth', 1.5);
hold on
p2 = plot(ESS(2, :),'*--', 'Color', matlab_orange, 'LineWidth', 1.5);
p3 = plot(ESS(3, :),'d--', 'Color', matlab_purple, 'LineWidth', 1.5);
p4 = plot(ESS(4, :),'o--', 'Color', matlab_green, 'LineWidth', 1.5);
% legend1 = legend([p1], 'Case1 仿真稳态值');
% ah = axes('position',get(gca,'position'),'visible','off');
% legend2 = legend(ah, [p2], 'Case2 仿真稳态值');
% ah1 = axes('position',get(gca,'position'),'visible','off');
% legend3 = legend(ah1, [p3], 'Case3 仿真稳态值');
% ah2 = axes('position',get(gca,'position'),'visible','off');
% legend4 = legend(ah2, [p4], 'Case4 仿真稳态值');
title('ER随机网，IM更新规则，ESS稳定状态仿真值与理论值对比图');
xlabel('平均度数');
ylabel('ESS稳定状态下转发策略所占比例');
set(gca,'XTick',1:9);
set(gca,'XTickLabel',{'6','8','10','12','14','16','18','20'})
%axis(6,20,0,1);
legend('Case1 仿真稳态值','Case2 仿真稳态值','Case3 仿真稳态值','Case4 仿真稳态值');


% set(legend1, 'box', 'off');
% set(legend2, 'box', 'off');
% set(legend3, 'box', 'off');
% set(legend4, 'box', 'off');