clc;
close all; 
clear;

fs = 250;
t=0:(1/fs):10-(1/fs);
f = linspace(0, fs, 2500);
load('chf01m');

figure(1);

subplot(2, 1, 1);
x = val(:,:);
x = x/200;
plot(t, x, 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('Congestive Heart Failure ECG', 'fontsize', 15);
xlabel('Time (s)');
ylabel('Amplitude (mV)');
grid on;

subplot(2, 1, 2);
fftx = abs(fft(x));
plot(f, fftx, 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('FFT of ECG', 'fontsize', 15);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

figure(2);

subplot(2, 1, 1);
noise_powerline = 0.27*sin(2*pi*50*t);
plot(t, noise_powerline, 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('Powerline Interference', 'fontsize', 15);
xlabel('Time (s)');
ylabel('Amplitude (mV)');
grid on;

subplot(2, 1, 2);
plot(f, abs(fft(noise_powerline)), 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('FFT of Powerline interfernece', 'fontsize', 15);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

figure(3);

subplot(2, 1, 1);
noisy_signal = x + noise_powerline;
plot(t, noisy_signal, 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('Signal affected with Powerline Interference', 'fontsize', 15);
xlabel('Time (s)');
ylabel('Amplitude (mV)');
grid on;

subplot(2, 1, 2);
plot(f, abs(fft(noisy_signal)), 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('FFT of Powerline Interference affected signal', 'fontsize', 15);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

figure(4);
x_powerline_filtered = filter(cheby2_lpf, noisy_signal);

subplot(2, 1, 1);
plot(t, x_powerline_filtered, 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('Powerline Interference Filtered Signal', 'fontsize', 15);
xlabel('Time (s)');
ylabel('Amplitude (mV)');
grid on;

subplot(2, 1, 2);
plot(f, abs(fft(x_powerline_filtered)), 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('FFT of Powerline Interference Filtered signal', 'fontsize', 15);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

figure(5);
x_baseline_filtered = filter(cheby2_hpf, x_powerline_filtered);

subplot(2, 1, 1);
plot(t, x_baseline_filtered, 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('Baseline Wander Filtered Signal', 'fontsize', 15);
xlabel('Time (s)');
ylabel('Amplitude (mV)');
grid on;

subplot(2, 1, 2);
plot(f, abs(fft(x_baseline_filtered)), 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('FFT of Baseline Wander Filtered signal', 'fontsize', 15);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;