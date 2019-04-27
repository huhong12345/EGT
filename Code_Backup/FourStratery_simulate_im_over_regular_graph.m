function result = FourStratery_simulate_im_over_regular_graph(U,graph, alpha, iterate_time, N,k)
    function fit_result = fitness_calculate(index)
        fitness = (1-alpha);     %fit=(1-alpha)+alpha*U
        for q=1:k
            fitness=fitness+alpha*U(strategy_state(index),strategy_state(graph(index,q)));%fitness=1+alpha*U(i,j)
        end
        fit_result = fitness;
    end

    strategy_state = zeros(1,N);  %定义出长度为N的0矩阵（1*N)
    z=[0.05,0.025,0.025,0.9];           %define the percentage of every strategy
    K=N*z;                        %K矩阵为最重要的比例矩阵
    starter_table=randperm(N);          %打乱的N个数
    %S1=[];S2=[];S3=[];S4=[];   
    for i=1:N                           %define the strategy state 1,2,3,4
        if i<=K(1)
            strategy_state(starter_table(i))=1;
            %S1=[S1,starter_table(i)]
        end
        if K(1)<i<=K(2)
            strategy_state(starter_table(i))=2;
            %S2=[S2,starter_table(i)]
        end
        if K(2)<i<=K(3)
            strategy_state(starter_table(i))=3;
            %S3=[S3,starter_table(i)]
        end
        if i>K(3)
            strategy_state(starter_table(i))=4;
           % S4=[S4,starter_table(i)]
        end   
    end  
    %S=[S1;S2;S3;S4];    Si表示第i种策略人的标号集合
    x=zeros(4,iterate_time);
    time = 1;
    Q=K';
    x(:,time)=Q/N;     %initial the start 
    time = time + 1;
    while time<=iterate_time      
        for p = 1:N          %每次遍历全部点，并根据IM——rule更新
            i = randi(N);    %%随机从N个人中选一个i
            friend_list=graph(i,:);           
            fit_self = fitness_calculate(i);    %算出自己的fitness
            fit=[0,0,0,0];
            for j=1:k
                fit(strategy_state(j))=fit(strategy_state(j))+fitness_calculate(friend_list(j));
            end
            fit(i)=fit(i)+fit_self;
            sigma=sum(fit);
            judge1=fit(1)/sigma;
            judge2=fit(1)+fit(2)/sigma;
            judge3=1-fit(4)/sigma;
            temp=strategy_state(i);
            rn=rand;                    %%rn为[0,1]的随机数
            if rn<=judge1                %%三个门限，按fitness定义四个区间
                strategy_state(i)=1;
            end
            if judge1<rn<=judge2
                strategy_state(i)=2;
            end
            if judge2<rn<=judge3
                strategy_state(i)=3;
            end
            if rn>judge3
                strategy_state(i)=4;
            end

            if temp==strategy_state(i)        %%判断是否维持原状
                return;
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
    result=x;
end