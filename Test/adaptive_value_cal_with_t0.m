function adp=adaptive_value_cal_with_t0(parameter,series)

    % function y = sir_pre(t,x)
    %     y = [-beta1*x(1)*x(2), beta1*x(1)*x(2)-gamma1*x(2),  gamma1*x(2)]';        
    % end
    function dxdt=odeFunFour(t,x)
        w=alpha*(k*(k+3)*(k-2)*(k-2))/((k+1)*(k+1)*(k-1));
        f=U*x;
        fi=x'*f;
        b11 = 0;
        b12 = ((k + 3)*u11 + 3*u12 - 3*u21 - (k + 3)*u22)/((k + 3)*(k - 2));
        b13 = ((k + 3)*u11 + 3*u13 - 3*u31 - (k + 3)*u33)/((k + 3)*(k - 2));
        b14 = ((k + 3)*u11 + 3*u14 - 3*u41 - (k + 3)*u44)/((k + 3)*(k - 2));
        b21 = ((k + 3)*u22 + 3*u21 - 3*u12 - (k + 3)*u11)/((k + 3)*(k - 2));
        b22 = 0;
        b23 = ((k + 3)*u22 + 3*u23 - 3*u32 - (k + 3)*u33)/((k + 3)*(k - 2));
        b24 = ((k + 3)*u22 + 3*u24 - 3*u42 - (k + 3)*u44)/((k + 3)*(k - 2));
        b31 = ((k + 3)*u33 + 3*u31 - 3*u13 - (k + 3)*u11)/((k + 3)*(k - 2));
        b32 = ((k + 3)*u33 + 3*u32 - 3*u23 - (k + 3)*u22)/((k + 3)*(k - 2));
        b33 = 0;
        b34 = ((k + 3)*u33 + 3*u34 - 3*u43 - (k + 3)*u44)/((k + 3)*(k - 2));
        b41 = ((k + 3)*u44 + 3*u41 - 3*u14 - (k + 3)*u11)/((k + 3)*(k - 2));
        b42 = ((k + 3)*u44 + 3*u42 - 3*u24 - (k + 3)*u22)/((k + 3)*(k - 2));
        b43 = ((k + 3)*u44 + 3*u43 - 3*u34 - (k + 3)*u33)/((k + 3)*(k - 2));
        b44 = 0;
        B=[b11,b12,b13,b14;b21,b22,b23,b24;b31,b32,b33,b34;b41,b42,b43,b44];
        g=B*x;
        dxdt=w*[x(1)*(f(1)+g(1)-fi),x(2)*(f(2)+g(2)-fi),x(3)*(f(3)+g(3)-fi),x(4)*(f(4)+g(4)-fi)]';
    end
    % function y = multi_sir(t,x)
    %     y = [-beta1*(x(2)+x(7))*x(1)-beta2*(x(3)+x(6))*x(1), beta1*(x(2)+x(7))*x(1)-gamma1*x(2), beta2*(x(3)+x(6))*x(1)-gamma2*x(3), gamma1*x(2)-alpha2*(x(3)+x(6))*x(4), gamma2*x(3)-alpha1*(x(2)+x(7))*x(5), alpha2*(x(3)+x(6))*x(4)-delta2*x(6), alpha1*(x(2)+x(7))*x(5)-delta1*x(7), delta2*x(6)+delta1*x(7)].';
    % end

    u11 = parameter(1);
    u12= parameter(2);
    u13= parameter(3);
    u14= parameter(4);
    u21 = parameter(5);
    u22= parameter(6);
    u23 = parameter(7);
    u24= parameter(8);
    u31=parameter(9);
    u32=parameter(10);
    u33=parameter(11);
    u34=parameter(12);
    u41=parameter(13);
    u42=parameter(14);
    u43=parameter(15);
    u44=parameter(16);
    k=parameter(17);
    U=[u11,u12,u13,u14;u21,u22,u23,u24;u31,u32,u33,u34;u41,u42,u43,u44];
    alpha=parameter(18);

    %len=lenth(series);

    
    initial=[0,0,0.000372866,0.999];
    len=400;
    %solution = zeros(len,17);
    [t,x]=ode45(@odeFunFour,[1:len],initial) ;  
    I=x;
    %%jia canshu
   % len = length(series);%%series shi sitiao

    %[t, x] = ode45(@sir_pre, [0:tau], [0.99999, 0.00001, 0]);     %æ”?
    % initial_2 = [0.99999*x(tau+1,1), x(tau+1,2), 0.00001*x(tau+1,1),x(tau+1,3), 0, 0, 0, 0];
    % solution(1:tau,1:2) = x(1:tau, 1:2);
    % solution(1:tau,4) = x(1:tau,3);
    % solution(tau+1,:) = initial_2;

    % [t2, x2] = ode45(@multi_sir, [0:len-tau-1], initial_2);
    % solution(tau+1:len,:) = x2;
    % I = solution(:,2)+solution(:,3)+solution(:,6)+solution(:,7);
    % err = 0;
    T=I-series;
    err=norm(T,'fro')
    % for i = 1:len
    %     err = err + (I(i)-series(i))^2;
    % end
    adp = err;
end