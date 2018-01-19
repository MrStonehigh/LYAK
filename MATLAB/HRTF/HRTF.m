close all, clc, clear all

%% Start SOFA
close all, clear all, clc
SOFAstart

%% Load imp�ulse response into struct
% hrtf = SOFAload('SOFA/database/ari/dtf_nh2.sofa');
hrtf = SOFAload('SOFA/database/mit/mit_kemar_normal_pinna.sofa');
clc
%hrtf = SOFAload('SOFA/database/listen/irc_1016.sofa');

SOFAinfo(hrtf);
%%
database='oldenburg';    HRTFfilename='OfficeII.sofa';

fullfn=fullfile(SOFAdbPath, 'database', database, HRTFfilename);
disp(['Loading ' fullfn]);
Obj=SOFAload(fullfn);

%%
SOFAfn=fullfile(SOFAdbPath,'sofa_api_mo_test','Oldenburg_OfficeII.sofa');
Obj=SOFAload(SOFAfn);
%% Plot figure
close all, clc

SOFAplotGeometry(hrtf);
grid on
% figure()
% SOFAplotHRTF(hrtf,'EtcHorizontal');


%%

size(hrtf.Data.IR)


%% 

hrtf.ListenerPosition = [50 5 1]
hrtf.SourcePosition
hrtf.ListenerView
hrtf.ListenerView_Type
%hrtf.ListenerView_Units

%%

apparentSourceVector = SOFAcalculateAPV(Obj);
 
%%
close all, clc
azi=2;
fs=48000;
apparentSourceVector(azi,1);
hrtf=Obj;
SOFAplotGeometry(hrtf,azi);
soundInput = audioread('Nirvana.wav');
soundInput = soundInput(hrtf.Data.SamplingRate*1:hrtf.Data.SamplingRate*10);
%soundInput = randn(5*Obj.Data.SamplingRate,1);	% Five seconds of noise
soundOutput = [conv(squeeze(hrtf.Data.IR(azi,1,:)),soundInput(:)) ...
                conv(squeeze(hrtf.Data.IR(azi,2,:)),soundInput(:))];
%soundsc(soundOutput, hrtf.Data.SamplingRate);
sound(soundOutput, fs);

%%

Obj.Data.Delay=[0 0 (Obj.Data.SamplingRate*20) 0 0 (Obj.Data.SamplingRate*10) 0 0];

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
headsize=0.24;
c=344;

%Drum
azi=90;
ele=10;
radii=3;
k1=1/radii;
[Drum_out, aziN, eleN, Drum_idx] = SOFAspat(Drum.data(:,1),hrtf,azi,ele);
radiiL=sqrt(radii^2+(headsize/2)^2-2*radii*(headsize/2)*cos(90-azi));
radiiR=sqrt(radii^2+(headsize/2)^2-2*radii*(headsize/2)*cos(90+azi));
TdelayL=radiiL/c;
TdelayR=radiiR/c;
SampDelayL=round(TdelayL*Drum.fs);
SampDelayR=round(TdelayR*Drum.fs);
delayL=[zeros(SampDelayL,1); Drum_out(1:end-SampDelayL,1)];
delayR=[zeros(SampDelayR,1); Drum_out(1:end-SampDelayR,2)];
Drum_out(:,1)=delayL;
Drum_out(:,2)=delayR;



%Vocal
azi=-90;
ele=0;
radii=12;
k2=1/radii;
[Vocal_out, aziN, eleN, Vocal_idx] = SOFAspat(Vocal.data(:,1),hrtf,azi,ele);
radiiL=sqrt(radii^2+(headsize/2)^2-2*radii*(headsize/2)*cos(90-azi));
radiiR=sqrt(radii^2+(headsize/2)^2-2*radii*(headsize/2)*cos(90+azi));
TdelayL=radiiL/c;
TdelayR=radiiR/c;
SampDelayL=round(TdelayL*Vocal.fs);
SampDelayR=round(TdelayR*Vocal.fs);
delayL=[zeros(SampDelayL,1); Vocal_out(1:end-SampDelayL,1)];
delayR=[zeros(SampDelayR,1); Vocal_out(1:end-SampDelayR,2)];
Vocal_out(:,1)=delayL;
Vocal_out(:,2)=delayR;

