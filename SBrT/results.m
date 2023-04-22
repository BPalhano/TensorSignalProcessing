clear; close all; clc;

% symbols per mensagem: 16 symbols;

general_Theoretical_error = @(range, M) 2*qfunc(sqrt(2*db2pow(range))*sin(pi/M));

EbN0dB = -10:0.5:15;
SISO_AWGN_BPSK = [0.200000000000000	0.222958057395144	0.200000000000000	0.221238938053097	0.161787365177196	0.152941176470588	0.136246786632391	0.126550868486352	0.104663212435233	0.0962962962962963	0.0721357850070721	0.0798722044728435	0.0496592015579357	0.0308788598574822	0.0293178519593614	0.0186428038777032	0.00704906703524534	0.00554649265905383	0.00205170291341814	0.000814942791016071	0.000412425557186928	0.000166701118231101	4.89527058118610e-05	1.55970714938563e-05	3.16149591364007e-06	6.05569690897851e-7	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0   0];

SISO_AWGN_QPSK = [0.226373626373626	0.221987315010571	0.224669603524229	0.182481751824818	0.203187250996016	0.178761061946903	0.175257731958763	0.139310344827586	0.131782945736434	0.137466307277628	0.106514994829369	0.105485232067511	0.0733137829912024	0.0656167979002625	0.0418760469011725	0.0323415265200518	0.0304506699147381	0.0233863423760524	0.0196386488609584	0.0158528852251110	0.0106791969243913	0.00685119210742669	0.00590332573499328	0.00368025909023995	0.00204498977505113	0.00110204981265153	0.000673618408643871	0.000362860501908646	0.000170219719614078	0.000114773139412637	4.13980622395027e-05	1.58228913999765e-05	5.8095004387334731331518910156308e-6	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0];

SISO_AWGN_8PSK = [
    ];

SISO_AWGN_16PSK = [
    ];

SISO_AWGN_32PSK = [
    ];

SISO_AWGN_64PSK = [
    ];

% SISO_AWGN_QPSK_RAW = [0.386973180076628	0.409836065573771	0.428571428571429	0.409836065573771	0.405204460966543	0.396226415094340	0.413919413919414	0.371428571428571	0.371428571428571	0.373665480427046	0.364620938628159	0.391634980988593	0.335463258785943	0.351351351351351	0.325301204819277	0.267175572519084	0.286908077994429	0.298245614035088	0.290858725761773	0.243498817966903	0.229357798165138	0.206349206349206	0.206349206349206	0.194029850746269	0.151515151515152	0.149187592319055	0.155279503105590	0.109170305676856	0.0865051903114187	0.0865051903114187	0.0677506775067751	0.0491962981003410	0.0397456279809221	0.0326543808600065	0.0261233019853710	0.0168350168350168	0.0118539592223803	0.00786905886056028	0.00507614213197970	0.00255180157190977	0.00169548999660902	0.000834640937468701	0.000398946780499481	0.000147418698587729	6.80870533829733e-05	2.28154440478613e-05	8.59940760400898e-06	2.85970351737813e-06		5.7719162074548029430222204277081e-7	0 0];

semilogy(EbN0dB, SISO_AWGN_QPSK, 'Color', 'Red'); 
hold on
semilogy(EbN0dB, SISO_AWGN_BPSK, 'Color', 'Green'); 
semilogy(-10:0.5:15, general_Theoretical_error(-10:0.5:15,4), 'Color', 'Blue')
grid on
hold off

xlabel("Eb/N0");
ylabel("BER");
ylim([1e-5 1e0])

title("Bit Error Rate x Eb/N0");
legend({'QPSK-LSKF', 'BPSK-LSKF','Theoretical error for QPSK'})