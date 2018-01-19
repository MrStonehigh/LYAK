%%
clear Band, clc
Band(1:size(Drum_out),1) = Drum_out(1:size(Drum_out))';
Band(1:size(Drum_out),2) = 0.8*Vocal_out(1:size(Drum_out))';
Band(size(Drum_out)+1:size(Drum_out)*2,1) = Bass_out(1:size(Drum_out))';
Band(size(Drum_out)+1:size(Drum_out)*2,2) = Guitar_out(1:size(Drum_out))';
%Band = [Drum(1:size(Drum),1) Vocal(1:size(Drum),1); Bass(1:size(Drum),1) Guitar(1:size(Drum),1)];
Band = [Drum_out(1:size(Drum),1) Vocal_out(1:size(Drum),1); Bass_out(1:size(Drum),1) Guitar_out(1:size(Drum),1)];
sound(Band,48000)

%%


fp = fopen('full\elev0\L0e050a.wav', 'r', 'ieee-be');
data = fread(fp,256,'short');
fclose(fp);

leftimp = data(1:2:256);
rightimp= data(2:2:256);

figure()
plot(leftimp)
hold on
plot(rightimp)

S1 = uiimport('Sinus.wav')

SL = conv(leftimp, S1.data);
SR = conv(rightimp, S1.data);

%% Listen
k=0.5;
OUT1=[(SL), (SR)];
sound(OUT1, S1.fs)

%%
clear all, close all, clc
L0=uiimport('full\elev0\L0e355a.wav');
R0=uiimport('full\elev0\R0e355a.wav' );

S1 = uiimport('Sinus.wav')

%%
close all, clc


fs=L0.fs;

figure()
plot(L0.data)
hold on
plot(R0.data)


L0tf=fft(L0.data);
R0tf=fft(R0.data);

% figure()
% semilogx(10*log10(L0tf),'o')

SL=abs(conv(L0.data,S1.data'));
SR=abs(conv(R0.data,S1.data'));

figure()
plot(S1.data)
hold on
plot(SL)
% axis([1 1000 -1 1])

%%
k=0.8;
OUT1=[k*(SL); k*(SR)]';
sound(OUT1, S1.fs)

%% OUT2
L0=uiimport('full\elev70\L70e015a.wav');
R0=uiimport('full\elev70\L70e345a.wav');

L0tf=fft(L0.data);
R0tf=fft(R0.data);

SL=abs(conv(L0tf,S1.data'));
SR=abs(conv(R0tf,S1.data'));

k=0.5;
OUT2=[k*(SL); k*(SR)];

%% OUT3
L0=uiimport('full\elev-40\R-40e090a.wav');
R0=uiimport('full\elev-40\R-40e270a.wav');

L0tf=fft(L0.data);
R0tf=fft(R0.data);

SL=conv(abs(L0tf),S1.data');
SR=conv(abs(R0tf),S1.data');

k=0.1;
OUT3=[k*(SL); k*(SR)];

%% listen

sound(OUT1,S1.fs)
pause(5)
sound(OUT2,S1.fs)
pause(5)
sound(OUT3,S1.fs)

