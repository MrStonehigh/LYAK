clc,clear,close all;


%% Fysiske Parametre
Ug=1;                                %Påtrykt Spænding (V)
rho=1.18;                               %Air Mass Density (kg/m3)
c=345;                                  %Speed of sound(m/s)
pREF=20e-6;                             %Tryk-reference (pa)

w=0:0.1:1000;                               %Frekvens (Hz)
s=1i*2*pi*w;                             %Laplace operator

%% Parametre FW168 MIDWOOFER
Re=7.2;                                 %DC-Modstand (ohm)
f3=48;
Le=0.001;                                %Svingspolens Selvinduktion (H)
Mms=14.7e-3;                            %Masse af Bevægelige system (kg)
Mmd=13.955e-3;
Cms=0.821e-3;                           %Eftergivelighed af styr (m/N)
Qms=3.246;                              %Mekanisk Godhed
Qes=0.452;
Qts=0.397;
Rms=sqrt(Mms/Cms)/Qms;                  %Mekanisk tabsmodstand (ohm)
Vas=0.017;                            %Ækvivalent Volumen (L)
Bl=8.2;                                 %Kraftfaktor (Tm)
SD=119e-4; 
Pg=1;
Ig=Pg/Ug;

%% Det elektriske system

f1=Re/(2*pi*Le);
F=Bl*Ig;
fs=1/(2*pi*sqrt(Mms*Cms));
Fm=Bl*Ig;

%% Elektrisk og mekanisk impedans

Ws=1/(sqrt(Mms*Cms));

Ze=Re+s*Le+((Bl^2)/(Ws*Mms))*((s*Ws)/((s.^2)+(1/Qms)*s*Ws+(Ws^2)));

Zmax=Re+(Bl^2)/Rms;
%semilogx(w,20*log10(abs(Ze))

%% Plot af Ze

n=[0:1:20000];
%n=1:10;

Ze_f1=Re+n*Le;
Bl1=((Bl^2)/(Ws*Mms));
Ze=Ze_f1+Bl1*((Ws*(2*pi*n))/(((2*pi)*(n.^2))+((1/Qms)*Ws*(2*pi*n) )+(Ws^2)));

x=-5*n.^2+50*n+100;
figure()
semilogx(n,Ze,'b')
hold on
semilogx(n,Ze_f1,'r')

