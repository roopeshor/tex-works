clearvars; 

global fs;
fs = 10000;
fc = 20;
Ac = 2;
fm = 2;
t = 0:1/fs:2;

msg = sin(2 * pi * fm * t) + sin(2 * pi * 2*fm * t);

fmax = 2*fm;

intg = cumsum(msg) / fs;
mpeak = (max(msg) - min(msg))/2;
kf = .1 * fmax / mpeak; % narrow band β = .1
nbfm = Ac * cos(2 * pi * fc * t + 2*pi*kf * intg);

kf = 3 * fmax / mpeak; % wide band β = 3
wbfm = Ac * cos(2 * pi * fc * t + 2*pi*kf * intg);

tiledlayout(5, 2);
plot_(t, msg, "Message");
plot_(t, intg, "Message integrated");
plot_(t, nbfm, "NBFM \beta = .1");
plot_(t, wbfm, "WBFM \beta = 3");

%%% demodulation
z = hilbert(wbfm);
phase = unwrap(angle(z));
demod = diff(phase - 2*pi*fc * t);
plot_(t, [0, demod], "Demodulated WBFM");
function plot_(x, y, title_)
    % plots y and its fourier transform
    global fs;
    nexttile;
    plot(x, y);
    xlim([min(x) max(x)])
    title(title_)

    nexttile;
    N = length(y);
    freq = abs(fftshift(fft(y))) / N;
    f = (-N/2:N/2-1) * fs / N;
    plot(f, freq);
    title(title_ + " (Spectrum)")
    xlim([0 40])
end
