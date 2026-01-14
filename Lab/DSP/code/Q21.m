close all; clearvars;
% given system: y(n) − 1.2y(n−1) + 0.8y(n−2) = x(n)
num = 1; den = [1, -1.2, 0.8];

%%% plot zeros and poles
zplane(num, den);

%%% check if system is stable or not
% by checking if all poles lie inside unit circle
system = filt(num, den);
if (abs(pole(system)) < 1)
    disp("stable");
else 
    disp("unstable");
end

%%% compute impulse response
n = 0:50;
impulse = n == 0;
response = filter(num, den, impulse);
figure;
stem(n, response);
title('Impulse Response of the System');
