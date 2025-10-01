clc; clearvars; close all;

global fs; % sampling frequency
fs = 10000;

fm = 5;
fc = 100;
Ac = 5;
t = 0:1/fs:.6;
carrier = Ac * (sin(2 * pi * fc * t) > 0);
msg = .5 * sin(2 * pi * fm * t) + sin(2 * pi * 3*fm * t);

pam = carrier .* msg;

tiledlayout(4, 2);
plot_(t, msg, "Message");
plot_(t, carrier, "carrier");
plot_(t, pam, "PAM");

%%% demodulation
% a little more than highest frequency present in the message
% but far less than carrier frequency
fcutoff = 4*fm;
[b, a] = butter(5, fcutoff / (fs/2));
y = filter(b, a, pam);

plot_(t, y, "Demodulated wave");

function plot_(x, y, name)
    % plots y and its fourier transform
    global fs;

    nexttile;
    plot(x, y);
    xlabel("t");
    title(name)

    nexttile;
    N = length(y);
    freq = abs(fftshift(fft(y))) / N;
    f = (-N/2:N/2-1) * fs / N;
    plot(f, freq);
    title(name + " (Spectrum)")
    xlim([0 400])
    xlabel("f");
end
