clear all, close all, clc

%load lavmusikstorsnak1.mat
load stormusiklavsnak3.mat
%  load 5secBeat.mat
%  load snakfrabord.mat
%load 1sectalk2.mat
%load 10secBeat.mat
%load lavsnak.mat
% load Nirvana16bitmono.mat
% load talk.mat

%%
close all, clc
fs=48000;

ts=1/fs;
time=5;
t=0:ts:time-ts;

s1=playdata(:,1)';
s2=recdata(:,2)';
s3=recdata(:,1)';

c=344;

s1=s1/rms(s1);
s2=s2/rms(s2);
s3=s3/rms(s3);


s11=s1;

figure()
plot(t,s1,t,s2,t,s3)%,t,x)



%% ######### Find delay #############
clc, close all
[mag,lag]=xcorr(s3,s1);
[maxmag,maxI] = max(abs(mag));
lagdiff=lag(maxI);
timediff = lagdiff/fs;
lagdist=timediff/c;


[mag3,lag3]=xcorr(s3,s2);
[maxmag3,maxI3] = max(abs(mag3));
lagdiff3=lag3(maxI3);
timediff3 = lagdiff3/fs;
lagdist3=timediff3/c;

figure()
plot(lag,(mag),'b',lag3,(mag3),'--r')
grid on
grid minor
title('Delay between channels')
legend('s1 & s3','s2 & s3')
axis([-100000 100000 -300000 400000])

TT=abs(lagdiff);
TT3=abs(lagdiff3);

TT=2384;

s1=[zeros(1,TT) s1(1:end-TT)];
s2=[zeros(1,TT3) s2(1:end-TT3)];
figure()
plot(t,(s1),'b',t,(s2),'r',t,(s3),'g')
legend('s1','s2','s3')
axis([0 0.1 -3 3])
%axis([0.045 0.055 -0.3 0.8])
%ylim([-5 15])
grid on

%% EXCEL

EXCEL=["s1 skalar" "s4 skalar" "ind0mags2norm" "p3"; ...
100 1  1.0000 31.4080; ...    
30 1 0.9994 24.4913; ...
    10 1 0.9951 16.9531; ...
    1 1 0.7147 2.6915; ...
    1 10 0.1207 1.8358; ...
    1 30 0.0548 1.8406; ...
    1 100 0.0315 1.1800]

%% ##### RATIO #####
close all, clc
% x=x';
% x=x/rms(x);
% s1=0.1*s11;
% s4=s1+4.64*x;
 s4=s2;
%s4=s4/rms(s4);
[mag lag]=xcorr(s4,s1);
 [maxmags2 maxinds2] = max(abs(mag(length(s2)-100:length(s2)+100)));
 mags2=mag(length(s2)+(maxinds2-101));
 ind0mags2norm=abs(mags2)/length(s4)
 mags2rms1=rms(mag);
% mags2SNR=mags2/mags2rms
 mags2rms=mags2rms1*ones(1,length(lag));
 
 [mags1 lags1] = xcorr(s1,s1);
 [maxmags1 maxinds1] = max(abs(mags1(length(s1)-100:length(s1)+100)));
 magss1=mags1(length(s1)+(maxinds1-101));
 ind0mags1norm=abs(magss1)/length(s1)
 
%   [magx lagx] = xcorr(x,x);
%  [maxmagx maxindx] = max(abs(magx(length(x)-100:length(x)+100)));
%  magsx=magx(length(x)+(maxinds1-101));
%  ind0magxnorm=abs(magsx)/length(x)

  [mags4 lags4] = xcorr(s3,s2);
 [maxmags4 maxinds4] = max(abs(mags4(length(s4)-100:length(s4)+100)));
 magss4=mags4(length(s4)+(maxinds1-101));
 ind0mags4norm=abs(magss4)/length(s4)

 
 S=(ind0mags1norm);
 N=(S-ind0mags2norm)
  soundsc(s4,fs)
 p=20*log10(abs(S/N))
 
 figure()
 subplot(2,1,1)
 plot(lag, mag,'b')
 grid on
 grid minor
 title('Xcorr ratio for s4 and s1')
 hold on
 plot(lag,mags2rms,'r')
 %axis([-400 400 -200000 250000])
 subplot(2,1,2)
 plot(lags1,mags1)
 title('Auto corr for s1')
 grid on 
 grid minor
 
 figure()
 plot(t,s1,t,s4,'--r')
 
 [rx rxlag]=xcorr(s1,s1);
