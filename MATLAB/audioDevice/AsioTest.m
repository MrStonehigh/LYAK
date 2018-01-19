clc, close all, clear all
% Setting up ASIO driver
fs=48000;
ts=1/fs;
playchan=[1 7];     
recchan=[1:2]; 
samplescount=5;     %Recordingtime in sec
driver=asiostrm('getdriver',0);
asiostrm('setdriver', driver);
[playlatency, reclatency, playchan, recchan, driver]=asiostrm('open',fs, playchan, recchan)
recdata=asiostrm('io', (samplescount*fs), 'int24');



%% Plot of recorded data
close all, clc

n=0:ts:samplescount;
n([1:end]);
signal1=delay(recdata([1:fs*samplescount])',70);
signal2=recdata([(fs*samplescount)+1:end])';
%%
clc, close all
n=0:ts:samplescount*3;
n([1:end]);
figure()
plot((n(2:end)),signal1,'b',(n(2:end)),e,'g')
title('Time plot')
xlabel('Time in sec')
ylabel('Magnitude in gg')
%axis([1.22 1.28 -0.01 0.01 ])

figure()
subplot(2,1,1)
plot((n([2:end])),signal1)
title('Time plot mic1')
xlabel('Time in sec')
ylabel('Magnitude in gg')
grid on
subplot(2,1,2)
plot((n([2:end])),e)
title('Time plot mic2')
xlabel('Time in sec')
ylabel('Magnitude in gg')
grid on

FSfft=1024;

Sig1=fft(signal1, fs/2);
Sig2=fft(signal2, fs/2);
MUS=fft(music,fs/2);
ERR=fft(e,fs/2);

figure()
semilogx(10*log10(abs(Sig2)),'b')
grid on
title('FFT plot mic1')
xlabel('Freq in Hz')
ylabel('Magnitude in dB')
axis([10 10000 -20 30])
hold on
semilogx(10*log10(abs(ERR)),'r')
grid on
title('FFT plot mic2')
xlabel('Freq in Hz')
ylabel('Magnitude in dB')
%axis([10 10000 50 100])
hold on
semilogx(10*log10(abs(MUS)),'g')
grid on
title('FFT plot music')
xlabel('Freq in Hz')
ylabel('Magnitude in dB')
axis([10 10000 -20 30])
legend('Sig2','ERR','MUS')



%% Signal analysis and modulation
clc

diffsig=signal1-signal2;

figure()
plot((n([2:end])),diffsig);
%axis([1.22 1.28 -0.01 0.01 ])

Epower=e.^e;
Mpower=music.^music;

SNREM=Epower/Mpower

%% Playback signal

soundsc(signal1, fs)
pause(5)
soundsc(signal2, fs)
pause(5)
soundsc(diffsig,fs)

%% Sinuscalibration
t=0:ts:samplescount-ts;
f=800;
y=0.98*sin(f*2*pi*t);
playdata=[y' y'];
soundsc(playdata,fs)
%% Play music

[y, audioFS]=wavread('Rockinbeats.wav');
playdata=[y([1:fs*samplescount]),y([1:fs*samplescount])];
soundsc((playdata([1:fs*samplescount]))',audioFS)

%% ASIO play 'n' record

%[playlatency, reclatency, playchan, recchan, driver]=asiostrm('open',fs, playchan, recchan)
recdata=asiostrm('io', playdata);


%% Bandpass filtering
close all, clc
w=zeros(1,200);
L=1;
testsig=[signal1(1:end)];
err=(1000*diffsig)-(playdata([1:fs*samplescount])');
soundsc(err, audioFS)
figure()
plot((n([2:end])),err)
title('Time plot of err')
xlabel('Time in sec')
ylabel('Magnitude in gg')

%% Lowpass filter
close all
FF=(fs/2);
F1=0;
F2=500*(1/FF);
F3=800*(1/FF);
F4=1;
F=[F1 F2 F3 F4];

A1=1;
A2=1;
A3=-100;
A4=-200;
A=[A1 A2 A3 A4];
LP=fir2(200,F,A);
plotF=(fs/2)*F;
figure()
plot(plotF,A)
axis([0 2000 -15 5])

figure()
plot(LP)

LLP=(fft(LP));
N=length(LP);
dF=fs/N;

f=[-fs/2:dF:(fs/2)-dF];

figure()
semilogx(f,10*log10(abs(LLP)))
grid on



%%
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

%% Listen

soundsc(e,fs)
%soundsc(recdata,fs)
%soundsc(signal1, fs)

%% LMS setup
clc, close all
d=0.153;
MM=2360;

delays=round((0.153/344)*fs)+MM;
signal1=(0.1*(recdata(:,1))/rms((recdata(:,1)))); %signal from mic 1
signal2=0.1*recdata(:,2)/rms(recdata(:,2));
music=0.1*(playdata(:,1))/rms((playdata(:,1)));

signal1=signal1(:)';
signal2=delay(signal2(:)',delays-MM+10);
music=music(:)';
music=[zeros(1,delays) music(1:end-delays)];

figure()
plot(signal1,'b')
hold on 
plot(signal2,'r')
hold on
plot(music,'g')
axis([71000 71600 -0.35 0.35])

M=500;             %FIR filter length
u=0.0005;           %adaption constant (mu)
v=zeros(1,M);       %FIR delay line
b=0.01*randn(1,M);  %Initial filter coefs

win=ones(size(signal1));
W=2000;
w=hanning(2*W)';
win(1:W)=w(1:W);
win(end-W:end)=w(end-W:end);
signal1=signal1.*win;
signal2=signal2.*win;
music=music.*win;
signal1=[signal1 signal1 signal1];
signal2=[signal2 signal2 signal2];
music=[music music music];

figure()
plot(signal1,'b')
hold on 
plot(signal2,'r')
hold on
plot(music,'g')

 N=length(music);
 e=music*0;           %allocate vector
 
 signal2=signal2-signal1;
%% LMS loop1
close all
 figure()
 for k=1:N
     if rem(k,20000)==0
         plot(b);
         ylim([-0.5 0.5]);
         drawnow
     end
     v = [music(k) v(1:M-1)];
     e(k)=signal2(k)-sum(v.*b);
     b=b + (u*e(k)*v);
 end
 
 %Listen
 
 soundsc(e,fs)

 
 

