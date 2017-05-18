%% Refleksion
clc,clear,close all;
%% Parametre FW168 MIDWOOFER
Re=7.2;                                %DC-Modstand (ohm)
f3=48;                                 % Hz
Le=Re/(2*pi*f3);                       %Svingspolens Selvinduktion (H)
Mms=14.7%e-3;                          %Masse af Bevægelige system (kg)
Cms=0.821%e-3;                         %Eftergivelighed af styr (mm/N)
fs=45;                                 %Resonansfrekvens (Hz)
Qms=3.246;                             %Mekanisk Godhed
Qes=0.452;                             %Elektrisk Godhed
Rms=(1/Qms)*sqrt(Mms/Cms);             %Mekanisk tabsmodstand (ohm)
Vas=16.5e-3;                           %Ækvivalent Volumen (L)
Bl=8.2;                                %Kraftfaktor (Tm)
SD=119;%e-2;                             %Membranens effektive Areal (m^2)
Xmax=4.6%;e-3;                           %Maksimal Lineær Bevægelse (m)
%S=87.3;                               %Følsomhed (dB)


%% Fysiske Parametre

Ug=2.75;                             %Påtrykt spænding (V)
rho=1.18;                            %Air Mass Density (kg/m3)
f=1:10000;                           %Frequency (Hz)
pRef=20e-6;                          %Referencetryk (pa)
rd=1;                                %Distance to Microphone (m)
c=343;                               %Lydens hastighed (m/s)
D=1;                                 %Spredning (approximeret)
k=(2*pi*f)/c;                        %Bølgetallet


%% Portens Parametre

r=1;                                  %Måleafstand (m)
h=.20;                                %Højtalerens højde ift gulv (m)
rp=0.025;                             %Port Radius (m)
SP=pi*rp^2;                           %Portens effektive Areal (m^2)
pRMS=((rho*SP*(2*pi*f).^2)/(4*pi*r)); %xmax/sqrt(2);
Lp=.15;                               %Længden på porten (m);
Map=(rho/SP)*(Lp+1.5*sqrt(SP/pi));    %Massen ved porten

%% Beregninger 
v=(Bl)./(2*pi*f.*Map);          %Volumenhastighed
q=SP*v;
rR=sqrt(rd^2+4*h^2);                 %Reflekteret lydafstand (m)

fR=c/(2*(rR-rd));                    %Portens Resonansfrekvens (Hz)
%p=j.*((rho.*f.*q)/(2*rd)).*...
%    (1+(rd/rR).*D*exp(-j*k*(rR-rd)));%Trykbidrag fra overfladerefleksion
p=j*((rho*f)/r).*q;
semilogx(f,(p))