R = 1;           
C = 0.1;        
RC = R * C;      
h = 0.01;         
t1 = 0:0.01:0.5; 
t2 = 0.5:0.01:1; 


Uin_1 = 1;          
Uout1 = zeros(size(t1)); 
Uin_2 = 0;    
Uout2 = zeros(size(t2)); 


for i = 1:length(t1)-1
    Uout1(i+1) = Uout1(i) + (Uin_1 - Uout1(i)) * h / RC;
end

Uout2(1) = 1;
for i = 1:length(t2)-1
    Uout2(i+1) = Uout2(i) + (Uin_2 - Uout2(i)) * h / RC;
end


t_total = [t1, t2];
Uout_numerical = [Uout1, Uout2];


syms Uout(t)
ode1 = diff(Uout, t) == (Uin_1 - Uout) / RC;
cond1 = Uout(0) == 0;
Uout_analytical_1 = dsolve(ode1, cond1);


ode2 = diff(Uout, t) == (Uin_2 - Uout) / RC;
cond2 = Uout(0.5) == 1;
Uout_analytical_2 = dsolve(ode2, cond2);

Uout_analytical_1_vals = double(subs(Uout_analytical_1, t, t1));
Uout_analytical_2_vals = double(subs(Uout_analytical_2, t, t2));
Uout_analytical = [Uout_analytical_1_vals, Uout_analytical_2_vals];

figure;
plot(t_total, Uout_numerical, 'r', 'DisplayName', 'Numerical Solution (Euler)');
hold on;
plot(t_total, Uout_analytical, 'b--', 'DisplayName', 'Analytical Solution');
xlabel('Time (s)');
ylabel('U_{out}(t)');
title('Comparison of Numerical and Analytical Solutions');
legend;
grid on;
