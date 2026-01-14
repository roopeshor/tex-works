clc; clearvars; close all;

periods = 50; % number of periods
T = 200; % number of samples in a time period
t = 0:1/T:periods;

% signal
s = sin(2 * pi * t) + sin(4 * pi * t);

% add some noise
noise = randn(size(t)); 
s_noisy = s + noise;

% plot signal
subplot(2, 1, 1);
plot(t, s);
xlim([0, 3]); % just show 3 periods
title("original signal");
xlabel("t");

subplot(2, 1, 2);
plot(t, s_noisy);
xlim([0, 3]);
title("Noisy signal");
xlabel("t");

%%% Autocorrelation
[Rxx, lags] = xcorr(s_noisy, s_noisy);

figure;
subplot(2, 1, 1);
plot(lags, Rxx);
xlim([-T*2, T*2]); % to show few periods around central part
title("Autocorrelation of noisy signal");
xlabel("Lags (k)");

%%% notice that autocorrelation is periodic with sample period 200
%%% So we slice noisy signal into segments of length 200
%%% and average all of them

% estimated period of signal
T_est = 200;
no_of_segments = floor(length(s_noisy) / T_est);

% take (T_est * no of segments) points from signal
s_new = s_noisy(1:T_est*no_of_segments);

% reshape to a matrix: cols = T_est, rows = no of segments
s_slices = reshape(s_new, T_est, no_of_segments);

% average along row to get estimate of the signal
s_est = mean(s_slices, 2);

t_1peroid = (1:T_est) / T_est;
subplot(2, 1, 2);
plot(t_1peroid, s_est);
hold on;
plot(t_1peroid, s(1:T_est));
xlabel("t");
title("Original and extracted signal");
legend(["Extracted signal", "Original signal"])