%Bass
azi=180;
ele=0;
radii=.6;
k3=1/radii;
[Bass_out, aziN, eleN, Bass_idx] = SOFAspat(Bass.data(:,1),hrtf,azi,ele);
radiiL=sqrt(radii^2+(headsize/2)^2-2*radii*(headsize/2)*cos(90-azi));
radiiR=sqrt(radii^2+(headsize/2)^2-2*radii*(headsize/2)*cos(90+azi));
TdelayL=radiiL/c;
TdelayR=radiiR/c;
SampDelayL=round(TdelayL*Bass.fs);
SampDelayR=round(TdelayR*Bass.fs);
delayL=[zeros(SampDelayL,1); Bass_out(1:end-SampDelayL,1)];
delayR=[zeros(SampDelayR,1); Bass_out(1:end-SampDelayR,2)];
Bass_out(:,1)=delayL;
Bass_out(:,2)=delayR;

%Guitar
azi=10;
ele=0;
radii=4.5;
k4=1/radii;
[Guitar_out, aziN, eleN, Guitar_idx] = SOFAspat(Guitar.data(:,1),hrtf,azi,ele);
radiiL=sqrt(radii^2+(headsize/2)^2-2*radii*(headsize/2)*cos(90-azi));
radiiR=sqrt(radii^2+(headsize/2)^2-2*radii*(headsize/2)*cos(90+azi));
TdelayL=radiiL/c;
TdelayR=radiiR/c;
SampDelayL=round(TdelayL*Guitar.fs);
SampDelayR=round(TdelayR*Guitar.fs);
delayL=[zeros(SampDelayL,1); Guitar_out(1:end-SampDelayL,1)];
delayR=[zeros(SampDelayR,1); Guitar_out(1:end-SampDelayR,2)];
Guitar_out(:,1)=delayL;
Guitar_out(:,2)=delayR;

