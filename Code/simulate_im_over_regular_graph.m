function result = simulate_im_over_regular_graph(uff, ufn, unn, graph, alpha, iterate_time, N)
    
	function list = find_friend(index)
		friend_list = [];
		l = 1;
		while con_matrix(index,l)~=0
			friend_list = [friend_list, con_matrix(index,l)];
			l = l+1;
		end
		list = friend_list;
	end
	
	function fit_result = fitness_calculate(index)
        fit = (1-alpha);
        n = length(action_table);
        if action_table(index)==1
            l = 1;
			while con_matrix(index,l)~=0
				if action_table(con_matrix(index,l))==1
					fit = fit + alpha*uff;
                else
                    fit = fit + alpha*ufn;
                end
				l = l + 1;
			end
        else
            l = 1;
			while con_matrix(index,l)~=0
				if action_table(con_matrix(index,l))==1
					fit = fit + alpha*ufn;
                else
                    fit = fit + alpha*unn;
                end
				l = l + 1;
			end
        end
        fit_result = fit;
    end
    
    con_matrix = graph;
%     con_matrix = regular_graph_generate(N,k);
    action_table = zeros(1,N);
%     for i = 1:N
%         action_table(i) = randi(2)-1;
%     end
    starter_table = randperm(N,100);
    for i = starter_table
        action_table(i) = 1;
    end
    x = zeros(1,iterate_time);
    count = 1;
    x(count) = sum(action_table)/N;
    count = count + 1;
    while count<=iterate_time
        %ÿ�α���ȫ���㣬������IM-rule���и���
         for p = 1:N
            i = randi(N);
            friend_list = find_friend(i);
            friend_number = length(friend_list);
            %calculate self-fitness
            fit_self = fitness_calculate(i);
            fit_f = 0;
            fit_n = 0;
            if action_table(i)==1
                for j =1:friend_number
                    if action_table(friend_list(j))==1
                        fit_f = fit_f + fitness_calculate(friend_list(j));
                    else
                        fit_n = fit_n + fitness_calculate(friend_list(j));
                    end
                end
                judge = fit_n/(fit_f + fit_n + fit_self);
                rand_num = rand;
                if rand_num <= judge
                    action_table(i) = 0;
                end
            else
                for j =1:friend_number
                    if action_table(friend_list(j))==1
                        fit_f = fit_f + fitness_calculate(friend_list(j));
                    else
                        fit_n = fit_n + fitness_calculate(friend_list(j));
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