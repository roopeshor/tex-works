clearvars; close all;
%%% unknown impulse response
h_true = [0, -0.0134, -0.0115,  0.0157,  0.0344];
n = 0:length(h_true)-1;
alpha = (length(h_true) - 1) / 2;
m = n - alpha;
%%% create white noise input, and its corresponding output
x = randn(1, 5000); 
y = conv(x, h_true);

%%% simulate noisy output by adding some noise to y:
y_clean = conv(x, h_true);

% Create additive white noise to corrupt the output.
v = 0.2 * randn(1, length(y_clean)); % Scaled noise signal

% The final noisy output is what we'll use for estimation.
y = y_clean + v;% here a noise added so that SNR is 20dB

%%% find cross and auto correlations:
Ryx = xcorr(y, x);

%%% find maximum point and its location
[~, peak_index] = max(abs(Ryx));
start_index = peak_index - alpha - 2;
end_index = peak_index + alpha - 2;

h_estimate = Ryx(start_index:end_index);

%%% plot normaized values of h_true and h_estimate

h_estimate_norm = h_estimate / max(abs(h_estimate));
h_true_norm = h_true / max(abs(h_true));
stem(n, h_estimate_norm);
hold on
stem(n, h_true_norm);
legend(["estimate", "true impulse response"])