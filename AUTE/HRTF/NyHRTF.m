%% HRTF
clc, clear all, close all
azi=276;
eleArr=[-40 -30 -20 -10 0 10 20 30 40 50 60 70 80 90];
eleInd=9;
eleFil=['elev' int2str(eleArr(eleInd))]
radii=4;
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


k1=1*radii;

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
