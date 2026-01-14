clc; clearvars; close all;

fs = 1000;
t = 0:1/fs:1;

x = sin(2 * pi * 100 * t) + sin(2 * pi * 800 * t);

x_spec = abs(fftshift(fft(x)));
N = length(x);
f = (-N/2:N/2-1);
%%% plot signals
subplot(2, 1, 1);
plot(t, x); xlabel("t");
xlim([0, 5/100]);
title("sampled signal");

subplot(2, 1, 2);
plot(f, x_spec);
xlim([0, fs/2]);
xlabel("freq");
title("Spectrum of sampled signal");

%%% design filters

% LPF for signal at f = 100Hz
fcl = 100 / (fs / 2);

TW = 0.05 * pi;
M = ceil(11 * pi / TW);
n = 0:M-1;
m = n - ceil((M-1)/2);
w = blackman(M);
hd = fcl * sinc(fcl * m);
hl = hd .* w';
figure;
freqz(hl);
title("Frequency response of LPF");

% filtered output
y100 = filter(hl, 1, x);
    
% a narrow BPF for aliased signal at f_alias = 200Hz
% with passband bandwidth of 40Hz (to get maximum attenuation for other
% signals)
fch = 220 / (fs / 2);
fcl = 180 / (fs / 2);

hd2 = fch * sinc(fch * m) - fcl * sinc(fcl * m);
hb = hd2 .* w';
figure;
freqz(hb);
title("Frequency response of BPF");

% filtered output
y900 = filter(hb, 1, x);

% plot psd of both signal
psd_y100 = (abs(fftshift(fft(y100))) / N) .^ 2; 
psd_y900 = (abs(fftshift(fft(y900))) / N) .^ 2;
f = (-N/2:N/2-1);
figure;

plot(f, 10 * log(psd_y100));
hold on;
plot(f, 10 * log(psd_y900));
xlim([0, fs/2]);
title("PSD of extracted signals");
legend(["PSD of 100Hz signal", "PSD of aliased signal at 200Hz"]);
xlabel("f");