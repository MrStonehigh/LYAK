%% LYAK Projekt - Beregninger af Højtalerkabinet
clc,clear,close all;


%% Fysiske Parametre
rho=1.18;                            %Air Mass Density (kg/m3)
c=345;                               %Speed of sound(m/s)
pREF=20e-6;                          %Tryk-reference (pa)
Ug=2.75;                             %Påtrykt Spænding (V)
f=10:1000;                          %Frekvens (Hz)
s=j*2*pi*f;                          %Laplace operator
%f1=c/(2*pi*r);                      %Grænse for massestyret system
                                     %(Herover Usikkert)
%% Parametre FW168 MIDWOOFER
Re=7.2;                                %DC-Modstand (ohm)
f3=48;
Le=Re/(2*pi*f3);                       %Svingspolens Selvinduktion (H)
Mms=14.7%e-3;                              %Masse af Bevægelige system (kg)
Cms=0.821%e-3;                             %Eftergivelighed af styr (mm/N)
fs=45;                                 %Resonansfrekvens (Hz)
Qms=3.246;                             %Mekanisk Godhed
Qes=0.452;                             %Elektrisk Godhed
Rms=(1/Qms)*sqrt(Mms/Cms);             %Mekanisk tabsmodstand (ohm)
Vas=16.5e-3;                           %Ækvivalent Volumen (L)
Bl=8.2;                                %Kraftfaktor (Tm)
SD=119e-2;                             %Membranens effektive Areal (m^2)
Xmax=4.6e-3;                           %Maksimal Lineær Bevægelse (m)
%S=87.3;                               %Følsomhed (dB)


%% Rum- & Måleparametre
r=1;                                %Distance til Mikrofon (m)
Fa=(Bl*Ug)/(Re*SD);                 %Akustisk kraft
Cab=Vas/(rho*c^2);                  % Akustik eftergivelighed af luftvoluminet
Rae=(Bl)^2/(Re*SD^2);               % Electrical DC resistance.
Mas=Mms/(SD^2);                     % Driver moving mass (kg).
Cas=Cms*SD^2;                       % Driver compliance (m/N)
Ras=Rms/SD^2;                       % Driver mechanical loss (Ns/m).
%RAL=10e4;                          % Cabinet losses (Ns/m5).
RP=0.0025;                            % Port radius (m).
SP=pi*RP^2;                         % Areal af Port (m2)
LX=0.15;                               %Port længde (m)
MMP=(rho*SP)*(LX+1.5*sqrt(SP/pi));
%MAP=MMP/SP^2;                       % Akustisk masse af luften i porten (kg) 
MAP=(rho/SP)*(LX+1.46*sqrt(SP/pi));
qF=Fa./(Rae+s*Mas+1./(s*Cas)+Ras+1./(s*Cab+1./(s*MAP)));
qP=-qF.*(1./(s*Cab))./(1./(s*Cab)+s*MAP);
pT=rho*s.*(qF+qP)/(2*pi*r); 
pF=rho*s.*qF/(2*pi*r); 
pP=rho*s.*qP/(2*pi*r);
LT=20*log10(abs(pT)/pREF); 
LD=20*log10(abs(pF)/pREF); 
LP=20*log10(abs(pP)/pREF); 

hold on, grid on
semilogx(f,LT,'-r','LineWidth',2)
semilogx(f,LD,'-g','LineWidth',1)
semilogx(f,LP,'-b','LineWidth',1);
legend('Samlet','Enhed','Port')
  hold off
  
Cmb=Vas/(rho*c^2*SD^2);
CRES=Cms*Cmb/(Cms+Cmb); 
FC=1/(2*pi*sqrt(Mms*CRES)); 
FP=1/(2*pi*sqrt(MAP*Cab)); 
QTS=sqrt(Mms/CRES)/(Bl^2/Re+Rms); 
QP=Rae*sqrt(Cab/MAP);

text(11,97, ['VB=' num2str(1000*Vas) 'liter'])
text(11,95, ['FC=' num2str(round(FC)) 'Hz'])
text(11,93, ['FP=' num2str(round(FP)) 'Hz'])
text(11,91, ['QTS=' num2str(round(100*QTS)/100)]) 
text(11,89, ['QP=' num2str(round(100*QP)/100)]) 
text(11,85, ['UG=' num2str(round(Ug)) ' V']) 
text(11,83, ['r=' num2str(round(r)) ' m']) 
text(11,79, ['RP=' num2str(RP) ' m'])
text(11,77, ['LP=' num2str(LX) ' m'])
