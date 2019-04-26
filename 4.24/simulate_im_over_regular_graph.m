function result = simulate_im_over_regular_graph(U, graph, alpha, iterate_time, N,k)
    function fit_result = fitness_calculate(index,k)
        fitness = (1-alpha);     %fit=(1-alpha)+alpha*U
        for q=1:k
            fitness=fitness+alpha*U(strategy_state(index),strategy_state(graph(index,q)));%fitness=1+alpha*U(i,j)
        end
        fit_result = fitness;
    end
    result=zeros(1,iterate_time);
    strategy_state = zeros(1,N);  %定义出长度为N的0矩阵（1*N)
    z=[0.1,0.9];           %define the percentage of every strategy
    K=N*z;                        %K矩阵为最重要的比例矩阵
    starter_table=randperm(N);          %打乱的N个数
    %S1=[];S2=[];S3=[];S4=[];   
    for i=1:N                           %define the strategy state 1,2,3,4
        if i<=K(1)
            strategy_state(starter_table(i))=1;
            %S1=[S1,starter_table(i)]
        else
            strategy_state(starter_table(i))=2;
        end
    end  
    %S=[S1;S2;S3;S4];    Si表示第i种策略人的标号集合
    x=zeros(1,iterate_time);
    time = 1;
    %Q=K';
    x(time)=K(1)/N;     %initial the start 
    %time = time + 1;
    for time=2:iterate_time      
        for p = 1:N          %每次遍历全部点，并根据IM——rule更新
            i = randi([1,N]);    %%随机从N个人中选一个i
            friend_list=graph(i,:);               
            fit_self = fitness_calculate(i,k);    %算出自己的fitness
            fit=[0,0];
            for j=1:k
                fit(strategy_state(friend_list(j)))=fit(strategy_state(friend_list(j)))+fitness_calculate(friend_list(j),k);
            end
            %fit(strategy_state(i))=fit(strategy_state(i))+fit_self;           
            sigma=fit(1)+fit(2)+fit_self;
%             judge1=fit(1)/sigma;
%             judge2=fit(2)/sigma;
            b=strategy_state(i);
            if b==1   %foward
               judge2=fit(2)/sigma;
               rn=rand;
               if rn<=judge2
                   strategy_state(i)=2;
                   K(1)=K(1)-1;
               end
            else         %not forward
                judge1=fit(1)/sigma;
                rn=rand;
                if rn<=judge1
                    strategy_state(i)=1;
                    K(1)=K(1)+1;
                end
            end
            %judge2=fit(1)+fit(2)/sigma;
         %   judge3=1-fit(4)/sigma;
%             temp=strategy_state(i);
%             rn=rand;                    %%rn为[0,1]的随机数
%             if rn<=judge1                %%三个门限，按fitness定义四个区间
%                 strategy_state(i)=1;
%             else
%                 strategy_state(i)=2;
%             end
%             if judge1<rn<=judge2
%                 strategy_state(i)=2;
%             end
%             if judge2<rn<=judge3
%                 strategy_state(i)=3;
%             end
%             if rn>judge3
%                 strategy_state(i)=4;
%             end

%             if temp==strategy_state(i)        %%判断是否维持原状
%                 %return;
%             else
%                 K(strategy_state(i))=K(strategy_state(i))+1;
%                 K(temp)=K(temp)-1;
%             end
        end
        %x(i,tim e)=K(i)/N
        %Q=K';
        x(time) = K(1)/N;
      %  time = time + 1;
    end
    result=x;
end  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  

% 
% 
% 
%     
%     global con_matrix
%     con_matrix = graph;
% %     con_matrix = regular_graph_generate(N,k);
%     action_table = zeros(1,N);
% %     for i = 1:N
% %         action_table(i) = randi(2)-1;
% %     end
%     starter_table = randperm(1000,100);
%     for i = starter_table
%         action_table(i) = 1;
%     end
%     x = zeros(1,iterate_time);
%     count = 1;
%     x(count) = sum(action_table)/1000;
%     count = count + 1;
%     while count<=iterate_time
%         %每次遍历全部点，并根据IM-rule进行更新
%          for p = 1:1000
%             i = randi(1000);
%             friend_list = find_friend(i,N);
%             friend_number = length(friend_list);
%             %calculate self-fitness
%             fit_self = fitness_calculate(i);
%             fit_f = 0;
%             fit_n = 0;
%             if action_table(i)==1
%                 for j =1:friend_number
%                     if action_table(friend_list(j))==1
%                         fit_f = fit_f + fitness_calculate(friend_list(j));
%                     else
%                         fit_n = fit_n + fitness_calculate(friend_list(j));
%                     end
%                 end
%                 judge = fit_n/(fit_f + fit_n + fit_self);
%                 rand_num = rand;
%                 if rand_num <= judge
%                     action_table(i) = 0;
%                 end
%             else
%                 for j =1:friend_number
%                     if action_table(friend_list(j))==1
%                         fit_f = fit_f + fitness_calculate(friend_list(j));
%                     else
%                         fit_n = fit_n + fitness_calculate(friend_list(j));
%                     end
%                 end
%                 judge = fit_f/(fit_f + fit_n + fit_self);
%                 rand_num = rand;
%                 if rand_num <= judge
%                     action_table(i) = 1;
%                 end
%             end            
%          end
%         
%         x(count) = sum(action_table)/N;
%         count = count + 1;
%     end
%     result = x;
% end
        
%         
%         l = 1;
%         if action_table(index)==1
%             while con_matrix(index, l) ~= 0
%                 if action_table(l)==1
%                     fit = fit + alpha*uff;
%                 else
%                     fit = fit + alpha*ufn;
%                 end
%                 l = l + 1;
%             end
%         else
%             while con_matrix(index, l) ~= 0
%                 if action_table(l)==1
%                     fit = fit + alpha*ufn;
%                 else
%                     fit = fit + alpha*unn;
%                 end
%                 l = l + 1;
%             end
%         end
%         fit_result = fit;
%     end