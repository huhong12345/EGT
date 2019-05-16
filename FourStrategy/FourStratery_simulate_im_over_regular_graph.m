function result = FourStratery_simulate_im_over_regular_graph(U,graph, alpha, iteration_time, N,k)
    function fit_result = fitness_calculate(index)
        fitness = (1-alpha);     %fit=(1-alpha)+alpha*U
        for q=1:k
            fitness=fitness+alpha*U(strategy_state(index),strategy_state(graph(index,q)));%fitness=1+alpha*U(i,j)
        end
        fit_result = fitness;
    end

    strategy_state = zeros(1,N);  
    z=[0.1,0.2,0.3,0.4];           %define the percentage of every strategy
    KK=zeros(1,4);
    K=N*z;                        %K矩阵为最重要的比例矩�??
    starter_table=randperm(N);          %打乱的N个数
    %S1=[];S2=[];S3=[];S4=[];   
    for i=1:N                           %define the strategy state 1,2,3,4
        m=starter_table(i);
        if i<=K(1)            
            strategy_state(starter_table(i))=1;
            KK(strategy_state(starter_table(i)))=KK(strategy_state(starter_table(i)))+1;
            %S1=[S1,starter_table(i)]
        elseif i<=(K(1)+K(2))
            strategy_state(starter_table(i))=2;
            KK(strategy_state(starter_table(i)))=KK(strategy_state(starter_table(i)))+1;           
            %S2=[S2,starter_table(i)]
        elseif i<=(K(1)+K(2)+K(3))
            strategy_state(starter_table(i))=3;
            KK(strategy_state(starter_table(i)))=KK(strategy_state(starter_table(i)))+1;          
            %S3=[S3,starter_table(i)]
        else  
            strategy_state(starter_table(i))=4;
            KK(strategy_state(starter_table(i)))=KK(strategy_state(starter_table(i)))+1;
           % S4=[S4,starter_table(i)]
        end   
    end  
    %S=[S1;S2;S3;S4];    Si表示第i种策略人的标号集�??
    x=zeros(4,iteration_time);
    time = 1;
    Q=K';
    x(:,time)=Q/N;     %initial the start 
    time = time + 1;
    while time<=iteration_time      
        for p = 1:N          
            i = randi(N);    
            friend_list=graph(i,:);           
            fit_self = fitness_calculate(i);    %算出自己的fitness
            fit=[0,0,0,0];
            for j=1:k
                fit(strategy_state(friend_list(j)))=fit(strategy_state(friend_list(j)))+fitness_calculate(friend_list(j));
            end
            fit(strategy_state(i))=fit(strategy_state(i))+fit_self;
            sigma=sum(fit);
            judge1=fit(1)/sigma;
            judge2=(fit(1)+fit(2))/sigma;
            judge3=1-fit(4)/sigma;
            w=(fit(1)+fit(2)+fit(3))/sigma;
            temp=strategy_state(i);
            rn=rand;                    %%rn为[0,1]的随机数
            if rn<=judge1                %%三个门限，按fitness定义四个区间
                strategy_state(i)=1;          
            elseif rn<=judge2
                strategy_state(i)=2;
            elseif rn<=judge3
                strategy_state(i)=3;
            else
                strategy_state(i)=4;
            end
               eee=strategy_state(i);
            if temp==strategy_state(i)        %%判断是否维持原状
                %return;
            else
                K(strategy_state(i))=K(strategy_state(i))+1;
                K(temp)=K(temp)-1;
            end
        end
        %x(i,time)=K(i)/N
        Q=K';
        x(:,time) = Q/N;
        time = time + 1;
    end
    result=x';
end