clc,clear
s=tf('s');
%% 
% This is your system's open loop transfer function. Replace as per your system 
% design.
% 
% $$G\left(s\right)=\frac{1}{\left(2s+1\right)}$$

G= 1/(2*s+1);
%% 
% Design the K to satisfy the steady state error requirements and add integrator 
% to ensure zero steady state error. Reduce the gain if Compensator is not able 
% to achieve the desired phase margin. In some case a Compensator may not be sufficient 
% to achieve the desired phase margin, in that case both lead and lag Compensator 
% will be required.

K=100;
G=K*G*(1/s);
%% 
% Find system margins without Compensator,

margin(G)
% Display the gain and phase margins
[Gm, Pm, Wpc, Wgc] = margin(G);
fprintf('Gain Margin: %.2f dB at Frequency: %.2f rad/s\n', db(Gm), Wpc);
fprintf('Phase Margin: %.2f degrees at Frequency: %.2f rad/s\n', Pm, Wgc);
%%
i=1;
for phi_d = [30,40,45,50,55,60]
    phi_di(i,:)=phi_d;
    phi_m(i,:)=phi_d-Pm+2;
    alpha(i,:) = (1-sind(phi_m(i,:)))/(1+sind(phi_m(i,:)));
%% 
% Automatic $\omega_d$calculation

    alpha_attenuation = 10*log10(alpha(i,:));
    [mag,phase,wout] = bode (G,1e-2:0.01:Wgc*10);
    mag_db=mag2db(mag);
    [~,index] = min(abs(mag_db-alpha_attenuation));
    omega = wout(index);
%% 
% Calculate the Compensator time constant to place the additional phase at $\omega_{d\;}$frequency.
% 
% $$\tau =\frac{1}{\omega_{d\;} \sqrt{\alpha }}$$

    tau(i,:) = 1/(omega*sqrt(alpha(i,:)));
    
    C= (1+tau(i,:)*s)/(1+alpha(i,:)*tau(i,:)*s);
    figure(1)
    margin(G*C)
    hold on
%% 
% The frequency response of the Designed Compensator

    figure(2)
    bode(C)
    hold on
    [gm(i,:),pm(i,:)] = margin(G*C);
    fprintf("Gain Margin = %0.2f, and Phase Margin = %0.2f \n",[db(gm(i,:)),pm(i,:)])
%% 
% Step response of uncompensated closed loop system and compensated closed loop 
% system with the desired phase margins.

    figure(3)
    subplot(2,1,1)
    [y,t]=step(feedback(G*C,1),3);
    plot(t,y)
    hold on
    subplot(2,1,2)
    plot(t,1-y)
    hold on
    i=i+1;
end
legendLabels = arrayfun(@(x) sprintf('\\phi= %.2f', x), pm, 'UniformOutput', false);
[y,t]=step(feedback(G,1),3);
figure(1),legend(legendLabels,Location="bestoutside");

figure(2),legend(legendLabels,Location="bestoutside");
figure(3),subplot(2,1,1), plot(t,y), title("Step Response")
figure(3),subplot(2,1,2), plot(t,1-y),title("Error Plot")
figure(3),subplot(2,1,1)
legendLabels{end+1}='Uncompensated';
legend(legendLabels,Location="northeast")

hold off
%%
PM_uncomensated = ones(size(phi_di))*Pm;
tab=table(phi_di,PM_uncomensated,pm,alpha,tau, ...
    'VariableNames',["PM (Desired)","PM (Actual)", 'PM (Compensated)', "alpha","tau"])
%% Save Figures

figList = findall(0, 'Type', 'figure');

for i = 1:length(figList)
  figure(i);
  set(gcf, 'PaperUnits', 'inches');
  set(gcf, 'PaperPosition', [0 0 7 3.5]);
  saveas(gcf, sprintf('figure%d.png', i));
end