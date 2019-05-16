N = 1000;
alpha = 0.1;
k_table = 6:2:20;
len = length(k_table);
iteration_time = 400;
result = zeros(len, iteration_time);
ESS = zeros(4, len);

%  pm1
uff = 0.8;
ufn = 0.6;
unn = 0.4;
for i = 1: len
    i
    k = k_table(i);
    result(i, :) = simulate_im_control_script(uff, ufn, unn, N, k, alpha, iteration_time);
    ESS(1, i) = mean(result(i, 200:400));
end

%  pm2
uff = 0.6;
ufn = 0.8;
unn = 0.4;
for i = 1: len
    k
    k = k_table(i);
    result(i, :) = simulate_im_control_script(uff, ufn, unn, N, k, alpha, iteration_time);
    ESS(2, i) = mean(result(i, 200:400));
end

%  pm2
uff = 0.4;
ufn = 0.8;
unn = 0.6;
for i = 1: len
    k
    k = k_table(i);
    result(i, :) = simulate_im_control_script(uff, ufn, unn, N, k, alpha, iteration_time);
    ESS(3, i) = mean(result(i, 200:400));
end

%  pm2
uff = 0.4;
ufn = 0.6;
unn = 0.8;
for i = 1: len
    k
    k = k_table(i);
    result(i, :) = simulate_im_control_script(uff, ufn, unn, N, k, alpha, iteration_time);
    ESS(4, i) = mean(result(i, 200:400));
end

matlab_blue = [0,114,189]/255;
matlab_orange = [217,83,25]/255;
matlab_purple = [126, 47, 142]/255;
matlab_green = [119, 172, 48]/255;
p1 = plot(ESS(1, :),'^--', 'Color', matlab_blue, 'LineWidth', 1.5);
hold on
p2 = plot(ESS(2, :),'*--', 'Color', matlab_orange, 'LineWidth', 1.5);
p3 = plot(ESS(3, :),'d--', 'Color', matlab_purple, 'LineWidth', 1.5);
p4 = plot(ESS(4, :),'o--', 'Color', matlab_green, 'LineWidth', 1.5);
legend1 = legend([p1], 'PM1 仿真稳态值');
ah = axes('position',get(gca,'position'),'visible','off');
legend2 = legend(ah, [p2], 'PM2 仿真稳态值');
ah1 = axes('position',get(gca,'position'),'visible','off');
legend3 = legend(ah1, [p3], 'PM3 仿真稳态值');
ah2 = axes('position',get(gca,'position'),'visible','off');
legend4 = legend(ah2, [p4], 'PM4 仿真稳态值');
set(legend1, 'box', 'off');
set(legend2, 'box', 'off');
set(legend3, 'box', 'off');
set(legend4, 'box', 'off');