function result = simulate_im_over_regular_graph(uff, ufn, unn, graph, alpha, iterate_time, N)
    function fit_result = fitness_calculate(index,k)
        fit = (1-alpha);     %fit=(1-alpha)+alpha*U
        if action_table(index)==1       %若输入为forward    
           % while con_matrix(index, l) ~= 0        %循环k??
           for l=1:k
                if action_table(con_matrix(index,l))==1              %第l个邻居为forward
                    fit = fit + alpha*uff;         %自己的fitness加上alpha*uff
                else                               %第l个邻居为not forward
                    fit = fit + alpha*ufn;         %自己的fitness加上alpha*ufn     
                end 
            end
        else                          %若输入为not forward
            %while con_matrix(index, l) ~= 0    %循环k?? 
            for l=1:k
                if action_table(con_matrix(index,l))==1          %第l个邻居为forward
                    fit = fit + alpha*ufn;
                else                           %第l个邻居为not forward
                    fit = fit + alpha*unn;
                end
            %    l = l + 1;
            end
        end
        fit_result = fit;
    end
    
    global con_matrix
    con_matrix = graph;  %第i行表示第i个点的邻居标??
%     con_matrix = regular_graph_generate(N,k);
    action_table = zeros(1,N);  %定义出长度为N??0矩阵??1*N??
%     for i = 1:N
%         action_table(i) = randi(2)-1;
%     end
    NN=0.1*N;
    NN=floor(NN);
    starter_table = randperm(N,NN);   %1000中随机抽取了100个数
    for i = starter_table
        action_table(i) = 1;        %action_table中随机定义出100个为1的点，其??900??0??%%%action_table=1表示forward??0表not forward
    end
    x = zeros(1,iterate_time);      %x为长度为1*400
    count = 1;
    x(count) = sum(action_table)/N;
    count = count + 1;
    K=zeros(1,N);
    for qqq=1:N
        for ppp=1:1045
            if graph(qqq,ppp)~=0
                K(qqq)=K(qqq)+1;
            end
        end
    end
    while cou`nt<=iterate_time
        %每次遍历全部点，并根据IM—???rule更新
         for p = 1:N
            i = randi(N);    %%随机??1000个人中???一个i
            friend_list=[];
            for q=1:K(i)
                    friend_list=[friend_list,graph(i,q)];
            end
          %  friend_list = graph(i,:);    %寻找i的邻居，返回????1*N的矩阵，前k个有数，后面??0
            friend_number = length(friend_list);   %k
            %calculate self-fitness
            fit_self = fitness_calculate(i,K(i));    %算出自己的fitness
            fit_f = 0; 
            fit_n = 0;
            if action_table(i)==1          %如果i自己forward
                for j =1:friend_number     %j??1到k    
                    if action_table(friend_list(j))==1              %如果i的邻居j，为forward
                        fit_f = fit_f + fitness_calculate(friend_list(j),K(friend_list(j)));
                    else                                            %如果i的邻居j，为not forward
                        fit_n = fit_n + fitness_calculate(friend_list(j),K(friend_list(j)));           
                    end
                end
                judge = fit_n/(fit_f + fit_n + fit_self);
                rand_num = rand;              %rand_num为[0,1]间的??
                if rand_num <= judge
                    action_table(i) = 0;      %将自己变为not forward
                end
            else                       %如果i为not forward
                for j =1:friend_number
                    if action_table(friend_list(j))==1
                        fit_f = fit_f + fitness_calculate(friend_list(j),K(friend_list(j)));
                    else
                        fit_n = fit_n + fitness_calculate(friend_list(j),K(friend_list(j)));
                    end
                end
                judge = fit_f/(fit_f + fit_n + fit_self);
                rand_num = rand;
                if rand_num <= judge
                    action_table(i) = 1;
                end
            end            
         end        
        x(count) = sum(action_table)/N;
        count = count + 1;
    end
    result = x;
end