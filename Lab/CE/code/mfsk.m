% message
x = [0 0 1 0 1 0 0 1 1 0 0 1];

M = 8; % modulation order
fc = 5; % base carrier freq
Df = 3; % distance between each frequency

fs = 300; % sampling freq
t = linspace(0, 1, fs);
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

%%%%%%%% M-ary FSK
mFSK = [];
for d = x_decimal
    mFSK = [mFSK, sin(2 * pi * (fc + Df * d) * t)];
end
subplot(2, 1, 1);
stairs([x_decimal, 0]);  % one more 0 is added to fully show the array
title("Input sequnce (in decimal)");

subplot(2, 1, 2); plot(mFSK); title("M-ary FSK")
