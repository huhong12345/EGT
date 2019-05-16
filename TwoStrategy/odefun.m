function dxdt=odefun(t,x,k)
U=[0.6,0.8;0.8,0.4];
w=0.1*(k*(k+3)*(k-2)*(k-2))/((k+1)*(k+1)*(k-1));
f=U*x;
fi=x'*f;
b=zeros(2,2);
    for i=1:2
        for j= 1:2
        b(i,j)=((k+3)*U(i,i)+3*U(i,j)-3*U(j,i)-(k+3)*U(j,j))/((k+3)*(k-2));
        end
    end
    g=b*x;
    dxdt=w*[x(1)*(f(1)+g(1)-fi),x(2)*(f(2)+g(2)-fi)]';
    qqqqqq=1;
end