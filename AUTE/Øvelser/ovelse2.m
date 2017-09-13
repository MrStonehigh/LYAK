%% Juster for tidsforskydning
clear all, clc, close all
d=0.0020; %forskydning i meter (35mm)
Rbas=6;
Lbas=0.001;
Cbas=6.8e-6;
Rdis=7;
Ldis=0.001;
Cdis=6.8e-6;

Qdis=Rdis*sqrt(Cdis/Ldis);
Qbas=Rbas*sqrt(Cbas/Lbas);
f0dis=1/(2*pi*sqrt(Ldis*Cdis));
f0bas=1/(2*pi*sqrt(Lbas*Cbas));

w0dis=f0dis/(2*pi);
w0bas=f0bas/(2*pi);


syms s
Hdis(s)=(s^2)/(w0dis^2+2*d*w0dis*s+s^2);
Hbas(s)=(w0bas^2)/(w0bas^2+2*d*w0bas*s+s^2);

f=1:1:2000;
s=abs(j*(f*2*pi));
figure()
plot(s,Hdis(s), 'b', s,Hbas(s),'r')
title('Bas og Diskant overføringsfunktioner')
xlabel('Frekvens i Hz')
grid on
legend('Diskant','Bas')
axis([0 2000 0 1])

%% Tidsforskydelse
clc, close all
 c=343;
k=(f*2*pi)/c;

d=0.0035;
Hb=Hbas*exp(-k*d);

delay=k*d;
figure()
plot(f,delay)
grid on
xlabel('frekvens i Hz')
ylabel('forsinkelse i sec')
%%
tau=((f0dis*2*pi)/c)*d;
fs=48000;
ts=1/fs;
t=1/50;
n=0:ts:t;
s1=sin(50*2*pi*n);
s2=sin(50*2*pi*(n-tau));
delaysamples=tau*fs;

W=hann(961)';
%W=ones(1,961);
sw=s1.*W;

SW=fft(sw);

figure()
plot(n,s1,'r',n,s2','b')

%%
H=Hdis+Hb;

figure()
plot(s,H(s))
title('Samlet overføringsfunktion')
xlabel('Frekvens i Hz')
grid on
%legend('Diskant','Bas')
axis([0 2000 0 1])

%% Baskorrektion
clc, close all
syms s
Hh(s)=(s^2)/((s^2)+(w0bas/Qbas)*s+(w0bas^2));

QT=Qbas;
f1=f0bas;
f2=f1;
w0=2*pi*f0bas;
w1=2*pi*f1;
w2=2*pi*f2;
a1=0.7654;
a2=1.8478;
Hk(s)=((s^2)+(w0bas/QT)*s+(w0bas^2))/((s^2)+a1*w1*s+(w1^2));

H1(s)=(s^2)/((s^2)+a1*w1*s+(w1^2));
H2(s)=(s^2)/((s^2)+a2*w2*s+(w2^2));

Hk(s)=((s^2)/(s^2+a1*w1*s+w1^2))+((w0/(QT*w1))*((w1*s)/(s^2+a1*w1*s+w1^2)))+vk*((w1^2)/(s^2+a1*w1*s+w1));
%%
clc, close all
s=abs(1i*(f*2*pi));
figure()
plot(s, Hh(s),'b',s,H1(s),'r',s,H2(s),'g',s,Hk(s),'m')
grid on
title('Bashævning')
legend('Hh','H1','H2','Hk')
axis([0 2000 0 3000])

%% FIR Filter

clc, close all
fs=8000;
fc=79;
f1=500;
vk=(f0bas/f1)^2;
QTS=0.6;
UG=2.83;
N=512;


TH=fs/N
trin=TH/fs
1930/TH
fsny=1/(2*pi*sqrt(QTS));

F1=0;
F2=trin*8;
F3=trin*124;
F4=1;
F=[F1 F2 F3 F4];
M=[6 6 0 0];

B=fir2(N,F,M);

freqz(B,1)
[h,w]=freqz(B,1,128);
figure()
plot(F,M,w/pi,abs(h))
xlabel('\omega / \pi');
lgs = {'Ideal','fir2 default'};
legend(lgs)
axis([0 0.2 0 20])
w=w';
%fwrite('filter.bin',w)
fileID=fopen('filter.bin','w');
fwrite(fileID,[1:128],'double')
fclose(fileID)
phasedelay(B)
%%
S1B=fft(s1).*[B zeros(1,length(s1)-length(B))];
s1b=ifft(S1B);
figure()
plot(abs(s1b))

