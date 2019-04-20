function result = FourStratery_simulate_im_over_regular_graph(U,graph, alpha, iterate_time, N,k)
    function fit_result = fitness_calculate(index)
        fit = (1-alpha);     %fit=(1-alpha)+alpha*U
        l=1;
        for l<=k;
            fit=fit+alpha*U[index,strategy_state[friend_matrix[index,l]]];
            l=l+1;  
        end
        fit_result = fit;
    end
    function output = myFun(input)
        K=zeros
        
        

    end

    global friend_matrix
    friend_matrix = graph;  %第i行表示第i个点的邻居标号

    strategy_state = zeros(1,N);  %定义出长度为N的0矩阵（1*N)



%     for i = 1:N
%         strategy_state(i) = randi(2)-1;
%     end
    z=[0.05,0.025,0.025,0.9];           %define the percentage of every strategy
    starter_table=randperm(N);          %define the strategy state
    for i=1:N
        if i<=N*z[1]
            strategy_state(starter_table(i))=1;
        end
        if N*z[1]<i<=N*z[2]
            strategy_state(starter_table(i))=2;
        end
        if N*z[2]<i<=N*z[3]
            strategy_state(starter_table(i))=3;
        end
        if i>N*z[3]
            strategy_state(starter_table(i))=4;
        end   
    end     

    x=zeros(4,iterate_time);
    time = 1;
    for i=1:4
        x(i,time) = sum(strategy_state)/(i*N);     %infinite the start 
    end




    time = time + 1;
    while time<=iterate_time
        %每次遍历全部点，并根据IM——rule更新
         for p = 1:N
            i = randi(N);    %%随机从1000个人中选一个i
            friend_list = find_friend(i,N);    %寻找i的邻居，返回一个1*N的矩阵，前k个有数，后面为0
            friend_number = length(friend_list);   %k
            %calculate self-fitness
            fit_self = fitness_calculate(i);    %算出自己的fitness
            fit_f = 0; 
            fit_n = 0;
            if strategy_state(i)==1          %如果i自己forward
                for j =1:friend_number     %j从1到k    
                    if strategy_state(friend_list(j))==1              %如果i的邻居j，为forward
                        fit_f = fit_f + fitness_calculate(friend_list(j));
                    else                                            %如果i的邻居j，为not forward
                        fit_n = fit_n + fitness_calculate(friend_list(j));           
                    end
                end
                judge = fit_n/(fit_f + fit_n + fit_self);
                rand_num = rand;              %rand_num为[0,1]间的数
                if rand_num <= judge
                    strategy_state(i) = 0;      %将自己变为not forward
                end
            else                       %如果i为not forward
                for j =1:friend_number
                    if strategy_state(friend_list(j))==1
                        fit_f = fit_f + fitness_calculate(friend_list(j));
                    else
                        fit_n = fit_n + fitness_calculate(friend_list(j));
                    end
                end
                judge = fit_f/(fit_f + fit_n + fit_self);
                rand_num = rand;
                if rand_num <= judge
                    strategy_state(i) = 1;
                end
            end            
         end
        
        x(time) = sum(strategy_state)/N;
        time = time + 1;
    end
    result = x;
end
