%% LYAK Projekt - Beregninger af Lukket Højtalerkabinet
%clc,clear,close all;

r=1;                                    %Distance til Mikrofon (m)

%% Fysiske Parametre
Ug=2.75;                                %Påtrykt Spænding (V)
rho=1.18;                               %Air Mass Density (kg/m3)
c=345;                                  %Speed of sound(m/s)
pREF=20e-6;                             %Tryk-reference (pa)

f=10:10000;                               %Frekvens (Hz)
s=j*2*pi*f;                             %Laplace operator

%% Parametre FW168 MIDWOOFER
Re=7.2;                                 %DC-Modstand (ohm)
f3=48;
Le=Re/(2*pi*f3);                        %Svingspolens Selvinduktion (H)
Mms=14.7e-3;                            %Masse af Bevægelige system (kg)
Cms=0.821e-3;                           %Eftergivelighed af styr (m/N)
Qms=3.246;                              %Mekanisk Godhed
Rms=sqrt(Mms/Cms)/Qms;                  %Mekanisk tabsmodstand (ohm)
Vb=16.5e-3;                             %Ækvivalent Volumen (L)
Bl=8.2;                                 %Kraftfaktor (Tm)
SD=119e-4;                              %Membranens effektive Areal (m^2)

%fs=45;                                 %Opgivet Resonansfrekvens (Hz)
%Xmax=4.6e-3;                           %Maksimal Lineær Bevægelse (m)
%S=87.3;                                %Følsomhed (dB)
%Qes=0.452;                             %Elektrisk Godhed
%% Impedans-overførsel


Fa=(Bl*Ug)/(Re*SD);                     %Akustisk kraft
Cab=Vb/(rho*c^2);                      %Akustik eftergivelighed af luftvoluminet
Rae=(Bl^2)/(Re*SD^2);                   %Electrical DC resistance.
Mas=Mms/(SD^2);                         %Driver moving mass (kg).
Cas=Cms*(SD^2);                         %Driver compliance (m/N)
Ras=Rms/SD^2;                           %Driver mechanical loss (Ns/m).
RP=0.025;                               %Port radius (m).
SP=pi*RP^2;                             %Areal af Port (m2)
MAP=(rho/SP)*(LX+1.46*sqrt(SP/pi));     % Akustisk masse af luften i porten (kg)

fp=1/(2*pi*sqrt(MAP*Cab));             %Resonansfrekvens for port
%LX=(1.4*100e3*SP)/(rho*((2*pi*fp)^2)...%Beregnet længde af porten
%    *Vas)-1.46*sqrt(SP/pi);

%% Beregning af Volumenhastighed & Lydtryk

qF=Fa./(Rae+s*Mas+1./(s*Cas)+Ras+1./(s*Cab));             %Volumenhastighed Front
pF=rho*s.*qF/(2*pi*r);                                    %Lydtryk Front (pa)

LD=20*log10(abs(pF)/pREF);                               %Lydtryk Enhed (dB)

figure,
 
semilogx(f,LD,'-g','LineWidth',1)
xlabel('Frekvens (Hz)')
ylabel('dB SPL');
title('Frekvenskarakteristik for Lukket kabinet');
  
Cmb=Vb/(rho*c^2*SD^2);
Cres=Cms*Cmb/(Cms+Cmb);
FC=1/(2*pi*sqrt(Mas*(Cas*Cab)/(Cas+Cab)));         %Grænsefrekvens

text(15,89, ['UG=' num2str((Ug)) ' V']) 
text(15,88, ['Vas=' num2str(1000*Vb) 'liter'])
text(15,87, ['fc=' num2str(round(FC)) 'Hz'])
text(15,86, ['fp=' num2str(round(FP)) 'Hz']) 
text(15,84, ['Måleafstand=' num2str(round(r)) ' m']) 

