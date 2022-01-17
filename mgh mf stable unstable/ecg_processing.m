clc;
close all; 
clear;

fs = 360;
t=0:(1/fs):10-(1/fs);
f = linspace(0, fs, 3600);
load('mgh002m.mat');

figure(1);

subplot(2, 1, 1);
x = val(:,:);
x = x/1184;
plot(t, x, 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('MGH MF Stable Unstable ECG', 'fontsize', 15);
grid on;

subplot(2, 1, 2);
fftx = abs(fft(x));
plot(f, fftx, 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('FFT of ECG', 'fontsize', 15);
grid on;

figure(2);

subplot(2, 1, 1);
noise_powerline = 0.2*sin(2*pi*50*t);
plot(t, noise_powerline, 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('Powerline Interference', 'fontsize', 15);
grid on;

subplot(2, 1, 2);
plot(f, abs(fft(noise_powerline)), 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('FFT of Powerline interfernece', 'fontsize', 15);
grid on;

figure(3);

subplot(2, 1, 1);
noisy_signal = x + noise_powerline;
plot(t, noisy_signal, 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('Signal affected with Powerline Interference', 'fontsize', 15);
grid on;

subplot(2, 1, 2);
plot(f, abs(fft(noisy_signal)), 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('FFT of Powerline Interference affected signal', 'fontsize', 15);
grid on;

% figure(4);
% x_filtered = filter(butter_lpf, noisy_signal);
% 
% subplot(2, 1, 1);
% plot(t, x_filtered, 'linewidth', 1);
% set(gca, 'fontsize', 13, 'fontweight', 'bold');
% title('Filtered Signal', 'fontsize', 15);
% grid on;
% 
% subplot(2, 1, 2);
% plot(f, abs(fft(x_filtered)), 'linewidth', 1);
% set(gca, 'fontsize', 13, 'fontweight', 'bold');
% title('FFT of Filtered signal', 'fontsize', 15);
% grid on;