%% LYAK Projekt - Beregninger af Højtalerkabinet
clc,clear,close all;


%% Fysiske Parametre
Ug=2.75;                                %Påtrykt Spænding (V)
rho=1.18;                               %Air Mass Density (kg/m3)
c=345;                                  %Speed of sound(m/s)
pREF=20e-6;                             %Tryk-reference (pa)

f=0:1000;                               %Frekvens (Hz)
s=j*2*pi*f;                             %Laplace operator

%% Parametre FW168 MIDWOOFER
Re=7.2;                                 %DC-Modstand (ohm)
f3=48;
Le=Re/(2*pi*f3);                        %Svingspolens Selvinduktion (H)
Mms=14.7e-3;                            %Masse af Bevægelige system (kg)
Cms=0.821e-3;                           %Eftergivelighed af styr (m/N)
Qms=3.246;                              %Mekanisk Godhed
Rms=sqrt(Mms/Cms)/Qms;                  %Mekanisk tabsmodstand (ohm)
Vas=16.5e-3;                            %Ækvivalent Volumen (L)
Bl=8.2;                                 %Kraftfaktor (Tm)
SD=119e-4;                              %Membranens effektive Areal (m^2)

%fs=45;                                 %Opgivet Resonansfrekvens (Hz)
%Xmax=4.6e-3;                           %Maksimal Lineær Bevægelse (m)
%S=87.3;                                %Følsomhed (dB)
%Qes=0.452;                             %Elektrisk Godhed
%% Impedans-overførsel

r=1;                                    %Distance til Mikrofon (m)
Fa=(Bl*Ug)/(Re*SD);                     %Akustisk kraft
Cab=Vas/(rho*c^2);                      %Akustik eftergivelighed af luftvoluminet
Rae=(Bl^2)/(Re*SD^2);                   %Electrical DC resistance.
Mas=Mms/(SD^2);                         %Driver moving mass (kg).
Cas=Cms*(SD^2);                         %Driver compliance (m/N)
Ras=Rms/SD^2;                           %Driver mechanical loss (Ns/m).
RP=0.025;                               %Port radius (m).
SP=pi*RP^2;                             %Areal af Port (m2)
%LX=0.15;                                %Port længde (m)
LX=0.07;
MAP=(rho/SP)*(LX+1.46*sqrt(SP/pi));     % Akustisk masse af luften i porten (kg)

%fp=1/(2*pi*sqrt(MAP*Cab));             %Resonansfrekvens for port
%LX=(1.4*100e3*SP)/(rho*((2*pi*fp)^2)...%Beregnet længde af porten
%    *Vas)-1.46*sqrt(SP/pi);

%% Beregning af Volumenhastighed & Lydtryk
qF=Fa./(Rae+s*Mas+1./(s*Cas)+Ras+1./(s*Cab+1./(s*MAP))); %Volumenhastighed Front
qP=-qF.*(1./(s*Cab))./(1./(s*Cab)+s*MAP);                %Volumenhastighed Port

pT=rho*s.*(qF+qP)/(2*pi*r);                              %Lydtryk Total (pa)
pF=rho*s.*qF/(2*pi*r);                                   %Lydtryk Front (pa)
pP=rho*s.*qP/(2*pi*r);                                   %Lydtryk Port  (pa)

LT=20*log10(abs(pT)/pREF);                               %Lydtryk Total (dB)
LD=20*log10(abs(pF)/pREF);                               %Lydtryk Enhed (dB)
LP=20*log10(abs(pP)/pREF);                               %Lydtryk Port  (dB)

figure,
 
semilogx(f,LT,'-r','LineWidth',2), hold on, grid on
semilogx(f,LD,'-g','LineWidth',1)
semilogx(f,LP,'-b','LineWidth',1);
legend('Samlet','Enhed','Port')
  hold off
  
Cmb=Vas/(rho*c^2*SD^2);
Cres=Cms*Cmb/(Cms+Cmb);
FC=1/(2*pi*sqrt(Mas*(Cas*Cab)/(Cas+Cab)));         %Enheds-resonans
FP=1/(2*pi*sqrt(MAP*Cab));                         %Port-resonans
QTS=sqrt(Mms/Cres)/(Bl^2/Re+Rms);                  %Godhed af svingende system

text(4,95, ['UG=' num2str((Ug)) ' V']) 
text(4,91, ['Vas=' num2str(1000*Vas) 'liter'])
text(4,87, ['fc=' num2str(round(FC)) 'Hz'])
text(4,83, ['fp=' num2str(round(FP)) 'Hz'])
text(4,79, ['QTS=' num2str(round(100*QTS)/100)]) 
%text(11,89, ['QP=' num2str(round(100*QP)/100)]) 
text(4,75, ['Måleafstand=' num2str(round(r)) ' m']) 
text(4,71, ['rP=' num2str(RP) ' m'])
text(4,67, ['lP=' num2str(LX) ' m'])

%% Yderligere Impedansparametre

QP=Rae*sqrt(Cab/MAP);
