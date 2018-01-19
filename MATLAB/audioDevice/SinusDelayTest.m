clc, close all, clear all
% Setting up ASIO driver
fs=48000;

playchan=[1 7];     
recchan=[1:2]; 
samplescount=5;     %Recordingtime in sec
driver=asiostrm('getdriver',0);
asiostrm('setdriver', driver);
[playlatency, reclatency, playchan, recchan, driver]=asiostrm('open',fs, playchan, recchan)
recdata=asiostrm('io', (samplescount*fs), 'fixed24');



%% Plot of recorded data
close all, clc
ts=1/fs;
n=0:ts:samplescount;
n([1:end]);
signal1=delay(recdata([1:fs*samplescount])',71);
signal2=recdata([(fs*samplescount)+1:end])';



figure()
plot((n([2:end])),signal1,'b',(n([2:end])),signal2,'g')
title('Time plot')
xlabel('Time in sec')
ylabel('Magnitude in gg')
axis([1.22 1.28 -0.01 0.01 ])
%axis([1.231 1.233 -0.01 0.01 ])
%%
figure()
subplot(2,1,1)
plot((n([2:end])),signal1)
title('Time plot mic1')
xlabel('Time in sec')
ylabel('Magnitude in gg')
grid on
subplot(2,1,2)
plot((n([2:end])),signal2)
title('Time plot mic2')
xlabel('Time in sec')
ylabel('Magnitude in gg')
grid on

FSfft=1024;

Sig1=fft(signal1);
Sig2=fft(signal2);

figure()
semilogx(10*log10(abs(Sig1)))
grid on
title('FFT plot mic1')
xlabel('Freq in Hz')
ylabel('Magnitude in dB')
%axis([10 10000 50 100])

figure()
semilogx(10*log10(abs(Sig2)))
grid on
title('FFT plot mic2')
xlabel('Freq in Hz')
ylabel('Magnitude in dB')
%axis([10 10000 50 100])



%% Signal analysis and modulation
clc

diffsig=signal1-signal2;

figure()
plot((n([2:end])),diffsig);
axis([1.22 1.28 -0.01 0.01 ])
%axis([1.231 1.233 -0.01 0.01 ])
%% Playback signal

soundsc(signal1, fs)
pause(5)
soundsc(signal2, fs)
pause(5)
soundsc(diffsig,fs)

%% Play music


f=1000;
audioFS=fs;
yy=(sin(f*2*pi*n));
wavwrite(yy,fs,24,'Sinus.wav')

[y, audioFS]=wavread('Sinus.wav');

playdata=[y([1:fs*samplescount]),y([1:fs*samplescount])];
%soundsc((playdata([1:fs*samplescount]))',audioFS)

%% ASIO play 'n' record
clc

%[playlatency, reclatency, playchan, recchan, driver]=asiostrm('open',fs, playchan, recchan)
recdata=asiostrm('io', playdata);

%% Lowpass filter
close all
FF=1/(fs/2);
F1=0;
F2=200*FF;
F3=1200*FF;
F4=1;
F=[F1 F2 F3 F4];

A1=0;
A2=0;
A3=-500;
A4=-500;
A=[A1 A2 A3 A4];
LP=fir2(20000,F,A);
plotF=(fs/2)*F;
figure()
plot(plotF,A)
axis([0 2000 -15 5])

%% Highpass filter
close all
FF=1/(fs/2);
F1=0;
F2=200*FF;
F3=500*FF;
F4=1;
F=[F1 F2 F3 F4];

A1=-500;
A2=-500;
A3=0;
A4=0;
A=[A1 A2 A3 A4];
HP=fir2(20000,F,A);
plotF=(fs/2)*F;
figure()
plot(plotF,A)
axis([0 2000 -15 5])

HPfft=fft(HP);
HPfft=fftshift(HPfft);
figure()
semilogx(10*log10(abs(HPfft)))





%% LP addon
close all, clc
LPadd=[LP ones(1,length(signal1)-length(LP))];
LPsig=signal1.*LPadd';

figure()
plot(LPsig)

LPSig1=fft(LPsig,fs);

figure()
semilogx(10*log10(abs(Sig1)))
axis([0 10000 -20 20])
grid on

figure()
semilogx(10*log10(abs(LPSig1)))
axis([0 10000 -20 20])
grid on
soundsc(signal1,fs)
pause(6)
soundsc(LPsig,fs)

%% HP addon
close all, clc
HPadd=[HP ones(1,length(signal1)-length(HP))];
HPsig1=HPadd.*signal1';
HPsig2=signal2.*HPadd';

HPsig1=conv(HP,signal1);

figure()
plot(HPsig1,'r')
hold on
plot(HPsig2,'b')
II=[1 -1 1 -1];
HPSig1=fftshift(HPsig1,II);
HPSig2=fft(HPsig2,fs);

%figure()
%semilogx(10*log10(abs(Sig1)))
%axis([0 10000 -20 20])
%grid on

figure()
semilogx(10*log10(abs(HPSig1)))
axis([0 10000 -20 20])
grid on

figure()
semilogx(10*log10(abs(HPSig2)))
axis([0 10000 -20 20])
grid on

soundsc(signal1,fs)
pause(6)
soundsc(HPsig1,fs)

figure()
plot((n([2:end])),HPsig1,'b',(n([2:end])),HPsig2,'g')
title('Time plot')
xlabel('Time in sec')
ylabel('Magnitude in gg')
axis([1.22 1.28 -0.01 0.01 ])

%% LMS setup
clc, close all
signal1=recdata(:,1)/rms(recdata(:,1)); %signal from mic 1
signal2=recdata(:,2)/rms(recdata(:,2));
music=y(1:end-1)/rms(y(1:end-1));

signal1=signal1(:)';
signal2=signal2(:)';
music=music';

figure()
plot(signal1,'b')
hold on 
plot(signal2,'r')
hold on
plot(music,'g')

M=500;          %FIR filter length
u=0.0005;       %adaption constant (mu)
v=zeros(1,M);   %FIR delay line
b=0.01*randn(1,M);  %Initial filter coefs

win=ones(size(signal1));
W=2000;
w=hanning(2*W)';
win(1:W)=w(1:W);
win(end-W:end)=w(end-W:end);
signal1=signal1.*win;
signal2=signal2.*win;
music=music.*win;

figure()
plot(signal1,'b')
hold on 
plot(signal2,'r')
hold on
plot(music,'g')

 N=length(signal1);
 e=signal1*0;           %allocate vector
figure() 
 %% LMS loop
 figure()
 for k=1:N
     if rem(k,20000)==0
         plot(b);
         ylim([-0.5 0.5]);
         drawnow
     end
     v=[signal1(k) v(1:M-1)];
     e(k)=music(k)-sum(v.*b);
     b=b+u*e(k)*v;
 end
 
 soundsc(e,fs)