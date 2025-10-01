% message
x = [0 1 0 0 1 0 1 1 0];

M = 4; % modulation order
fc = 5; % carrier freq
fs = 1000; % sampling freq
t = linspace(0, 1, fs);
s1 = sin(2 * pi * fc * t); % carrier
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

% M-ary ASK
max_level = 4;
min_level = 1;
amplitudes = x_decimal / (M-1) * (max_level - min_level) + min_level;
mASK = kron(amplitudes, s1);

subplot(2, 2, 1);
stairs([x_decimal, 0]);  % one more 0 is added to fully show the array
title("Input sequnce (in decimal)");

subplot(2, 2, 3); plot(mASK);
title("M-ary ASK");

subplot(2, 2, [2, 4]);
scatter(real(amplitudes), imag(amplitudes));
title("Signal constellation"); xlabel("s1(t)")