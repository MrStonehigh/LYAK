close all, clc, clear all

%% Start SOFA
close all, clear all, clc
SOFAstart

%% Load impåulse response into struct
% hrtf = SOFAload('SOFA/database/ari/dtf_nh2.sofa');
%hrtf = SOFAload('SOFA/database/mit/mit_kemar_normal_pinna.sofa');
clc
hrtf = SOFAload('SOFA/database/riec/RIEC_hrir_subject_012.sofa');

SOFAinfo(hrtf);

%% Plot figure
close all

SOFAplotGeometry(hrtf);
figure()
SOFAplotHRTF(hrtf,'EtcHorizontal');

%%

size(hrtf.Data.IR)

%% 

hrtf.ListenerPosition
hrtf.SourcePosition;
hrtf.ListenerView
hrtf.ListenerView_Type
hrtf.ListenerView_Units

%%

apparentSourceVector = SOFAcalculateAPV(hrtf);

%%
close all, clc
azi=1206;
apparentSourceVector(azi,1);
SOFAplotGeometry(hrtf,azi);
soundInput = audioread('Nirvana.wav');
soundInput = soundInput(hrtf.Data.SamplingRate*1:hrtf.Data.SamplingRate*10);
soundOutput = [conv(squeeze(hrtf.Data.IR(azi,1,:)),soundInput(:)) ...
                conv(squeeze(hrtf.Data.IR(azi,2,:)),soundInput(:))];
soundsc(soundOutput, hrtf.Data.SamplingRate);

%% spatial
k=0.2;
azi=0;
ele=-70;
[out, azi, ele, idx] = SOFAspat(soundInput(:),hrtf,azi,ele);
sound(k*out,hrtf.Data.SamplingRate)

%% inmport instruments
clc, 
Drum = audioread('120_delay-stutter-phase-drums.wav');
Vocal = audioread('asian-consciousness.aif');
Bass = audioread('113_modern-rock-bass.aif.mp3');
Guitar = audioread('090_funk-rhythm-guitar.aif');

%%

Drum = uiimport('120_delay-stutter-phase-drums.wav');
Vocal = uiimport('asian-consciousness.aif');
Bass = uiimport('113_modern-rock-bass.aif.mp3');
Guitar = uiimport('090_funk-rhythm-guitar.aif');

%% Place
%Drum
k1=1;
azi=90;
ele=0;
[Drum_out, azi, ele, Drum_idx] = SOFAspat(Drum.data(:,1),hrtf,azi,ele);


%Vocal
k2=1;
azi=280;
ele=-50;
[Vocal_out, azi, ele, Vocal_idx] = SOFAspat(Vocal.data(:,1),hrtf,azi,ele);

%Bass
k3=3;
azi=0;
ele=-10;
[Bass_out, azi, ele, Bass_idx] = SOFAspat(Bass.data(:,1),hrtf,azi,ele);

%Guitar
k4=1;
azi=0;
ele=80;
[Guitar_out, azi, ele, Guitar_idx] = SOFAspat(Guitar.data(:,1),hrtf,azi,ele);

%%
clc
delayguitar=[zeros(1,96) Guitar_out(:)]; %%(1:(end-zeros(1,96)))];
Guitar_out(:,2)=delayguitar;
sound(k4*Guitar_out,Guitar.fs)
%sound(delayguitar,Guitar.fs)
pause(3)
sound(k1*Drum_out,Drum.fs)
pause(2)
sound(k2*Vocal_out,Vocal.fs)
pause(3)
sound(k3*Bass_out,Bass.fs)





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

