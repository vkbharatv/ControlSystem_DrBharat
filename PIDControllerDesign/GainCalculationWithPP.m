%% PID Controller Design with Pole Placement Method
% Following is the symbolic math script to calculate the gain of the PID controller using the desired closed loop pole locations, also knows as pole placement method.
clc, clear, clf;
syms s Kp Ki Kd a b p1 p2 p3 K

% Let us assume a systeme Transfer function without the PID controller
G = K / (s ^ 2 + a * s + b);
% The characteristic equation of the closed loop system with PID controller
G_cs = collect((s ^ 2 + a * s + b) * s + K * (Kd * s ^ 2 + Kp * s + Ki), s)

%%
% Now let us assume the desired closed loop pole locations are -p1, -p2, and -p3, that make the desired characteristic equation as follows:

G_des = (s + p1) * (s + p2) * (s + p3);
G_des = collect(G_des, s)
% Equating the coefficients of the characteristic equation of the closed loop system with PID controller and the desired characteristic equation, we get:

eq1 = coeffs(G_cs, s) == coeffs(G_des, s);

% Solving the above equations, we get the values of Kp, Ki, and Kd as follows:
sol = solve(eq1, [Kp, Ki, Kd])
Kp_s = simplify(sol.Kp)
Ki_s = simplify(sol.Ki)
Kd_s = simplify(sol.Kd)

%%
% Example: Let us assume a system with the following transfer function and design a PID controller using pole placement method.
clear s Kp Ki Kd a b p1 p2 p3
s = tf('s');
G = 10 / (s ^ 2 + 10 * s + 2)
[num, den] = tfdata(G);
a = den{1}(2);
b = den{1}(3);
[~, ~, K] = zpkdata(G);
zpk(G)

% Desired closed loop pole locations
omega_n = 3;
p3 = 10 * omega_n;
i = 1;

for eta = 0.5:0.1:1
  p1 = (eta * omega_n + sqrt(1 - eta ^ 2) * omega_n * 1i);
  p2 = (eta * omega_n - sqrt(1 - eta ^ 2) * omega_n * 1i);

  Kp(i, :) = double(subs(Kp_s)); %#ok<*SAGROW>
  Ki(i, :) = double(subs(Ki_s));
  Kd(i, :) = double(subs(Kd_s));
  p1_n(i, :) = p1;
  p2_n(i, :) = p2;
  p3_n(i, :) = p3;
  zeta_n(i, :) = eta;
  C = pid(Kp(i, :), Ki(i, :), Kd(i, :));

  %%
  % Now let us check the step response of the closed loop system with the designed PID controller.
  sys_cl = feedback(C * G, 1);
  figure(1)
  hold on
  step(sys_cl)
  grid on
  %%
  % Now let us check the frequency response of the open loop system with the designed PID controller.
  figure(2)
  hold on
  margin(C * G)
  grid on
  [Gm(i, :), Pm(i, :), Wpc(i, :), Wgc(i, :)] = margin(C * G);
  fprintf('Gain Margin: %.2f dB at Frequency: %.2f rad/s\n', db(Gm(i, :)), Wpc(i, :));
  fprintf('Phase Margin: %.2f degrees at Frequency: %.2f rad/s\n', Pm(i, :), Wgc(i, :));
  fprintf('The closed Loop system for zeta =  %f', zeta_n(i, :))
  display(zpk(feedback(G * C, 1)))
  figure(3), hold on;
  np = nyquistplot(C * G);
  i = i + 1;
end

legendLabels = arrayfun(@(x) sprintf('\\zeta= %.2f', x), zeta_n, 'UniformOutput', false);
figure(1), legend(legendLabels, Location = "best"), hold off;
title('Step Response')
figure(2), legend(legendLabels, Location = "eastoutside"), hold off;
title('Frequency Response');
figure(3), legend(legendLabels, Location = "best"), hold off;
np.XLim = [-1.1, 1.1];
np.YLim = [-1.3, 1.2];
np.Characteristics.AllStabilityMargins.Visible = 'on';
grid("on")
title('Nyquist Plot');
%%
tab = table(zeta_n, [p1_n, p2_n, p3_n], Kp, Ki, Kd, Gm, Pm, Wpc, Wgc, ...
  'VariableNames', {'Damping Ratio', 'Desired Closed Loop Poles', 'Kp', 'Ki', 'Kd', 'GM_dB', 'PM_deg', 'w_gc', 'w_pc'})
