clear;
clc;
close all;

Mod_order = 64;
data = randi([0 Mod_order-1], 1000,1);
txSig = pskmod(data, Mod_order, pi/Mod_order);

ntxSig = awgn(txSig,20);
t = tiledlayout(2,1);

nexttile
scatter(real(txSig), imag(txSig), 'filled', 'blue');
circleplot(0,0,1);
xlabel("In-Phase")
ylabel("Quadrature")
grid on

nexttile
scatter(real(ntxSig), imag(txSig), 'filled','green')
xlabel("In-Phase")
ylabel("Quadrature")
grid on
axis equal

figure;

ray_std = 5.5; % dB
fc = 2.4e9; % 2.4 GHz
v_max = 2/3.6; % 2km/h

lambda = physconst('LightSpeed')/fc;
fd = v_max / lambda; % frequência máxima de doppler

sigma = sqrt(1/2) * 10^(ray_std/20);

t = 0:1e-6:1; % taxa de amostragem


