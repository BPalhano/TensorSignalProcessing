clear;
clc;
close all;

% Range de SNR a ser percorrido
EbN0dB = -20:0.5:0;
% SISO AWGN System

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bits = 1e2; % n° de bits na transmissão
Mod_order = 4; % ordem da modulação
data = randi([0 Mod_order-1],bits, 1); % gero o vetor de bits
txSig_tot = pskmod(data, Mod_order, pi/Mod_order); % uso a função de mod. psk

% Variáveis auxiliares
act_error = 0;  % n° de erros atual na potência de transmissão
symbols = bits; % n° de bits transmitidos
counter = 1; % contador auxiliar
spec_error = 1e6; % n° de erros esperados
errors = zeros(size(EbN0dB)); % vetor de erros por potência de transmissão

general_Theoretical_error = @(range, M) 2*qfunc(sqrt(2*range)*sin(pi/M));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tx1 = txSig_tot(1:bits/2,:); % vetor auxiliar
tx2 = txSig_tot(bits/2+1:end,:); % vetor auxiliar

txSig = kron(tx1, tx2); % símbolos de transmissão

for i = EbN0dB
    
    disp("Actual SNR:")
    disp(i)

    while act_error < spec_error
            
        % Adiciono ruido branco no sinal transmitido
        sigma = 1 / (10^(i/10));
        N = sqrt(sigma/2)*(randn(size(txSig)) + 1i*randn(size(txSig)));

        y = txSig + N;
            
        % Estimo os vetores de símbolos
        [rx2,rx1] = norm_lskf(reshape(y, [bits/2 bits/2]), tx1(1,1), tx2(1,1));

        % Recomponho os vetores e aplico o decisor para BPSK:
        rxSig = [rx1' rx2'];
        rxSig_tot = pskdemod(rxSig, Mod_order);

        % Armazeno a quantidade de erros e de símbolos transmitidos
        act_error = act_error + biterr(data, rxSig_tot');
        symbols = symbols + bits;
        
        % Condição de parada secundária (saturação

        
        disp("number of erros")
        disp(act_error)

    end

    % Redefino como zero o contador do laço
    

    % Armazeno o erro para a SNR atual
    errors(counter) = act_error / (act_error + symbols);
    act_error = 0;
    % Redefino como zero a quantidade de símbolos transmitidos
    symbols = 0;

    % Adiciono um ao contador auxiliar
    counter = counter + 1;
        
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot do erro encontrado
semilogy(EbN0dB, errors, 'Color', 'Red'); 
hold on
semilogy(EbN0dB, qfunc(sqrt(2*db2pow(EbN0dB))), 'Color', 'Blue')
hold off

xlabel("Eb/N0");
ylabel("BER");

title("Bit Error Rate x Eb/N0");
legend({'LSKF', 'Theoretical error'})

