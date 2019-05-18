%clc;clear all;
%hold on
[t,x]=ode45(@im,[0,400],[0.1,0.9]);
%figure(5)
qqq=x(:,1);
plot(t,qqq);

function y=im(t,x)
U=[0.3,0.8;0.8,0.65];
%U=[Ua(1,1)*Ub,Ua(1,2)*Ub;Ua(2,1)*Ub,Ua(2,2)*Ub];
k=53;
w=0.025*(k*(k+3)*(k-2)*(k-2))/((k+1)*(k+1)*(k-1));
f=U*x;
fi=x'*f;
b=zeros(2,2);
for i=1:2
    for j= 1:2
        b(i,j)=((k+3)*U(i,i)+3*U(i,j)-3*U(j,i)-(k+3)*U(j,j))/((k+3)*(k-2));
    end
end
    g=b*x;
    y=w*[x(1)*(f(1)+g(1)-fi),x(2)*(f(2)+g(2)-fi)]';
    qqqqqq=1;
end