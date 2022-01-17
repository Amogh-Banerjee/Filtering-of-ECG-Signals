clc;
close all; 
clear;

fs = 100;
t=0:(1/fs):10-(1/fs);
f = linspace(0, fs, 1000);
load('a01m');

figure(1);

subplot(2, 1, 1);
x = val(:,:);
x = x/200;
plot(t, x, 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('Apnea ECG', 'fontsize', 15);
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
noise_powerline = 0.2*sin(2*pi*49.9*t);
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
powerline_affected_ecg = x + noise_powerline;
plot(t, powerline_affected_ecg, 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('Signal affected with Powerline Interference', 'fontsize', 15);
xlabel('Time (s)');
ylabel('Amplitude (mV)');
grid on;

subplot(2, 1, 2);
plot(f, abs(fft(powerline_affected_ecg)), 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('FFT of Powerline Interference affected signal', 'fontsize', 15);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

figure(4);
x_filtered = filter(cheby2_lpf, powerline_affected_ecg);

subplot(2, 1, 1);
plot(t, x_filtered, 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('Signal with Powerline Interference filtered', 'fontsize', 15);
xlabel('Time (s)');
ylabel('Amplitude (mV)');
grid on;

subplot(2, 1, 2);
plot(f, abs(fft(x_filtered)), 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('FFT of Filtered signal', 'fontsize', 15);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

figure(5);

subplot(2, 1, 1);
noise_baseline = 0.5*sin(2*pi*0.5*t);
baseline_affected_ecg = x + noise_baseline;
plot(t, baseline_affected_ecg, 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('Signal affected with Baseline Wander', 'fontsize', 15);
xlabel('Time (s)');
ylabel('Amplitude (mV)');
grid on;

subplot(2, 1, 2);
plot(f, abs(fft(baseline_affected_ecg)), 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('FFT of Baseline Wander affected signal', 'fontsize', 15);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

figure(6);
x_filtered = filter(cheby2_hpf, baseline_affected_ecg);

subplot(2, 1, 1);
plot(t, x_filtered, 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('Signal with Baseline Wander filtered', 'fontsize', 15);
xlabel('Time (s)');
ylabel('Amplitude (mV)');
grid on;

subplot(2, 1, 2);
plot(f, abs(fft(x_filtered)), 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('FFT of Filtered signal', 'fontsize', 15);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

