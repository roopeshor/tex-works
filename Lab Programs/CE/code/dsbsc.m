clearvars;
global fs;
fs = 1000;
fm = 3;
fc = 15;
t = linspace(0, 1, fs);

m = sin(2 * pi * fm * t);
c = sin(2 * pi * fc * t);
s = m .* c;

tiledlayout(4, 2);
plot_(t, m, "Message");
plot_(t, s, "DSBSC");

%%% demodulation
v = s .* c;
[b ,a] = butter(2, fm / (fs/ 2));
y = filter(b, a, v);
plot_(t, v, "multiplier output - v");
plot_(t, y, "Demodulated v_o");
function plot_(x, y, name)
    global fs;
    nexttile;
    plot(x, y);
    title(name); xlabel("t")

    nexttile;
    freq = abs(fftshift(fft(y))) / length(y);
    N = length(freq);
    f = (-N/2:N/2-1) * fs / N;
    plot(f, freq);
    xlim([0, 30]); xlabel("f")
    title(name + " (Spectrum)");
end