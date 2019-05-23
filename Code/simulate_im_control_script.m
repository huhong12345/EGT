function mean_2 = simulate_im_control_script(uff, ufn, unn, N, k, alpha, iteration_time)

    simulation_2_result = zeros(10,iteration_time);
    for i = 1:6
        i
%         generate regular graph
% -----------------------------------------------------------
%         graph_sparse = createRandRegGraph(N, k);
%         graph_matrix = full(graph_sparse);
% -----------------------------------------------------------


%       generate scale-free graph
% -----------------------------------------------------------
%         seed = seed_produce(k/2+1);
%         graph_matrix = SFNG(N, k/2, seed);
% -----------------------------------------------------------

%       generate ER graph
% -----------------------------------------------------------
        graph_matrix = ERRandomGraphGenerate(N, k/N);
% -----------------------------------------------------------
       
        graph = graph_change(graph_matrix, N);
        mean_table_2 = zeros(24, iteration_time);
        parfor j = 1: 12
%             j
%             mean_table_2(j,:) = simulate_im_over_regular_graph_with_iru(uff, ufn, unn, graph_matrix, alpha, ir, iteration_time, N);
            mean_table_2(j, :) = simulate_im_over_regular_graph(uff, ufn, unn, graph, alpha, iteration_time, N);
        end
        simulation_2_result(i,:) = mean(mean_table_2);
    end

    mean_2 = mean(simulation_2_result);
%     plot(mean_2);   
end
%F=@(p,H)((p(1)+1)*log(H(:,2))-p(1)*log(1-H(:,2))+log(-H(:,2)-p(1)))/(p(1)*(p(1)+1))+p(2)*exp(-p(3)*H(:,1))/p(3)+p(4);