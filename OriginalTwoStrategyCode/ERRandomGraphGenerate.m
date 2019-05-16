function ergraph = ERRandomGraphGenerate(N, p)
    graph = zeros(N, N);
    for i = 1:N;
        for j = i+1:N
            if rand < p
                graph(i,j) = 1;
                graph(j,i) = 1;
            end
        end
    end
    ergraph = graph;
end