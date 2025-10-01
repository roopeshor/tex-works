clearvars; close all;

Tb = 1; % symbol period
Eb = 1; % symbol energy
global fs
fs = 100; % freq at which basis functions are sampled
t = linspace(0, Tb, fs);

msgbits = [1 0 1 1 0 1 0];
N = length(msgbits);

% basis functions
fc1 = 5;
fc2 = 8;
s1 = sqrt(2*Eb/Tb) * cos(2*pi*fc1.*t);
s2 = sqrt(2*Eb/Tb) * cos(2*pi*fc1.*t+pi);
s3 = sqrt(2*Eb/Tb) * cos(2*pi*fc2.*t);

msgsampled = kron(msgbits, ones(1, fs));
bask = kron(msgbits, s1);

% "~msgbits" inverts the bitstream
bpsk = kron(msgbits, s1) + kron(~msgbits, s2);
bfsk = kron(msgbits, s1) + kron(~msgbits, s3);

tiledlayout(4, 2);
t = linspace(0, Tb*N, fs*N);
plot_(t, msgsampled, "Message");
plot_(t, bask, "BASK (5Hz)");
plot_(t, bpsk, "BPSK (5Hz)");
plot_(t, bfsk, "BFSK (5Hz & 8Hz)");

function plot_(t, fx, title_)
    global fs;
    nexttile;
    plot(t, fx);

    % just a hack to increase ylimit according to whatever signal is
    k = (max(fx) - min(fx)) * 0.2;
    ylim([min(fx) - k, max(fx) + k]);
    
    title(title_);
    xlabel("t"); ylabel("Amplitude");

    N = length(fx);
    freq = abs(fftshift(fft(fx))) / N;
    f = (-N/2:N/2-1) / N * fs;

    nexttile;
    plot(f, real(freq));
    xlim([0, 12]); xlabel("f");
    title(title_ + " (spectrum)");
end
