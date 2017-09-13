clear all, clc, close all

load ir_examples.mat

ts=1/fs;
n=0:ts:(length(h_lspk)*ts)-ts;
L=length(n);
Lfs=fs/L;

figure()
plot(n,h_lspk)
title('h_{lspk}')
xlabel('time in sec')
ylabel('Magnitude in gg')
axis([0 0.01 -0.6 1])
grid on

figure()
subplot(2,2,1)
plot(n,h_lspk)
title('h_{lspk}10ms')
xlabel('time in sec')
ylabel('Magnitude in gg')
axis([0 0.0016 -0.5 0.5])
grid on

g_lspk=h_lspk;
g_lspk=1./h_lspk;

subplot(2,2,2)
plot(n,g_lspk)
title('h_{lspk}')
xlabel('tid i sek')
grid on

G_lspk=1./fft(g_lspk);
H_lspk=fft(h_lspk);

subplot(2,2,3)
semilogx(10*log10(abs(H_lspk)));
title('H_{lspk}')
grid on
subplot(2,2,4)
semilogx(10*log10(abs(G_lspk)))
title('G_{lspk}')
xlabel('frekvens i Hz')
grid on

h_lspk10ms=h_lspk(round(0.001*fs):round(0.011*fs));

%% TF decomposition
close all, clc
%theta=0:0.01:2*pi;
%polar(theta,H_room)
H_lspk10ms=fft(h_lspk10ms);
G_lspk10ms=1./H_lspk10ms;

%f10ms=1:ts*length(h_room10ms):length(h_room10ms);
f=1:fs/length(G_lspk):fs;
f10ms=1:fs/length(G_lspk10ms):fs;

subplot(2,1,1)
semilogx(f,10*log10(abs(G_lspk)))
title('G_{lspk}')
xlabel('Frekvens i Hz')
ylabel('Magnitude in dB')
grid on
subplot(2,1,2)
semilogx(f10ms,10*log10(abs(G_lspk10ms)))
title('G_{lspk10ms}')
xlabel('Frekvens i Hz')
ylabel('Magnitude in dB')
grid on

%fvtool(H_room10ms)

% L=length(h_room10ms);
% f=fs*((0:L/2)/L);
% P2 = abs(H_room10ms/L);
% P1 = P2(1:(L/2)+1);
% P1(2:end-1) = 2*P1(2:end-1);
% figure()
% semilogx(f,P1)
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')
% grid on

%fvtool(H_room)



%% Opsplitning i minimumsfasedel og allpasled
close all, clc

akser=[100 fs 10 40]
H_lspk=fft(h_lspk);
% hatH_room=log(H_room);
% hath_room=ifft(hatH_room);

[I_mph,h_mph]=rceps(h_lspk);

 H_lspk10ms=fft(h_lspk10ms);
% hatH_room10ms=log(H_room10ms);
% hath_room10ms=ifft(hatH_room10ms);

[I_mph10ms,h_mph10ms]=rceps(h_lspk10ms);


figure()
plot(h_mph,'b')
hold on
plot(h_lspk,'r')

%fvtool(h_mph10ms)

%figure()
%plot(abs(1./H_mph10ms))

%soundsc(h_room,fs)
%pause(1)
%soundsc(h_mph, fs)

H_mph10ms=fft(h_mph10ms);
G_mph10ms=1./H_mph10ms;

H_mph=fft(h_mph);
G_mph=1./H_mph;

figure()
subplot(2,1,1)
semilogx(f10ms,10*log10(abs(G_mph10ms)))
title('G_{mph10ms}')
axis(akser)
grid on
subplot(2,1,2)
semilogx(f,10*log10(abs(G_mph)))
title('G_{mph}')
axis(akser)
grid on

figure()
subplot(2,1,1)
semilogx(f10ms,10*log10(abs(G_mph10ms)))
title('G_{mph10ms}')
axis(akser)
grid on
subplot(2,1,2)
semilogx(f10ms,10*log10(abs(G_lspk10ms)))
title('G_{lspk10ms}')
axis(akser)
grid on
% L=length(h_mph10ms);
% f=fs*((0:L));

% figure()
% semilogx(f,10*log10(abs(H_mph10ms)))
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')
% grid on

figure()
subplot(1,3,1)
polar(((h_lspk10ms)),'o')
title('All phase part')
subplot(1,3,2)
polar(((h_mph10ms)),'o')
title('Minimum phase part')
subplot(1,3,3)
polar(((I_mph10ms)),'o')
title('Allpass part')

G_mphpol=cart2pol(abs(h_mph),f);

%figure()
%polar(G_mphpol)

%% Regularisation
close all, clc
rho1=15;
rho2=5;
G_lspk10msreg=(1+rho1)./(H_lspk10ms+rho2);

figure()
subplot(2,1,1)
semilogx(f10ms,10*log10(abs(G_lspk10msreg)))
title('G_{lspk10msreg}')
%axis(akser)
grid on
subplot(2,1,2)
semilogx(f10ms,10*log10(abs(G_lspk10ms)))
title('G_{lspk10ms}')
axis(akser)
grid on

%% LPC exess phase
close all, clc
order=4;
[a4,gain]=lpc(h_lspk10ms,4);
akser=[100 fs 15 55]

G_lspk10msLPC=filter([0 -a4(2:end)],1,G_lspk10ms);
figure()
semilogx(f10ms,10*log10(abs(G_lspk10msLPC)),'--r')
hold on
grid on
title('LPC order=4')
semilogx(f10ms,10*log10(abs(G_lspk10ms)),'b')
legend('Raw invers filter','LPC estimated filter')
axis(akser)


[a12,gain]=lpc(h_lspk,12);

G_lspk10msLPC=filter([0 -a12(2:end)],1,G_lspk10ms);
figure()
semilogx(f10ms,10*log10(abs(G_lspk10msLPC)),'--r')
hold on
grid on
title('LPC order=12')
semilogx(f10ms,10*log10(abs(G_lspk10ms)),'b')
axis(akser)
legend('Raw invers filter','LPC estimated filter')



%% Hilbert transformation
XR=hilbert(h_room);
figure()
semilogx(10*log10(abs(XR)))