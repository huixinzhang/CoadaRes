function state = steadyStateAB(A, flag_x0_high_low)
%   iteration_synthetic_M calculates the output for one step
%   of mutulistic dynamic on real networks
%

t0      = 0;
tf      = 100;
%iterate to reach equilibrium state
% options = odeset('Events', @odeTerminateEvent,'RelTol',1e-8,'AbsTol',1e-8);
% [~,~,te,x,~] = ode45(@abundanceEquation, [t0, tf], x0, options, A);

%save ode_A A

%options = odeset('RelTol',1e-4,'AbsTol',1e-4);
options = [];
%[t_TimeSeries,X_TimeSeries] = ode45('abundanceEquation',[t0,tf],x0,options);
if flag_x0_high_low == 1
    [t_TimeSeries,X_TimeSeries] = ode45(@abundanceEquation,[t0,tf],6.*ones(length(A),1),options, A);
else
    [t_TimeSeries,X_TimeSeries] = ode45(@abundanceEquation,[t0,tf],0.001.*ones(length(A),1),options, A);
end 
x = X_TimeSeries(end,:);
state = x';

%% output steady state
% if size(te) > 0
% 	state = x';
% else
% 	state = x0;
% end