clearvars; close all;

% create a random symbol sequene & modulate it
samples = 100000;
qx = randi([0, 3], 1, samples); % for qpsk
bx = randi([0, 1], 1, samples); % for bpsk

qpsk = pskmod(qx, 4);
bpsk = pskmod(bx, 2);
q_ber = [];
b_ber = [];

for snr = 0:100
    % pass psk to a noisy channel with a particular snr
    q_ch_output = awgn(qpsk, snr);
    b_ch_output = awgn(bpsk, snr);
    q_demod = pskdemod(q_ch_output, 4);
    b_demod = pskdemod(b_ch_output, 2);

    % Calculates BER by counting no. of instances
    % where demodulated output != original input
    be = 10*log10(sum(qx ~= q_demod) / samples);
    q_ber = [q_ber, be];
    be = 10*log10(sum(bx ~= b_demod) / samples);
    b_ber = [b_ber, be];
end
subplot(1, 2, 1); hold on;
plot(0:100, q_ber);
plot(0:100, b_ber);
legend("QPSK", "BPSK");
xlabel("SNR");
ylabel("BER (10*log)")
title("BER vs SNR");

subplot(1, 2, 2); hold on;
scatter(real(qpsk), imag(qpsk), "o");
scatter(real(bpsk), imag(bpsk), "x");
legend("QPSK", "BPSK");
title("Signal constellation");
axis([-2, 2, -2, 2]);