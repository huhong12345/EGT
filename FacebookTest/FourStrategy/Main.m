clear all;clc;
%%parameters setting%%%%%%%%%%%
N=4039; %The scale of the Graph
alpha=0.01;      %weak-connection parameter
iteration_time=400;  
G_N=3;       %The Repeating Graphs of simulation
S_M=32;       %The Repeating times of simulation on one graph
U=[0.36,0.48,0.48,0.64;
    0.48,0.24,0.64,0.32;
    0.48,0.64,0.24,0.32;
    0.64,0.32,0.32,0.2];
Graphth_Result = zeros(G_N,iteration_time,4);      %To store the final result
tic
%make i graph results
for i = 1:G_N
    fprintf('The iteration i of  graph is %d\n',i);
    graph=create_fbgraph(N);
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