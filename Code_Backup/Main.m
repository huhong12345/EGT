clear all;clc;
%%parameters setting%%%%%%%%%%%
N=1000; %The scale of the Graph
k=20; %The degree of a node
alpha=0.1;      %weak-connection parameter
iteration_time=400;  
G_N=10;       %The Repeating Graphs of simulation
S_M=12;       %The Repeating times of simulation on one graph
Ua=[0.6,0.8;0.8,0.4];
Ub=[0.6,0.8;0.8,0.4];
%U=[];         %4*4 payoff matrix!!!!!!!!!!!!!!!!!!!!!!
U=[Ua(1,1)*Ub,Ua(1,2)*Ub;Ua(2,1)*Ub,Ua(2,2)*Ub];

Graphth_Result = zeros(G_N,iteration_time,4);      %To store the final result
tic
%make i graph results
for i = 1:G_N
    fprintf('The iteration i of  graph is %d\n',i);
    graph_sparse = createRandRegGraph(N, k);   %generate a sparse random regular graph     
    toc
    graph_sparse=gather(graph_sparse);   
    graph_matrix = full(graph_sparse);         %full the graph matrix    
    graph = graph_change(graph_matrix, N,k);
    Iteration_Results = zeros(S_M,iteration_time,4);
    toc
    parfor j = 1: S_M    
        fprintf('The iteration j time is %d\n',j);
        Iteration_Results(j,:,:) = FourStratery_simulate_im_over_regular_graph(U,graph, alpha, iteration_time, N,k);
    end
    Graphth_Result(i,:,:) = mean(Iteration_Results,1);          %第i个图，跑了S_M遍，
    toc
    %Graphth_Result=gather(Graphth_Result);
end

    Final_Results = mean(Graphth_Result,1);
    result = zeros(iteration_time, 4);
    result(:, :) = Final_Results(1, : , :);
    %Final_Results=gathar(Final_Results);
    plot(result);