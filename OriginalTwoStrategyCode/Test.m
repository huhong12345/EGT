clear all
A = rand(20000,20000);
tic
A1 = gpuArray(single(A));
[U,S,V] = svd(A1,'econ');
A2 = U*S*V';
A3 = gather(A2);
t = toc
tic
[U1,S1,V1] = svd(A,'econ');
A4 = U1*S1*V1';
t2 = toc
 
error = norm(A3-A4,'fro')
 
tic
A1 = gpuArray(single(A));
[vv,dd] = eig(A1);
t3 = toc