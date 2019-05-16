function result = simulate_im_over_regular_graph(U, graph, alpha, iteration_time, N,k)
    function fit_result = fitness_calculate(index)
        fitness = (1-alpha);     %fit=(1-alpha)+alpha*U
        for q=1:k
            fitness=fitness+alpha*U(strategy_state(index),strategy_state(graph(index,q)));%fitness=1+alpha*U(i,j)
        end
        fit_result = fitness;
    end
    result=zeros(1,iteration_time);
    strategy_state = zeros(1,N);  
    z=[0.1,0.9];           %define the percentage of every strategy
    K=N*z;                        %K represents the percentage matrix
    starter_table=randperm(N);          %打乱的N个数
    for i=1:N                           %define the strategy state 1,2,3,4
        if i<=K(1)
            strategy_state(starter_table(i))=1;   %1为Sf，2为Sn
        else
            strategy_state(starter_table(i))=2;
        end
    end  
    x=zeros(1,iteration_time);
    time = 1;
    x(time)=K(1)/N;     %initial the start 
    for time=2:iteration_time      
        for p = 1:N          %每次遍历全部点，并根据IM——rule更新
            i = randi(N);    %%随机从N个人中选一个i
            friend_list=graph(i,:); 
            ss=strategy_state(i);
            fit_self = fitness_calculate(i);    %算出自己的fitness
            fit=[0,0];
            for j=1:k
                fit(strategy_state(friend_list(j)))=fit(strategy_state(friend_list(j)))+fitness_calculate(friend_list(j));
            end
            fit(ss)=fit(ss)+fit_self;
            rn=rand;
            sigma=sum(fit);
            if ss==1
                judge=fit(2)/sigma;
                if rn<=judge
                    strategy_state(i)=2;
                    K(1)=K(1)-1;
                    K(2)=K(2)+1;
                end
            else
                judge=fit(1)/sigma;
                if rn<=judge
                    strategy_state(i)=1;
                    K(1)=K(1)+1;
                    K(2)=K(2)-1;
                end
            end
        end          
        x(time) = K(1)/N;
    end
    result=x;
end  
    
    
    
