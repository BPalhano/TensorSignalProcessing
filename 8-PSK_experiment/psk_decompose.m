close all;
clear;
clc;
% Cleaning all values and figures in MATLAB for a new compilation;

phi1 = [1, exp(1i*pi)];
phi2 = [1, exp(1i*(pi + pi/2))];
phi3 = [1, exp(1i*(pi + pi/4))];
% Generating the already known signals;

phi4 = kron(phi1, phi2);
phi = kron(phi4, phi3);
 % Generating the n-PSK signal;

 signal = reshape(phi, [2 4]);

[U,S1,V] = svd(signal);
phi3_hat = U(:,1)'; % suppose to have sigma_{1} multiplying here.
ni = V(:,1);

ni = reshape(ni, [2 2]);
[U,S2,V] = svd(ni);
phi2_hat = U(:,1)*S2(1,1);
phi1_hat = V(:,1);

% Test sector
phi1_hat = phi1_hat .* sec(pi/4);
phi2_hat = phi2_hat .* sec(pi/4);
phi3_hat = phi3_hat .* sec(pi/4);
% This sec(pi/4) it's like a strechling factor.

rot1 = [cos(3*pi/2), -sin(3*pi/2);sin(3*pi/2), cos(3*pi/2)];
rot2 = [cos(pi), -sin(pi);sin(pi), cos(pi)];

phi2_hat = rot1 * phi2_hat;
phi3_hat = rot2 * phi3_hat';
% and this rot1 and rot2 are rotational matrix to get the true bases of
% tensors.

% Test sector

% Why?

t = tiledlayout(2,2);
% Scatterploting

nexttile
scatter(real(phi1_hat), imag(phi1_hat), 'filled', 'blue');
circleplot(0,0,1);
xlabel("In-Phase")
ylabel("Quadrature")
grid on

nexttile
scatter(real(phi2_hat), imag(phi2_hat), 'filled', 'red');
circleplot(0,0,1);
xlabel("In-Phase")
ylabel("Quadrature")
grid on

nexttile
scatter(real(phi3_hat), imag(phi3_hat), 'filled', 'MarkerFaceColor', '#77AC30');
circleplot(0,0,1);
xlabel("In-Phase")
ylabel("Quadrature")
grid on

nexttile
scatter(real(phi), imag(phi),'filled', 'black')
circleplot(0,0,1);
grid on

xlabel("In-Phase")
ylabel("Quadrature")