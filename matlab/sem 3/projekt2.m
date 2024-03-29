% The time data
t1 = [0:300:18600]'; 
%  processed  data
y_obs = [         
    0
   3.6216e-01
   2.9813e-01
   5.0805e-01
   4.9338e-01
   5.5928e-01
   6.0894e-01
   6.5506e-01
   6.8876e-01
   7.1773e-01
   7.4284e-01
   7.6433e-01
   7.8448e-01
   7.9912e-01
   8.1484e-01
   8.2950e-01
   8.3760e-01
   8.4707e-01
   8.5767e-01
   8.6299e-01
   8.6862e-01
   8.7433e-01
   8.7879e-01
   8.8736e-01
   8.9152e-01
   8.9903e-01
   9.0343e-01
   9.0984e-01
   9.1344e-01
   9.1615e-01
   9.2046e-01
   9.2313e-01
   9.2640e-01
   9.2992e-01
   9.3134e-01
   9.3242e-01
   9.3616e-01
   9.3986e-01
   9.4201e-01
   9.4145e-01
   9.4434e-01
   9.4252e-01
   9.4131e-01
   9.4249e-01
   9.4283e-01
   9.4395e-01
   9.4355e-01
   9.4690e-01
   9.4919e-01
   9.5255e-01
   9.5626e-01
   9.6282e-01
   9.6283e-01
   9.6672e-01
   9.6439e-01
   9.6887e-01
   9.7099e-01
   9.7529e-01
   9.8034e-01
   9.8302e-01
   9.8494e-01
   9.8828e-01
   9.8769e-01
 ];

f = @(a,b,c,x) a.*(1-exp(-(x.*b).^c));
obj_fun = @(params) norm(f(params(1), params(2), params(3),t1)-y_obs);
sol = fminsearch(obj_fun, [y_obs(end),0,1]);
a_sol = sol(1)
b_sol = sol(2)
c_sol = sol(3)
% y_fit = f(a_sol, b_sol,c_sol, t1);

% extrapolation 
t2 = [0:300:18600+30*300]';
y_extra = f(a_sol, b_sol,c_sol, t2);


figure;
plot(t1, y_obs, '+', 'MarkerSize', 10, 'LineWidth', 2)
hold on
plot(t2, y_extra);grid on
xlabel('time t');
ylabel('y');
