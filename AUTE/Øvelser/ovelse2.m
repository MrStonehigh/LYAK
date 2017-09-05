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

f=1:1:10000;
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

H1(s)=(s^2)/((s^2)+a1*w1*s+(w1^2))
H2(s)=(s^2)/((s^2)+a2*w2*s+(w2^2));
%%
clc, close all
s=abs(j*(f*2*pi));
figure()
plot(s, Hh(s),'b',s,H1(s),'r',s,H2(s),'g',s,Hk(s),'m')
grid on
title('Bashævning')
legend('Hh','H1','H2','Hk')

