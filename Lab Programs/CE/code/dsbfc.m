clearvars; % clears all variables
% to make a variable accessible even inside a function
% it has to be declared as global
global fs;
fs = 1000; % sampling frequency
fm = 3; % message frequency
fc = 15; % Carrier frequency
t = linspace(0, 1, fs);
k = 1; % modulatoin index
m = sin(2 * pi * fm * t); % message
c = sin(2 * pi * fc * t); % carrier
s = (1 + k * m) .* c; % modulated wave

tiledlayout(5, 2);
plot_sig_fft(t, m, "Message");
plot_sig_fft(t, c, "Carrier (15Hz)");
plot_sig_fft(t, s, "DSBFC");

%%% demodulation
sq = s .^ 2;
[b, a] = butter(2, fm / (fs / 2)); % 2nd order low pass filter with cut off fm
y = filter(b, a, sq);
y = y - mean(y); % remove DC component by subtracting avg value
plot_sig_fft(t, sq, "Squared modulated wave");
plot_sig_fft(t, y, "Demodulated");
function plot_sig_fft(x, y, name)
    % plots a signal y and its fourier transform
    global fs;
    nexttile;
    plot(x, y);
    title(name); xlabel("t")

    nexttile;
    N = length(y);
    freq = abs(fftshift(fft(y))) / N;
    f = (-N / 2:N / 2 - 1) * fs / N;
    plot(f, freq);
    xlim([0, 30]); xlabel("f")
    title(name + " (Spectrum)");
end