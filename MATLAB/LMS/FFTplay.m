close all, clc, clear

fs=48000;
n=10;
f=100;
tf=1/f;
ts=1/fs;
t=0:ts:n;
S=2*sin(f*2*pi*t);


figure()
plot(t,S)
grid on
axis([0 2*tf -2 2])
N=512;
ST=fft(S,N);
%%
win=hamming(256);
imp=[1 zeros(1,255)];

Win=win.*imp;
WIN=fft(Win,fs);
figure()
semilogx(10*log10(abs(WIN)))
axis([100 10000 -50 50])
grid on
%%
close all, clc

fs/length(t)
figure()
plot(10*log10(abs(ST)))
grid on
xlim([10 1000])
%%
y=crosscorr(S,S);

w=[0 1 1 ones(1,length(S)-3)];

STw=S.*w;

W=fft(w,fs);

figure()
semilogx(20*log10(abs(W)))
title('W')
grid on


STW=fft(STw, fs);

figure()
plot(t,(STw))
axis([0 0.2 0 2])

figure()
semilogx(20*log10(abs(STW)))
grid on
axis([90 150 -300 60])

%%
clear all, close all, clc
fs=48000;
M=100;
Ts=1/fs;
M*Ts

d=0.4;
c=343;
Tau=d/c

%% Spatial Delay
close all, clc
ang=1:1:360;
Sd=d*sin((ang/(2*pi)));

figure()
plot(ang,Sd)
axis([1 360 -1 1])
f=50;
l=f/c;
phi=((2*pi*d)/l)*sin(ang/(2*pi));

figure()
plot(ang,phi)