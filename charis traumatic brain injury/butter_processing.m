clc;
close all; 
clear;

fs = 50;
t=0:(1/fs):10-(1/fs);
f = linspace(0, fs, 500);
load('charis10m');

figure(1);

subplot(2, 1, 1);
x = val(:,:);
x = x/6081.8245;
plot(t, x, 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('Brain injury ECG', 'fontsize', 15);
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
noise_baseline = 0.2*sin(2*pi*0.5*t);
plot(t, noise_baseline, 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('Baseline Wander', 'fontsize', 15);
xlabel('Time (s)');
ylabel('Amplitude (mV)');
grid on;

subplot(2, 1, 2);
plot(f, abs(fft(noise_baseline)), 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('FFT of Baseline Wander', 'fontsize', 15);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

figure(3);

subplot(2, 1, 1);
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

figure(4);
x_filtered = filter(butter_hpf, baseline_affected_ecg);

subplot(2, 1, 1);
plot(t, x_filtered, 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('Signal with Baseline Wander Removed', 'fontsize', 15);
xlabel('Time (s)');
ylabel('Amplitude (mV)');
grid on;

subplot(2, 1, 2);
plot(f, abs(fft(x_filtered)), 'linewidth', 1);
set(gca, 'fontsize', 13, 'fontweight', 'bold');
title('FFT of Signal with Baseline Wander Removed', 'fontsize', 15);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;