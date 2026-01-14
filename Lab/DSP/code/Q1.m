clearvars; close all;

% given signal
n = 0:100;
x = cos(0.1 * pi * n) + 0.5*sin(0.8 * pi * n);

%%% design LPF
wp = 0.2*pi;
ws = 0.5*pi;
TW = (ws - wp);
fc = (ws + wp)/2/pi;

% As = 60dB; so use blackman which has As = 74dB
M = ceil(11 * pi / TW);
m = 0:M-1;
m = m - ceil((M-1)/2);
w = blackman(M);

hd = fc * sinc(fc * m);
h = hd .* w'; % required filter

%%% Filter the input signal
y = filter(h, 1, x);

tiledlayout(2, 1);
nexttile; plot(n, x); title("input x(n)");
nexttile; plot(n, y); title("Filtered output y(n)");
% plot frequency responses and spectrums
figure; freqz(h);
figure; freqz(x);
figure; freqz(y);
