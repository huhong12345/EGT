function graph=create_fbgraph(N)
load('fb.mat');
edge=88234;
gfb=zeros(N,N);
for q=1:edge    %create adjacency matrix
     gfb(fb(q,1),fb(q,2))=1; 
     gfb(fb(q,2),fb(q,1))=1;
end
K=sum(gfb,2);
K=K';
kmeans=mean(K);
kmax=max(K);
friend_list=zeros(N,kmax);
for q=1:N
      friend_listtemp = [];
      for l=1:N
          if gfb(q,l)~=0
          friend_listtemp=[friend_listtemp,l];
          end
      end
      for m=1:K(q)
           friend_list(q,m)=friend_listtemp(m);
      end
end
graph=friend_list;