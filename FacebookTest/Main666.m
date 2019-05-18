%%Parameters Setting
clear all;clc;
N=4039; %The scale of the Graph
uff=0.6;ufn=0.8;unn=0.4;  %payoff matrix
U=[uff,ufn;ufn,unn];
alpha=0.1;      %weak-connection parameter
iteration_time=400;  
graph=create_fbgraph(N);
S_M=36;       %The Repeating times of simulation on one graph
two_modelresult;
Iteration_Results = zeros(S_M, iteration_time);   
        tic
       parfor j = 1: S_M    
            fprintf('The iteration j time is %d\n',j);
            Iteration_Results(j, :) = simulate_im_over_regular_graph1(U, graph, alpha, iteration_time, N);
        end
        Graphth_Result = mean(Iteration_Results);
        toc
        
uff=0.4;ufn=0.8;unn=0.6;  %payoff matrix
U=[uff,ufn;ufn,unn];

         toc
         Iteration_Results11 = zeros(S_M, iteration_time);      
         parfor j = 1: S_M    
            fprintf('The iteration j time is %d\n',j);
            Iteration_Results11(j, :) = simulate_im_over_regular_graph1(U, graph, alpha, iteration_time, N);
        end
        Graphth_Result11 = mean(Iteration_Results11); 
        toc
        
        ESS111=[ Graphth_Result;Graphth_Result11];
 
        two_modelresult;
        hold on;
        plot(Graphth_Result);
        hold on;
        me;
        hold on;
        plot(Graphth_Result11);
        grid on;
    
        
        
    %Final_Results = mean(Graphth_Result);
 %   plot(Iteration_Results);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%generate scale-free graph%%%%%%%%%%%%%%%%
%seed = seed_produce(5);
%graph_matrix = SFNG(N, k, seed);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%generate ER graph%%%%%%%%%%%%%%%%%%%%
%graph_matrix = ERRandomGraphGenerate(N, k/N);
%%%%8%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 