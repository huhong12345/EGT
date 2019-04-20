function result = bd_updating_process(uff, ufn, unn, con_matrix, alpha, iterate_time, N)
    function fit_result = fitness_calculate(index)
        %dont calculate 1-alpha directly
		fit = 0;
		if strategy(index) == 1
			%focal user's strategy is Sf
			l = 1;
			while con_matrix(index,l)~= 0
				if strategy(con_matrix(index,l)) == 1
					fit = fit + uff;
				else
					fit = fit + ufn;
				end
				l = l + 1;
			end
		else
			%focal user's strategy is Sn
			l = 1;
			while con_matrix(index, l)~= 0
				if strategy(con_matrix(index,l)) == 1
					fit = fit + ufn;
				else
					fit = fit + unn;
				end
				l = l + 1;
			end
		end
		%times alpha together to save calculation time
        fit_result = (1-alpha) + alpha * fit;
    end
	
	function friend_list = find_friend(index)
		friend_list = [];
		k = 1;
		while con_matrix(index, k) ~= 0
			friend_list = [friend_list, con_matrix(index,k)];
            k = k + 1;
		end
    end
    
    strategy = zeros(1,N);
	fitness_table = zeros(1,N);
	chosen_probability = zeros(1,N);
	%randomly generator initial adopters
    initial_adopter = randperm(N,100);
    for i = initial_adopter
        strategy(i) = 1;
    end
	%calculate fitness for each user
	for i = 1:N
		fitness_table(i) = fitness_calculate(i);
	end
    x = zeros(1,iterate_time);
    count = 1;
	%the proportion of sf adopters
    x(count) = sum(strategy)/N;
    count = count + 1;
    %use flag to state whether one fitness changed, if not we do not need
    %to re-calculate the fitness cumulative function
    flag = 1;
    while count<=iterate_time
        %in each time slot randomly select N user using BD rule proportional to fitness
         for p = 1:N
			%first chosen user in BD is proportional to the fitness
			%calculate the cumulative probability
            if flag == 1
                chosen_probability(1) = fitness_table(1);
                for i = 2:N
                    chosen_probability(i) = chosen_probability(i-1) + fitness_table(i);
                end
                %converte
                chosen_probability = chosen_probability/chosen_probability(N);
            end		
            %select a user
			prob = rand;
			for i = 1:N
				if prob <= chosen_probability(i)
					chosen_index = i;
					break;
				end
			end
			%find the user's neighbors
            friend_list = find_friend(chosen_index);
            friend_number = length(friend_list);
			%randomly select a neighbor to adopt the strategy
			chosen_neighbor = friend_list(randi(friend_number));
			%if different strategy then change
			if strategy(chosen_index)~=strategy(chosen_neighbor)
				%change strategy first
				strategy(chosen_neighbor) = strategy(chosen_index);
				%change fitness second, including neighbor and neighbor's neighbor's fitness
				fitness_table(chosen_neighbor) = fitness_calculate(chosen_neighbor);
				j = 1;
                while con_matrix(chosen_neighbor, j) ~= 0
                    neighbors_friend = con_matrix(chosen_neighbor, j);
                    fitness_table(neighbors_friend) = fitness_calculate(neighbors_friend);
                    j = j + 1;
                end
                flag = 1;
            else
                flag = 0;
			end
			%finish
         end
		%update the proportion of sf adopters
        x(count) = sum(strategy)/N;
        count = count + 1;
    end
    result = x;
end