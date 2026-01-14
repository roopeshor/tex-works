% message
x = [0 0 0 1 1 1 1 0 0 0 ];

M = 4; % modulation order
fc = 5; % carrier freq
fs = 10000; %sampling freq
t = 0:1/fs:1;
% group each bit to form a decimal number
n = log2(M); % number of bits to group

if mod(length(x), n) ~= 0
    % if length of sequence is not multiple of n, add some zeros
    x = [x, zeros(1, n - mod(length(x), n))];
end

% length of sequence when converted to decimal
seqLength = length(x)/n;
x_decimal = zeros(1, seqLength);
for i=0:seqLength-1
    bitgroup = x((i * n + 1):(i * n + n));
    x_decimal(i+1) = bi2de(bitgroup, "left-msb");
end

%%%%%%%% M-ary psk
phases = exp(1j * (2 * pi * x_decimal / M + pi/M));
carrier= exp(1j * 2 * pi *  fc * t);
% This generates sequence of carriers that has some phase shift described
% in `phases` array
mPSK = kron(phases, carrier);

subplot(2, 2, 1);
stairs([x_decimal, 0]);  % one more 0 is added to fully show the array
title("Input sequnce (in decimal)");
xlim([1, seqLength+1]);

subplot(2, 2, 3);
t = linspace(0, seqLength, length(mPSK));
plot(t, imag(mPSK));
title("M-ary PSK");

subplot(2, 2, [2, 4]);
scatter(real(phases), imag(phases));
title("Signal constellation");
xlabel("s1(t)"); ylabel("s2(t)");
axis([-1.5, 1.5, -1.5, 1.5]);