%%
clc, 
% Guitar_outBU(:,1)=Guitar_out(:,1);
% gk=100;
% delayguitar=[zeros(1,gk) Guitar_outBU(1:(end-gk))'];
% Guitar_out(:,1)=delayguitar;
% %Guitar_out(:,2)=delayguitar;
%sound(delayguitar,Guitar.fs)

sound(k4*Guitar_out,Guitar.fs)
pause(3)
sound(k1*Drum_out,Drum.fs)
pause(3)
sound(k2*Vocal_out,Vocal.fs)
pause(3)
sound(k3*Bass_out,Bass.fs)

%% 
%[Guitar_out, aziN, eleN, Guitar_idx] = SOFAspat(Guitar_out,Obj,azi,ele);
conv(Guitar_out, Obj.Data);
%% Med AlgoFlex
clc, clear all, close all
system('start C:\projects\Tools\AlgoFlex\bin\win32_x86\Release\AlgoFlexServer.exe');
ServerIpName = 'localhost';
serverID = AlgoFlexClient('OpenServCon',ServerIpName,4242);

fs = 48000;

AlgoFlexClient(serverID,'SetSampleRate',fs);

[idMatPlayer nameMatPlayer] = AlgoFlexClient(serverID,'Create', 'MatrixPlayer',0,1);

rectime=10;      %Recording time for MatrixRecorder in sec
sampno=fs*rectime;
[idMatRec nameMatRec] = AlgoFlexClient(serverID,'Create','MatrixRecorder',1,0);

[idGain nameGain] = AlgoFlexClient(serverID,'Create','Gain',1,1);

AlgoFlexClient(serverID,'ConnectAudio',idMatPlayer,1,idGain,1);
AlgoFlexClient(serverID,'ConnectAudio',idGain,1,idMatRec,1);

AlgoFlexClient(serverID,'GenerateGraph',{},{},'Audio+Parms',50,'eps','C:\tmp\AAADiagram')

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

%% HRTF
clc, clear all, close all
azi=145;
eleArr=[-40 -30 -20 -10 0 10 20 30 40 50 60 70 80 90];
eleInd=5;
eleFil=['elev' int2str(eleArr(eleInd))]
fileL='';
fileR='';

while ((exist(fileL,'file') ~= 2) && (exist(fileR,'file') ~= 2))
 
    if(azi==0)
hrtfL=['R' int2str(eleArr(eleInd)) 'e00' int2str(azi) 'a.wav']
hrtfR=['R' int2str(eleArr(eleInd)) 'e00' int2str(azi) 'a.wav']
    else if(azi<10)
hrtfL=['R' int2str(eleArr(eleInd)) 'e00' int2str(azi) 'a.wav']
hrtfR=['R' int2str(eleArr(eleInd)) 'e' int2str(360-azi) 'a.wav']
else if(azi<100&&azi>9)
hrtfL=['R' int2str(eleArr(eleInd)) 'e0' int2str(azi) 'a.wav']
hrtfR=['R' int2str(eleArr(eleInd)) 'e' int2str(360-azi) 'a.wav']
else if(azi>99&&azi<260)
     hrtfL=['R' int2str(eleArr(eleInd)) 'e' int2str(azi) 'a.wav']
hrtfR=['R' int2str(eleArr(eleInd)) 'e' int2str(360-azi) 'a.wav'] 
    else if(azi>259)
        hrtfL=['R' int2str(eleArr(eleInd)) 'e' int2str(azi) 'a.wav']
hrtfR=['R' int2str(eleArr(eleInd)) 'e0' int2str(360-azi) 'a.wav']     
        end
    end
    end
    end
 end
fileL=fullfile('HRTF','full',eleFil,hrtfL)
fileR=fullfile('HRTF','full',eleFil,hrtfR)
exist(fileL,'file')

    azi=azi+1;
    disp(azi)
end
disp('Im out!')
azi=azi-1
    L0=uiimport(fileL);
    R0=uiimport(fileR);
    
%%

S1=load('HRTF\10secBeat.mat')
S1.playdata=S1.playdata/mean(S1.playdata);
fs=48000;
%soundsc(S1.playdata,fs)
    
%% :::: HRTF ::::::::::::::
% L0=uiimport('full\elev0\R0e015a.wav');
% R0=uiimport('full\elev0\R0e345a.wav');

L0tf=fft(L0.data);
R0tf=fft(R0.data);

SL=conv(abs(L0.data),S1.playdata(:));
SR=conv(abs(R0.data),S1.playdata(:));

OUT1(:,1)=SL;
OUT1(:,2)=SR;



% ::::::::: ITD ::::::::::::::

headsize=0.24;
c=344;

ele=eleArr(eleInd);
radii=2;

k1=1/radii;

radiiL=sqrt(radii^2+(headsize/2)^2-2*radii*(headsize/2)*cos(90-azi));
radiiR=sqrt(radii^2+(headsize/2)^2-2*radii*(headsize/2)*cos(90+azi));
TdelayL=radiiL/c;
TdelayR=radiiR/c;
SampDelayL=round(TdelayL*fs);
SampDelayR=round(TdelayR*fs);
delayL=[zeros(SampDelayL,1); SL(1:end-SampDelayL)];
delayR=[zeros(SampDelayR,1); SR(1:end-SampDelayR)];
OUT3(:,1)=delayL;
OUT3(:,2)=delayR;

OUT2(:,1)=OUT3(:,1);
OUT2(:,2)=OUT3(:,2);

% :::::::::: ILD / IID :::::::::::
f=600;
IID_L=1+(f/1000)^0.8*sin(azi);
IID_R=1+(f/1000)^0.8*sin(360-azi);

OUT3(:,1)=OUT3(:,1)*IID_L;
OUT3(:,2)=OUT3(:,2)*IID_R;

%% listen
figure()
subplot(3,1,1)
plot(OUT1)
subplot(3,1,2)
plot(OUT2)
subplot(3,1,3)
plot(OUT3)

 soundsc(OUT1,fs)
 pause(5)
soundsc(OUT2,fs)
pause(5)
soundsc(OUT3,fs)





%%
close all, clc
S1fft=fft(S1.playdata,fs/2);
Ff=1:fs/2;

figure()
semilogx(Ff,10*log10(abs(S1fft)))
xlim([10 fs/2])
grid on
