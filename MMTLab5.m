% Parameters
R = 1;                  % Resistance (Ohms)
C = 0.1;                % Capacitance (Farads)
RC = R * C;             % Time constant (Tau = R * C)
h = 0.01;               % Time step (seconds)
t1 = 0:0.01:0.5;        % Time range for the first interval
t2 = 0.5:0.01:1;        % Time range for the second interval

% Inputs and Initialization
Uin_1 = 1;              % Input voltage during the first interval
Uout1 = zeros(size(t1));% Output voltage array for [0, 0.5]
Uin_2 = 0;              % Input voltage during the second interval
Uout2 = zeros(size(t2));% Output voltage array for [0.5, 1]

% Numerical Solution (First Interval)
for i = 1:length(t1)-1
    Uout1(i+1) = Uout1(i) + (Uin_1 - Uout1(i)) * h / RC;
end

% Numerical Solution (Second Interval)
Uout2(1) = 1; % Initial condition for the second interval
for i = 1:length(t2)-1
    Uout2(i+1) = Uout2(i) + (Uin_2 - Uout2(i)) * h / RC;
end

% Combine Results
t_total = [t1, t2];
Uout_numerical = [Uout1, Uout2];

% Analytical Solution
syms Uout(t)
% First Interval
ode1 = diff(Uout, t) == (Uin_1 - Uout) / RC;
cond1 = Uout(0) == 0;
Uout_analytical_1 = dsolve(ode1, cond1);

% Second Interval
ode2 = diff(Uout, t) == (Uin_2 - Uout) / RC;
cond2 = Uout(0.5) == 1;
Uout_analytical_2 = dsolve(ode2, cond2);

% Evaluate Analytical Solutions
Uout_analytical_1_vals = double(subs(Uout_analytical_1, t, t1));
Uout_analytical_2_vals = double(subs(Uout_analytical_2, t, t2));
Uout_analytical = [Uout_analytical_1_vals, Uout_analytical_2_vals];

% Plotting Results
figure;
plot(t_total, Uout_numerical, 'r', 'DisplayName', 'Numerical Solution (Euler)');
hold on;
plot(t_total, Uout_analytical, 'b--', 'DisplayName', 'Analytical Solution');
xlabel('Time (s)');
ylabel('U_{out}(t)');
title('Comparison of Numerical and Analytical Solutions');
legend;
grid on;
