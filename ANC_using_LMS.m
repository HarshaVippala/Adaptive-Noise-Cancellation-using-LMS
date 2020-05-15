%% Initialization
clear all;
close all;
clc;
%% Loading the test signal and normalization of the signal
tic

[d,Fs] = audioread('music.wav'); % Loading of input signal
d = d / rms(d, 1);                % Normalization of the signal

m = length(d);                   % length of the signal
t=(1:m)';
%% Creating Noise(White Gaussian Noise)

reference_signal = wgn(m,1,8); % white gaussian noise with the length of the input signal

%% Designing digital filter

FIR_fil = fir1(12, 0.6);              % Designing a FIR filter for adjusting weigts

u = filter(FIR_fil, 1, reference_signal);        % Filtering the reference signal
%% Addition of noise to the input signal

noised_signal = d + u;    % signal to be filtered

%% LMS ALgorithm for calculating weights

E = LMS(u,m,noised_signal);

%% DISPLAY SNR AND VARIANCE OF INOUT AND OUTPUT SIGNALS

disp(snr(d));  % SNR of Input signal
disp(snr(E));  % SNR of the output signal from filter
disp(var(d));  % Variance of Input signal 
disp(var(E));  % Variance of output signal from filter
%% Plotting of the signals
T=(1:m)';

figure(1);
plot(t,d);
title('Input Signal in time domain'); 
xlabel('Time');
ylabel('Input signal');

figure(2);
plot(t,u);
title('Reference Signal in time domain'); 
xlabel('Time');
ylabel('Reference signal'); 

figure(3);
plot(t,noised_signal);
xlabel('Time');
ylabel('noised_signal');
title('noised_signal in time domain');

figure(4);
plot(T,E);
xlabel('Time');
ylabel('Denoised Signal');
title('Denoised signal in time domain');

figure(5);
freqz(d);
title('Input Signal in frequency domain');

figure(6)
freqz(E);
title('Denoised signal in frequency domain');

toc;
%% Run the commands to hear the noised and Output signals 
%% PLAY SIGNAL + NOISE(noised_signal)
soundsc(noised_signal, Fs)
%% PLAY FILTERED SIGNAL(OUTPUT)
soundsc(E,Fs)

