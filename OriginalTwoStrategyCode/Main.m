%mean_result = simulate_im_control_script(uff, ufn, unn, N, k, alpha, iteration_time);
clear all;clc;
%%parameters setting
N=4039; %The scale of the Graph
%k=10; %The degree of a node
uff=0.6;ufn=0.8;unn=0.4;  %payoff matrix
alpha=0.01;      %weak-connection parameter
iteration_time=400;  
%G_N=10;       %The Repeating Graphs of simulation
S_M=1;       %The Repeating times of simulation on one graph
%U=zeros(4,4);
%Graphth_Result = zeros(1,iteration_time);      %To store the final result
tic
%make i graph results
%for i = 1:G_N
        fprintf('The iteration i of  graph is %d\n',i);
%         graph_sparse = createRandRegGraph(N, k);   %generate a sparse random regular graph     
%         graph_sparse=gather(graph_sparse);       
%         graph_matrix = full(graph_sparse);         %full the graph matrix    
%         graph  = graph_change(graph_matrix, N,k);     
        graph=create_fbgraph(N);
        toc
        Iteration_Results = zeros(S_M, iteration_time);      
        for j = 1: S_M    
            fprintf('The iteration j time is %d\n',j);
            Iteration_Results(j, :) = simulate_im_over_regular_graph(uff,ufn,unn, graph,alpha, iteration_time, N);
            
        end
        Graphth_Result = mean(Iteration_Results);
        toc
%end

   % Final_Results = mean(Graphth_Result);
    %Final_Results=gathar(Final_Results);
    plot(Iteration_Results);
% -----------------------------------------------------------
%       generate scale-free graph
% -----------------------------------------------------------
%         seed = seed_produce(5);
%         graph_matrix = SFNG(N, k, seed);
% -----------------------------------------------------------
%       generate ER graph
% -----------------------------------------------------------
%       graph_matrix = ERRandomGraphGenerate(N, k/N);
% -----------------------------------------------------------  