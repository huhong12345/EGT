clear all;clc;
%%parameters setting%%%%%%%%%%%
N=2000; %The scale of the Graph
k=20; %The degree of a node
alpha=0.01;      %weak-connection parameter
iteration_time=1000;  
G_N=20;       %The Repeating Graphs of simulation
S_M=32;       %The Repeating times of simulation on one graph
U=[0.4,0.48,0.48,0.64;
    0.48,0.24,0.64,0.32;
    0.48,0.64,0.24,0.32;
    0.64,0.32,0.32,0.2];

Graphth_Result = zeros(G_N,iteration_time,4);      %To store the final result
tic
%make i graph results
for i = 1:G_N
    fprintf('The iteration i of  graph is %d\n',i);
%     graph_sparse = createRandRegGraph(N, k);   %generate a sparse random regular graph
%     
%     toc
%     graph_sparse=gather(graph_sparse);   
%     graph_matrix = full(graph_sparse);         %full the graph matrix  
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
    
   % [aaa,bbb]=size(graph);
    KKK=zeros(N,1);
    for a=1:N
        for b=1:N
         if(graph(a,b)>0)
             KKK(a)=KKK(a)+1;
         end
        end
    end
    MaxK=max(KKK);
    graph=graph(:,1:MaxK);
    Iteration_Results = zeros(S_M,iteration_time,4);
    toc
    parfor j = 1: S_M    
        fprintf('The iteration j time is %d\n',j);
        Iteration_Results(j,:,:) = FourStratery_simulate_im_over_regular_graph(U,graph, alpha, iteration_time, N,KKK);
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