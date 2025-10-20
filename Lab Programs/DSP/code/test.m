x = randi([0, 1], 1, 1000);
xn_1 = [x(2:end), 0];
subplot(2, 1, 1); stem(abs(fftshift(fft(x))));
subplot(2, 1, 2); stem(abs(fftshift(fft(xn_1))));