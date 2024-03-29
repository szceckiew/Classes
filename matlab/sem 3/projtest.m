% The time data
t1 = [0:300:1800]';
%  processed  data
y_obs = [  
18.28
18.87
19.06
19.12
19.64
20.13
20.60
 ];

f = @(a,b,c,x) a.*(1-exp(-(x.*b).^c));
obj_fun = @(params) norm(f(params(1), params(2), params(3),t1)-y_obs);
sol = fminsearch(obj_fun, [y_obs(end),0,1]);
a_sol = sol(1)
b_sol = sol(2)
c_sol = sol(3)
% y_fit = f(a_sol, b_sol,c_sol, t1);

% extrapolation 
t2 = [0:300:1500+2*300]';
y_extra = f(a_sol, b_sol,c_sol, t2);
y_extra(1) = y_obs(1);


figure;
plot(t1, y_obs, '+', 'MarkerSize', 10, 'LineWidth', 2)
hold on
plot(t2, y_extra);grid on
xlabel('time t');
ylabel('y');