[ry rylag]=xcorr(s4,s4);

S4=rms(s1);
N4=rms(s4);

p4=20*log10(S4/N4);

S3=mean(s1.^2);
N3=mean(s4.^2);

p3=10*log10(abs(S3/N3));

clear mag lag mag3 mags1 lags1 mags2rms1 magss1 maxinds1 maxmags1 rx ry rxlag rylag lag3 lagdiff lagdiff3 lagdist lagdist3 maxI maxI3 maxmag maxmag3 dis TT TT3 timediff timediff3 c mags2 mags2rms maxinds2 maxmags2 
%clear playdata recdata

%% Blockwise crosscorr
close all, clc
M=500;       %Windowsize of crosscorr signal
N=(fs*time)/M;
y=zeros(1,M);
ratio=zeros(1,M);

for k=1:N
    w=s1((M*k)-(M-1):M*k);
    x=s3((M*k)-(M-1):M*k);
    [mag lag] = xcorr(w,x);
    [magmax magind] = max(abs(mag));
    y(k) = mag(M);
    ratio(k)=magmax/M;
end

figure()
subplot(2,1,1)
plot(y)
title('Magnitude index 0')
grid on
subplot(2,1,2)
plot(ratio)
grid on
title('Ratio')

%% SNR based on autocorr
close all, clc
[rx rxlag]=xcorr(s1,s1);
[ry rylag]=xcorr(s4,s4);

[S1 S1ind]=max(abs(rx));
N1=max(abs(ry))-S1;

p1=mag2db(S1)/mag2db(N1)

S2=S1^2;
N2=N1^2;

p2=sqrt(S2/N2)

S3=mean(rx.^2);
N3=mean(ry.^2)-S3;

p3=10*log10(S3/N3)

%% Calibration
close all, clear all, clc

%load 800sintest.mat
%load lavmusikstorsnak1.mat
load stormusiklavsnak1.mat

fs=48000;

ts=1/fs;
time=5;
t=0:ts:(time-1)-ts;

s1=playdata(fs/2:(5*fs)-(fs/2)-1,1)';
s2=recdata(fs/2:(5*fs)-(fs/2)-1,2)';
s3=recdata(fs/2:(5*fs)-(fs/2)-1,1)';

c=343;

s1=s1/rms(s1);
s2=s2/rms(s2);
s3=s3/rms(s3);

% ######### Find delay #############
[mag,lag]=xcorr(s3,s1);
[maxmag,maxI] = max(abs(mag));
lagdiff=lag(maxI);
timediff = lagdiff/fs;
lagdist=c*timediff;

[mag3,lag3]=xcorr(s3,s2);
[maxmag3,maxI3] = max(abs(mag3));
lagdiff3=lag3(maxI3);
timediff3 = lagdiff3/fs;
lagdist3=c*timediff3;

figure()
subplot(2,1,1)
plot(lag,(mag),'b')
grid on
grid minor
title('Delay between s2 & s3')
subplot(2,1,2)
plot(lag3,(mag3),'r')
grid on
grid minor
title('Delay between s1 & s3')
%axis([-10000 10000 -300000 400000])



TT=abs(lagdiff);
TT3=abs(lagdiff3);

%TT=2384;

s1=[zeros(1,TT) s1(1:end-TT)];
s2=[zeros(1,TT3) s2(1:end-TT3)];
figure()
plot(t,(s1),'b',t,(s2),'r',t,(s3),'g')
legend('s1','s2','s3')
%axis([0 0.1 -3 3])
%axis([0.045 0.055 -0.3 0.8])
%ylim([-5 15])
grid on