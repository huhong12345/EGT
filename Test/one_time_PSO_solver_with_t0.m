function para = one_time_PSO_solver_with_t0(times)
series = times;
% series(1:3)=[0,0,0];
%粒子群的大小
node_size = 40;
%设置最大迭代次数
Gk = 101;
%设置位置的上下界以及速度的边界
%beta1,beta2,gamma1,gamma2,alpha1,alpha2,delta1,delta2
vmax = [0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1];
vmin = -vmax;
xmax = [1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;30];
xmin = [0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;5];
% vmax = [1;1];
% vmin = -vmax;
% xmax = [20;20];
% xmin = [0.00;0.000];
%初始化加速度参数c1,c2
c1 = 2;
c2 = 2;
%初始化惯性参数
w_ini = 0.9;
w_end = 0.4;
%初始化粒子群的位置参数,及速度参数，历史最优以及全局最优
location = [zeros(17,node_size) ; 1./zeros(1,node_size)];
velocity = zeros(17,node_size);
gbest = [zeros(17,Gk); 1./zeros(1,Gk)];
pbest = [zeros(17,node_size) ; 1./zeros(1,node_size)];
count = 1;
for i = 1:node_size
    %初始化位置信息，三个维度的初始化要单独进行，以防止初始化点在xmin->xmax向量上
    for j = 1:17
        location(j,i) = xmin(j) + (xmax(j) - xmin(j))*rand(1);
    end
    location(18,i) = adaptive_value_cal_with_t0(location(1:17,i),series);
    pbest(:,i) = location(:,i);
    if location(18,i) < gbest(18, count)
        gbest(:,count) = location(:,i);
    end
    %初始化速度，每个分量也需要单独进行，保证速度的分量不是在vmax->vmin向量上
    for j = 1:17
        velocity(j,i) = vmin(j) + (vmax(j) - vmin(j))*rand(1);
    end
end
count = count + 1;
while count <= Gk
    %先更新惯性因子
%     w = (w_ini - w_end)*(Gk-count)/Gk + w_end;
    w = 1;
    %当前的历史最优解先保持为上一次的历史最优解
    gbest(:,count) = gbest(:,count-1); 
    for i = 1:node_size
        %速度更新公式----原始速度-----------------根据自身历史最优的调整量-------------------------根据全局历史最优的调整量---------------
        %三个维度分别更新,保证维度独立性
        for j = 1:17
            velocity(j,i) = w * velocity(j,i) + c1 * rand(1) * (pbest(j,i)-location(j,i)) + c2 * rand(1) * (gbest(j,count) - location(j,i));
        end        
        %考虑速度的界限
        for j = 1:17
            if velocity(j,i) > vmax(j)
                velocity(j,i) = vmax(j);
            else
                if velocity(j,i) < vmin(j)
                    velocity(j,i) = vmin(j);
                end
            end
        end
        %位置调整
        location(1:17,i) = location(1:17,i) + velocity(:,i);
        %考虑位置界限
        for j = 1:17
            if location(j,i) < xmin(j)
                location(j,i) = xmin(j);
            else
                if location(j,i) > xmax(j)
                    location(j,i) = xmax(j);
                end
            end
        end
        location(18,i) = adaptive_value_cal_with_t0(location(1:17,i),series);
        if location(18,i) < pbest(18,i)
            pbest(:,i) = location(:,i);
        end
        if location(18,i) < gbest(18,count)
            gbest(:,count) = location(:,i);
        end
    end
%     count
    count = count + 1;
end
para = gbest(:,count-1);
end