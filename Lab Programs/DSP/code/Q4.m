clearvars; close all;

a = -1;
b = 1;
t = linspace(a, b, 1000);
T = b - a;

% input signal
s = @(t) sign(t);

% Reconstruct signal with N harmonics on each side
N = 50;
f_series = zeros(size(t));

% coefficients
c = @(k) 1 / T * integral(@(t) s(t) .* exp(-2j * pi * t * k / T), a, b);

% Fourier series summation
for k = -N:N
    f_series = f_series + c(k) * exp(2j * pi * k * t / T);
end

% Plot the actual and reconstructed signal
hold on;
plot(t, s(t));
plot(t, real(f_series));
xlabel('t');
legend(["Original", "reconstructed with No. of terms = " + N*2]);
grid on;
ylim([-2, 2]);