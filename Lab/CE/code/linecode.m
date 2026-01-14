clearvars;

bits = [0 1 0 0 1 1 0 1 1 1 0 0];
N = length(bits);
Tb = 100;
npnrz = kron(bits, ones(1, Tb));
nprz = kron(bits, [ones(1, Tb/2), zeros(1, Tb/2)]);
pnrz = kron(bits * 2  - 1, ones(1, Tb));
prz = kron(bits * 2  - 1, [ones(1, Tb/2), zeros(1, Tb/2)]);
manch = kron(bits * 2  - 1, [-ones(1, Tb/2), ones(1, Tb/2)]);
bipolar = zeros(1, N);
n = 1;
for i = 1:N
    bipolar(i) = bits(i) * n;
    if (bits(i) == 1)
        n = n * -1;
    end
end
% Differential coding scheme, xnor current bit and previous output
% bits  =     0   1   0   0   1  ...
%            /|  /|  /|  /|  /| 
%           / | / | / | / | / | % xnor
%          /  |/  |/  |/  |/  |
%diffnt = 1   0   0   1   0   0 ...
%         ^
%         ignore this while plotting
% reference bit is 1, if you want 0 as reference bit, use zeros()
diffnt = ones(1, N + 1);
for i = 1:N
    diffnt(i+1) = ~xor(bits(i), diffnt(i));
end

tiledlayout(8, 1);
stairz([bits, 0], "Input");
% put bit stream
for i = 1:length(bits)
    text(i+0.5, 0.5, string(bits(i)), 'FontSize', 10);
end
stairz(npnrz, "NPNRZ");
stairz(nprz, "NPRZ");
stairz(pnrz, "PNRZ");
stairz(prz, "PRZ");
stairz(manch, "Manchester");
stairz([bipolar, 0], "bipolar");
stairz([diffnt(2:end), 0], "Differential"); 

function stairz(bits, title_)
    nexttile;
    stairs(bits);
    title(title_);
    xlim([1 length(bits)])

    % to adjust y limit according to the wave
    d = (max(bits) - min(bits)) * 0.2;
    ylim([min(bits)-d, max(bits)+d]);
end
