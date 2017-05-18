clc,clear,close all;


%% Fysiske Parametre
rho=1.18;                            %Air Mass Density (kg/m3)
c=345;                               %Speed of sound(m/s)
pREF=20e-6;                          %Tryk-reference (pa)
Ug=2.75;                             %Påtrykt Spænding (V)
Pg=1;
Ig=Pg/Ug;
f=10:1000;                          %Frekvens (Hz)
s=j*2*pi*f;                          %Laplace operator
%f1=c/(2*pi*r);                      %Grænse for massestyret system
                                     %(Herover Usikkert)
%% Parametre FW168 MIDWOOFER
Re=7.2;                                %DC-Modstand (ohm)
f3=48;
Le=1e-3;%Re/(2*pi*f3);                       %Svingspolens Selvinduktion (H)
Mms=14.7;%e-3;                              %Masse af Bevægelige system (kg)
Cms=0.821;%e-3;                             %Eftergivelighed af styr (mm/N)
fs=45;                                 %Resonansfrekvens (Hz)
Qms=3.246;                             %Mekanisk Godhed
Qes=0.452;                             %Elektrisk Godhed
Rms=(1/Qms)*sqrt(Mms/Cms);             %Mekanisk tabsmodstand (ohm)
Vas=0.017;                           %Ækvivalent Volumen (L)
Bl=8.2;                                %Kraftfaktor (Tm)
SD=119e-4;                             %Membranens effektive Areal (m^2)
Xmax=4.6e-3;                           %Maksimal Lineær Bevægelse (m)
%S=87.3;                               %Følsomhed (dB)


%% Det elektriske system

f1=Re/(2*pi*Le);
F=Bl*Ig;

%% Elektrisk og mekanisk impedans

Ws=1/sqrt(Mms*Cms);
Ze=Re+s*Le+((Bl^2)/(Ws*Mms))*((Ws*f)/((s*s')+(1/Qms)*Ws*s+(Ws^2)));

figure()
semilogx(f,Ze)