clc, clear all, close all

load snakfrabord.mat
load 5secBeat.mat

fs=48000;
ts=1/fs;


signal=recdata(:,1)';
desired=playdata(:,1)';

%rms normaliseret
signal=signal/rms(signal);           
desired=desired/rms(desired);

T=(length(desired)/fs)-ts;
n=0:ts:T;

figure()
subplot(3,1,1)
plot(n,signal,'b')
grid on
xlabel('Tid i sec')
title('Recorded')
subplot(3,1,2)
plot(n,desired,'r')
grid on
xlabel('Tid i sec')
title('Desired')
subplot(3,1,3)
plot(n,signal,'b',n,desired,'r')
grid on
xlabel('Tid i sec')
title('Recorded + Desired')

%% Listen

soundsc(desired, fs)
pause(T)
soundsc(signal,fs)

%% Minimumphase filter
close all, clc
both=signal+desired;
c=cceps(both);
%c=rceps(signal);
[px,locs]=findpeaks(c,'Threshold',0.05,'MinPeakDistance',0.2);

figure()
plot(n,c,'b',n(locs),px,'o')
xlabel('Tid in sec')
%ylim([-0.02 0.05])

soundsc(both,fs)
%%
close all, clc

dl=locs(3)-1;
filt=filter(1,[1 zeros(1,dl-1) 0.5],both);

soundsc(filt,fs)
pause(T)
soundsc(signal,fs)

figure()
subplot(2,1,1)

plot(n,filt)
title('filt')
subplot(2,1,2)
plot(n,signal)