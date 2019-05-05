function adp=adaptive_value_cal_with_t0(parameter,series)

    function y = sir_pre(t,x)
        y = [-beta1*x(1)*x(2), beta1*x(1)*x(2)-gamma1*x(2),  gamma1*x(2)]';        
    end
    
    function y = multi_sir(t,x)
        y = [-beta1*(x(2)+x(7))*x(1)-beta2*(x(3)+x(6))*x(1), beta1*(x(2)+x(7))*x(1)-gamma1*x(2), beta2*(x(3)+x(6))*x(1)-gamma2*x(3), gamma1*x(2)-alpha2*(x(3)+x(6))*x(4), gamma2*x(3)-alpha1*(x(2)+x(7))*x(5), alpha2*(x(3)+x(6))*x(4)-delta2*x(6), alpha1*(x(2)+x(7))*x(5)-delta1*x(7), delta2*x(6)+delta1*x(7)].';
    end

    beta1 = parameter(1);
    beta2 = parameter(2);
    gamma1 = parameter(3);
    gamma2 = parameter(4);
    alpha1 = parameter(5);
    alpha2 = parameter(6);
    delta1 = parameter(7);
    delta2 = parameter(8);%%jia canshu
    len = length(series);%%series shi sitiao
    solution = zeros(len,8);
    % [t, x] = ode45(@sir_pre, [0:tau], [0.99999, 0.00001, 0]);     %改
    % initial_2 = [0.99999*x(tau+1,1), x(tau+1,2), 0.00001*x(tau+1,1),x(tau+1,3), 0, 0, 0, 0];
    % solution(1:tau,1:2) = x(1:tau, 1:2);
    % solution(1:tau,4) = x(1:tau,3);
    % solution(tau+1,:) = initial_2;
    % [t2, x2] = ode45(@multi_sir, [0:len-tau-1], initial_2);
    % solution(tau+1:len,:) = x2;
    % I = solution(:,2)+solution(:,3)+solution(:,6)+solution(:,7);
    err = 0;
    for i = 1:len
        err = err + (I(i)-series(i))^2;
    end
    adp = err;
end