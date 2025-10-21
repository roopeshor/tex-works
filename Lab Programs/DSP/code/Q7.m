clc; clearvars; close all;
% pass band freqs
fp1 = 0.2;
fp2 = 0.6;
% stop bands
fs1 = [0.15 , 0.25];
fs2 = [0.65 , 0.75];

% transition width (same for both filters)
TW = fp1 - fs1(1);
% As > 55dB, choose blackmann
M = ceil(11  / TW);
n = 0:M-1;
m = n - ceil((M-1) / 2);
% construct 2 BPF filters
BPF1 = fs1(2) * sinc(fs1(2) * m) - (fs1(1) * sinc(fs1(1) * m));
BPF2 = fs2(2) * sinc(fs2(2) * m) - (fs2(1) * sinc(fs2(1) * m));

% corresponding BRF is:
BRF1 = sinc(m) - BPF1;
BRF2 = sinc(m) - BPF2;

window = blackman(M)';
BRF1 = BRF1 .* window;
BRF2 = BRF2 .* window;

% merge filters:
mergedFilter = BRF1 + BRF2;

freqz(mergedFilter);