clc, clear;

A = [1, 0; -1, -1];
B = [0; 1];
C = [0, 1];
D = 0;
sys = ss(A, B, C, D)

%% Transfer function to statespace convision in observable canonical form

s = tf('s');
G = 0.5 / (s ^ 2 + 2 * s + 1)
sys = ss(G);
sys_can = canon(sys, 'companion');
[A_n, B_n, C_n, D_n] = ssdata(sys_can);
A = A_n'
B = C_n'
C = B_n'
D = D_n

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
