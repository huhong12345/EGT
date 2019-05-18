function result = simulate_im_over_regular_graph(uff, ufn, unn, graph, alpha, iterate_time, N)
    function fit_result = fitness_calculate(index,k)
        fit = (1-alpha);     %fit=(1-alpha)+alpha*U
        if action_table(index)==1       %������Ϊforward    
           % while con_matrix(index, l) ~= 0        %ѭ��k??
           for l=1:k
                if action_table(con_matrix(index,l))==1              %��l���ھ�Ϊforward
                    fit = fit + alpha*uff;         %�Լ���fitness����alpha*uff
                else                               %��l���ھ�Ϊnot forward
                    fit = fit + alpha*ufn;         %�Լ���fitness����alpha*ufn     
                end 
            end
        else                          %������Ϊnot forward
            %while con_matrix(index, l) ~= 0    %ѭ��k?? 
            for l=1:k
                if action_table(con_matrix(index,l))==1          %��l���ھ�Ϊforward
                    fit = fit + alpha*ufn;
                else                           %��l���ھ�Ϊnot forward
                    fit = fit + alpha*unn;
                end
            %    l = l + 1;
            end
        end
        fit_result = fit;
    end
    
    global con_matrix
    con_matrix = graph;  %��i�б�ʾ��i������ھӱ�??
%     con_matrix = regular_graph_generate(N,k);
    action_table = zeros(1,N);  %���������ΪN??0����??1*N??
%     for i = 1:N
%         action_table(i) = randi(2)-1;
%     end
    NN=0.1*N;
    NN=floor(NN);
    starter_table = randperm(N,NN);   %1000�������ȡ��100����
    for i = starter_table
        action_table(i) = 1;        %action_table����������100��Ϊ1�ĵ㣬��??900??0??%%%action_table=1��ʾforward??0��not forward
    end
    x = zeros(1,iterate_time);      %xΪ����Ϊ1*400
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
        %ÿ�α���ȫ���㣬������IM��???rule����
         for p = 1:N
            i = randi(N);    %%���??1000������???һ��i
            friend_list=[];
            for q=1:K(i)
                    friend_list=[friend_list,graph(i,q)];
            end
          %  friend_list = graph(i,:);    %Ѱ��i���ھӣ�����????1*N�ľ���ǰk������������??0
            friend_number = length(friend_list);   %k
            %calculate self-fitness
            fit_self = fitness_calculate(i,K(i));    %����Լ���fitness
            fit_f = 0; 
            fit_n = 0;
            if action_table(i)==1          %���i�Լ�forward
                for j =1:friend_number     %j??1��k    
                    if action_table(friend_list(j))==1              %���i���ھ�j��Ϊforward
                        fit_f = fit_f + fitness_calculate(friend_list(j),K(friend_list(j)));
                    else                                            %���i���ھ�j��Ϊnot forward
                        fit_n = fit_n + fitness_calculate(friend_list(j),K(friend_list(j)));           
                    end
                end
                judge = fit_n/(fit_f + fit_n + fit_self);
                rand_num = rand;              %rand_numΪ[0,1]���??
                if rand_num <= judge
                    action_table(i) = 0;      %���Լ���Ϊnot forward
                end
            else                       %���iΪnot forward
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