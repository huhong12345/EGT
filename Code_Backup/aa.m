function result = FourStratery_simulate_im_over_regular_graph(U,graph, alpha, iterate_time, N,k)
    function fit_result = fitness_calculate(index)
        fit = (1-alpha);     %fit=(1-alpha)+alpha*U
        for l=1:k
            fit=fit+alpha*U(index,strategy_state(graph(index,l))); 
        end
        fit_result = fit;
    end

    strategy_state = zeros(1,N);  %定义出长度为N的0矩阵（1*N)
    z=[0.05,0.025,0.025,0.9];           %define the percentage of every strategy
    K=N*z;
    starter_table=randperm(N);          %打乱的
    S1=[];S2=[];S3=[];S4=[];
    S1=zeros(1,N);
    S2=zeros(1,N);
    S3=zeros(1,N);
    S4=zeros(1,N);
%    S=[S1;S2;S3;S4];

    
    for i=1:N                           %define the strategy state 1,2,3,4
        if i<=K(1)
            strategy_state(starter_table(i))=1;
            S1=[S1,starter_table(i)]
   %         S1(i)=strategy_state(i);
        end
        if K(1)<i<=K(2)
            strategy_state(starter_table(i))=2;
            S2=[S2,starter_table(i)]
%            S2(i-K(1)=strategy_state(i);
        end
        if K(2)<i<=K(3)
            strategy_state(starter_table(i))=3;
            S3=[S3,starter_table(i)]
%            S3(i-K(2))=strategy_state(i);
        end
        if i>K(3)
            strategy_state(starter_table(i))=4;
            S4=[S4,starter_table(i)]
%           S4(i-K(3))=strategy_state(i);
        end   
    end  
    S=[S1;S2;S3;S4];   


    x=zeros(4,iterate_time);
    time = 1;
    for i=1:4
        x(i,time) = K(i)/N;     %initialize the start 
    end
    time = time + 1;
    while time<=iterate_time
        %每次遍历全部点，并根据IM——rule更新
         for p = 1:N
            i = randi(N);    %%随机从N个人中选一个i
            friend_list=graph(i,:);
            fit_self = fitness_calculate(i);    %算出自己的fitness
            fit1=0;fit2=0;fit3=0;fit4=0;
v

            if strategy_state(i)==1
                for j=1:k
                    fit


                    if strategy_state(graph(i,j))
                        





            if video





%           friend_list = find_friend(i,N);    %寻找i的邻居，返回一个1*N的矩阵，前k个有数，后面为0
%           friend_number = length(friend_list);   %k
            %calculate self-fitness

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
