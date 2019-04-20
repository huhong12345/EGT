%mean_result = simulate_im_control_script(uff, ufn, unn, N, k, alpha, iteration_time);
clear all;clc;
%%parameters setting
N=2000; %The scale of the Graph
k=20; %The degree of a node
uff=0.6;ufn=0.8;unn=0.4;  %payoff matrix
alpha=0.1;      %weak-connection parameter
iteration_time=400;  
G_N=1;       %The Repeating Graphs of simulation
S_M=8;       %The Repeating times of simulation on one graph
U=zeros(4,4);
%N=single(N);
%N=gpuArray(N);
% k=gpuArray(k);
% uff=gpuArray(uff);
% ufn=gpuArray(ufn);
% unn=gpuArray(unn);
% alpha=gpuArray(alpha);
% iteration_time=gpuArray(iteration_time);
% G_N=gpuArray(G_N);
% S_M=gpuArray(S_M);


Graphth_Result = zeros(G_N,iteration_time);      %To store the final result
tic
%make i graph results
for i = 1:G_N
        fprintf('The iteration i of  graph is %d\n',i);
        %N=single(N);
        %k=single(k);
        %N=gpuArray(N);
        graph_sparse = createRandRegGraph(N, k);   %generate a sparse random regular graph     
        graph_sparse=gather(graph_sparse);       
        graph_matrix = full(graph_sparse);         %full the graph matrix    
        graph  = graph_change(graph_matrix, N);     
        toc
        Iteration_Results = zeros(S_M, iteration_time);
       
        parfor j = 1: S_M    
            fprintf('The iteration j time is %d\n',j);
            Iteration_Results(j, :) = simulate_im_over_regular_graph(U, alpha, iteration_time, N,k);
            
        end
        Graphth_Result(i,:) = mean(Iteration_Results);
        toc
        %Graphth_Result=gather(Graphth_Result);
end

    Final_Results = mean(Graphth_Result);
    %Final_Results=gathar(Final_Results);
    plot(Final_Results);

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


%mean_table_2(j,:) = simulate_im_over_regular_graph_with_iru(uff, ufn, unn, graph_matrix, alpha, ir, iteration_time, N);