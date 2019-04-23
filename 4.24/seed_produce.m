function seed = seed_produce(n)
    sub_graph = ones(n,n);
    for i = 1:n
        sub_graph(i,i) = 0;
    end
    seed = sub_graph;
end