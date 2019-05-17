function para = one_time_PSO_solver_with_t0(times)
series = times;
% series(1:3)=[0,0,0];
%����Ⱥ�Ĵ�С
node_size = 40;
%��������������
Gk = 101;
%����λ�õ����½��Լ��ٶȵı߽�
%beta1,beta2,gamma1,gamma2,alpha1,alpha2,delta1,delta2
vmax = [0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1];
vmin = -vmax;
xmax = [1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;30];
xmin = [0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;5];
% vmax = [1;1];
% vmin = -vmax;
% xmax = [20;20];
% xmin = [0.00;0.000];
%��ʼ�����ٶȲ���c1,c2
c1 = 2;
c2 = 2;
%��ʼ�����Բ���
w_ini = 0.9;
w_end = 0.4;
%��ʼ������Ⱥ��λ�ò���,���ٶȲ�������ʷ�����Լ�ȫ������
location = [zeros(17,node_size) ; 1./zeros(1,node_size)];
velocity = zeros(17,node_size);
gbest = [zeros(17,Gk); 1./zeros(1,Gk)];
pbest = [zeros(17,node_size) ; 1./zeros(1,node_size)];
count = 1;
for i = 1:node_size
    %��ʼ��λ����Ϣ������ά�ȵĳ�ʼ��Ҫ�������У��Է�ֹ��ʼ������xmin->xmax������
    for j = 1:17
        location(j,i) = xmin(j) + (xmax(j) - xmin(j))*rand(1);
    end
    location(18,i) = adaptive_value_cal_with_t0(location(1:17,i),series);
    pbest(:,i) = location(:,i);
    if location(18,i) < gbest(18, count)
        gbest(:,count) = location(:,i);
    end
    %��ʼ���ٶȣ�ÿ������Ҳ��Ҫ�������У���֤�ٶȵķ���������vmax->vmin������
    for j = 1:17
        velocity(j,i) = vmin(j) + (vmax(j) - vmin(j))*rand(1);
    end
end
count = count + 1;
while count <= Gk
    %�ȸ��¹�������
%     w = (w_ini - w_end)*(Gk-count)/Gk + w_end;
    w = 1;
    %��ǰ����ʷ���Ž��ȱ���Ϊ��һ�ε���ʷ���Ž�
    gbest(:,count) = gbest(:,count-1); 
    for i = 1:node_size
        %�ٶȸ��¹�ʽ----ԭʼ�ٶ�-----------------����������ʷ���ŵĵ�����-------------------------����ȫ����ʷ���ŵĵ�����---------------
        %����ά�ȷֱ����,��֤ά�ȶ�����
        for j = 1:17
            velocity(j,i) = w * velocity(j,i) + c1 * rand(1) * (pbest(j,i)-location(j,i)) + c2 * rand(1) * (gbest(j,count) - location(j,i));
        end        
        %�����ٶȵĽ���
        for j = 1:17
            if velocity(j,i) > vmax(j)
                velocity(j,i) = vmax(j);
            else
                if velocity(j,i) < vmin(j)
                    velocity(j,i) = vmin(j);
                end
            end
        end
        %λ�õ���
        location(1:17,i) = location(1:17,i) + velocity(:,i);
        %����λ�ý���
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