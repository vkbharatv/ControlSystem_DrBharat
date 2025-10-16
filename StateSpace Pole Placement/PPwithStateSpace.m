clc, clear;

A = [1, 0; -1, -1];
B = [0; 1];
C = [0, 1];
D = 0;
sys = ss(A, B, C, D)

%% Transfer function to statespace convision in Observable canonical form

s = tf('s');
G = 0.5 / (s ^ 2 + 2 * s + 1)
sys = ss(G);
sys_can = compreal(sys, 'o');
Q_c = ctrb(sys_can);

if rank(Q_c) == size(A, 1)
  disp('The system is controllable')
else
  disp('The system is not controllable')
end

Q_o = obsv(sys_can);

if rank(Q_o) == size(A, 1)
  disp('The system is observable')
else
  disp('The system is not observable')
end

[A, B, C, D] = ssdata(sys_can);

%% Pole placement

p1 = -1; p2 = -5;
K_1 = place(A, B, [p1 p2]);
A_m = A - B * K_1; % new A matrix with controller
K_2 = -1 / (C * inv(A_m) * B);
B_m = B * K_2; % new B matrix with reference gain
sys_cl = ss(A_m, B_m, C, D); % new closed-loop system
[y, t, x] = step(sys_cl);
figure(1),
plot(t, x)
legend(['state $x_1$'; 'state $x_2$'], 'Interpreter', 'latex')
figure(2),
pzmap(sys_cl) % pole-zero plot

disp("The feedback gain of the system will be")
display(K_1)
display(K_2)
