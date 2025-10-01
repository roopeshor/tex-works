clearvars;
global fs;
fs = 1000;
fm = 3;
fc = 15;
t = linspace(0, 1, fs);

m = 2*sin(2 * pi * fm * t .^2);
c = cos(2 * pi * fc * t);
s1 = m .* c;
s2 = imag(hilbert(m)) .* imag(hilbert(c));
su = s1 - s2;
sl = s1 + s2;

tiledlayout(7, 2);
plot_(t, m, "Message");
plot_(t, s1, "s1");
plot_(t, s2, "s2");
plot_(t, su, "SSBSC - upper");
plot_(t, sl, "SSBSC - lower");

%%% demodulation with lower sideband
v = sl .* c;
[b, a] = butter(5, fm*3 / (fs / 2));
y = filter(b, a, v);
plot_(t, v, "Product - v");
plot_(t, y, "Demodulated");

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
    xlim([-40, 40]); xlabel("f")
    title(name + " (Spectrum)");
end