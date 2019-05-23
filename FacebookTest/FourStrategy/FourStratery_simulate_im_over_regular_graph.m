function result = FourStratery_simulate_im_over_regular_graph(U,graph, alpha, iteration_time, N,k)
    function fit_result = fitness_calculate(index,k)
        fitness = (1-alpha);     %fit=(1-alpha)+alpha*U
        for q=1:k
            fitness=fitness+alpha*U(strategy_state(index),strategy_state(graph(index,q)));%fitness=1+alpha*U(i,j)
        end
        fit_result = fitness;
    end
    strategy_state = zeros(1,N);  
    z=[0.1,0.2,0.3,0.4];           %define the percentage of every strategy
    K=N*z;                        %K is the population matrix
    starter_table=randperm(N);          %create random N number out of order
    %S1=[];S2=[];S3=[];S4=[];   
    for i=1:N                           %define the strategy state 1,2,3,4
        m=starter_table(i);
        if i<=K(1)            
            strategy_state(starter_table(i))=1;
        elseif i<=(K(1)+K(2))
            strategy_state(starter_table(i))=2;
        elseif i<=(K(1)+K(2)+K(3))
            strategy_state(starter_table(i))=3;
        else  
            strategy_state(starter_table(i))=4;
        end   
    end  
    x=zeros(4,iteration_time);
    time = 1;
    Q=K';
    x(:,time)=Q/N;     %initial the start 
    time = time + 1;

    KK=zeros(1,N);
    for qqq=1:N
        for ppp=1:1045
            if graph(qqq,ppp)~=0
                KK(qqq)=KK(qqq)+1;
            end
        end
    end

    while time<=iteration_time 
        time     
        for p = 1:N          
            i = randi(N);    
            friend_list=[];
            for qq=1:KK(i)
                friend_list=[friend_list,graph(i,qq)];
            end         
            fit_self = fitness_calculate(i,KK(i));    %caculate own fitness
            fit=[0,0,0,0];
            for j=1:KK(i)
                fit(strategy_state(friend_list(j)))=fit(strategy_state(friend_list(j)))+fitness_calculate(friend_list(j),KK(friend_list(j)));
            end
            fit(strategy_state(i))=fit(strategy_state(i))+fit_self;
            sigma=sum(fit);
            judge1=fit(1)/sigma;
            judge2=(fit(1)+fit(2))/sigma;
            judge3=1-fit(4)/sigma;
            w=(fit(1)+fit(2)+fit(3))/sigma;
            temp=strategy_state(i);
            rn=rand;                    %%rn is a random number ranging in [0,1]
            if rn<=judge1                %%three judge threshold, divide [0,1] to four part
                strategy_state(i)=1;          
            elseif rn<=judge2
                strategy_state(i)=2;
            elseif rn<=judge3
                strategy_state(i)=3;
            else
                strategy_state(i)=4;
            end
              % eee=strategy_state(i);
            if temp==strategy_state(i)        %%to judge if strategy was changed or not
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