%% %%parameters setting
clear all;clc;
N=1000; %The scale of the Graph
k=10; %The degree of a node
uff=0.6;ufn=0.8;unn=0.4;  %payoff matrix
U=[uff,ufn;ufn,unn];
alpha=0.09;      %weak-connection parameter
iteration_time=400;  
G_N=10;       %The Repeating Graphs of simulation
S_M=12;       %The Repeating times of simulation on one graph
%% Experiment Process
Graphth_Result = zeros(G_N,iteration_time);      %To store the final result
tic
%make i graph results
for i = 1:G_N
        fprintf('The iteration i of  graph is %d\n',i);
        graph_sparse = createRandRegGraph(N, k);   %generate a sparse random regular graph
        graph_sparse=gather(graph_sparse);
        graph_matrix = full(graph_sparse);         %full the graph matrix    
        toc
        graph = graph_change(graph_matrix, N,k);
        toc
        Iteration_Results = zeros(S_M, iteration_time);
        toc
       
       parfor j = 1: S_M    
            fprintf('The iteration j time is %d\n',j);
            Iteration_Results(j, :) = simulate_im_over_regular_graph(U, graph, alpha, iteration_time, N,k);
        end
        Graphth_Result(i,:) = mean(Iteration_Results);
end

    Final_Results = mean(Graphth_Result);
    plot(Final_Results);