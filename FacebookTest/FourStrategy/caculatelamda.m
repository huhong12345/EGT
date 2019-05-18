%y=im(t,x)
clc;clear all;
Ua=[0.6,0.8;0.8,0.4];
Ub=[0.6,0.8;0.8,0.4];
U=[Ua(1,1)*Ub,Ua(1,2)*Ub;Ua(2,1)*Ub,Ua(2,2)*Ub];
k=20;
w=0.1;
alpha=w*(k*(k+3)*(k-2)*(k-2))/(k+1)*(k+1)*(k-1);
syms x1 x2 x3 x4;
x=[x1 x2 x3 x4]';
f=U*x;
fi=x'*f;
b=zeros(4,4);
for i=1:4
    for j= 1:4
        b(i,j)=((k+3)*U(i,i)+3*U(i,j)-3*U(j,i)-(k+3)*U(j,j))/((k+3)*(k-2));
    end
end
g=b*x;
y=[x(1)*(f(1)+g(1)-fi),x(2)*(f(2)+g(2)-fi),x(3)*(f(3)+g(3)-fi),x(4)*(f(4)+g(4)-fi)]';
J=jacobian([y(1);y(2);y(3);y(4)],[x1;x2;x3;x4]);
%eqns=[y(1)==0,y(2)==0,y(3)==0,y(4)==0];
