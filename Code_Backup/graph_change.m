function graph = graph_change(net, n)
   graph = zeros(n,k);
   for i = 1:n
       count = 1;
       for j = 1:n
           if net(i,j) == 1
              graph(i, count) = j;
              count = count + 1;
           end
       end
   end
end