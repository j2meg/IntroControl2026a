clearvars;
clc;
close all;
%% --------------------------------------------------------+
%% - Root locus of the characterisc equation 1+kG(s)H(s)=0 |
%%   Control system with arbitrary feedback                |
%% - Open loop TF                               |
%%   G(s)H(s)=1/(s+1)(s+2)(s+3)=1/(6 + 11 s + 6 s^2 + s^3) |
%% - s are the solutions when solve(1+k*GH,s)              |
%%   s_1=-1,s_2=-2, s_3=-3                                 |
%% --------------------------------------------------------+
%% Code for responses while varying k                      |
%%---------------------------------------------------------+
figure('Position',[1,1,1200,585])

set(gcf,'color','w');
subplot(1,2,1);
title({'                1';'Root Locus -----------------';'                     (s+1)(s+2)(s+3)'}, 'Color', 'k')
hold on
grid on
xlabel('Re')
ylabel('Im')
xline(0, 'k--', 'LineWidth',1.5)  % vertical
yline(0, 'k--', 'LineWidth',1.5)  % horizontal
%% Open loop poles
plot(-1,0,'rx','LineWidth',4) % 1st pole
plot(-2,0,'rx','LineWidth',4) % 2nd pole
plot(-3,0,'rx','LineWidth',4) % 3rd pole
axis([-10 4 -6 6])

subplot(1,2,2);
title('System step response', 'Color', 'k')
hold on
grid on
xlabel('Time')
ylabel('y')
%%------- Iterative plot of the poles position.
pause(1)
for k=0:0.5:61 %% 122 samples of k from 0 to 61 separed by 0.5.
    %% 1+kG(s)H(s)= s^3+6s^2+11s+k+6 Characteristic polinomy
    %% Its coeficients are [1 6 11 k+6]
    r = roots([1 6 11 k+6]); % Plot the roots of the characteristic polynomial varying k
    subplot(1,2,1);
    plot(real(r),imag(r),'b.','LineWidth',2)
    %% display gain legend
    gain = num2str(k);
    kval = strcat('K= ',gain);
    leg = text(-2,1,kval,'HorizontalAlignment','right','FontSize', 16);
    %% Plot unitary step response with the specified gain
    subplot(1,2,2);
    sys=tf(1,[1 6 11 k+6]);
    [y,tOut] = step(sys,10);
    plot(tOut,y,'k');

    pause(0.1)
    delete(leg)
end
%% MATLAB equivalent root locus
figure(2)
rlocus(tf(1,[1 6 11 6]));
