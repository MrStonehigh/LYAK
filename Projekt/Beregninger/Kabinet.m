%% LYAK Projekt - Beregninger af Højtalerkabinet
clc,clear,close all;


%% Fysiske Parametre
rho=1.18;                            %Air Mass Density (kg/m3)
c=345;                               %Speed of sound(m/s)
pREF=20e-6;                          %Tryk-reference
Ug=5;
Fresponse=40:40000;
s=j*2*pi*Fresponse;

%% Parametre FW168 MIDWOOFER
Re=7.2;                             %DC-Modstand
Le=Re/(2*pi*54);                    %Svingspolens Selvinduktion f3=54Hz
Mms=014.7;                          %Masse af Bevægelige system
Cms=0.821;                          %Eftergivelighed af styr
fs=45; %1/(2*pi*sqrt(Mms*Cms));     %Resonansfrekvens
Qms=3.246;  %(1/Rms)*sqrt(Mms/Cms); %Mekanisk Godhed
Qes=0.452;                          %Elektrisk Godhed
Rms=0;                              %Mekanisk tabsmodstand
Vas=16.5;%L                         %Ækvivalent Volumen
Bl=8.2;                             %Kraftfaktor
SD=119;                             %Membranens effektive Areal
Xmax=4.6;                           %Maksimal Lineær Bevægelse
S=87.3;                             %Følsomhed


%% Rum- & Måleparametre
R=1;                                %Distance til Mikrofon
FA=(Bl*Ug)/(Re*SD);                 %Akustisk kraft
CAB=Vas/(rho*c^2);                   % Box compliance.
RAE=(Bl)^2/(Re*SD^2);               % Electrical DC resistance.
MAS=Mms/(SD^2);                     % Driver moving mass (kg).
CAS=Cms*SD^2;                       % Driver compliance (m/N)
RAS=Rms/SD^2;                       % Driver mechanical loss (Ns/m).
RAL=10e4;                           % Cabinet losses (Ns/m5).
RP=0.015;                           % Port radius (m).
SP=pi*RP^2;                         % Port area (m2)
LX=0.200;
MMP=(rho*SP)*(LX+1.5*sqrt(SP/pi));
MAP=MMP/SP^2; % Driver moving mass (kg) 
qF=FA./(RAE+s*MAS+1./(s*CAS)+RAS+1./(s*CAB+1./(s*MAP)));
qP=-qF.*(1./(s*CAB))./(1./(s*CAB)+s*MAP);
pT=rho*s.*(qF+qP)/(2*pi*R); 
pF=rho*s.*qF/(2*pi*R); 
pP=rho*s.*qP/(2*pi*R);
LT=20*log10(abs(pT)/pREF); 
LD=20*log10(abs(pF)/pREF); 
LP=20*log10(abs(pP)/pREF); 

semilogx(Fresponse,LT,'-r','LineWidth',1 ...
    Fresponse,LD,'-g','LineWidth',1, ...
    Fresponse,LP,'-b','LineWidth',1) 
legend('Samlet','Enhed','Port')
CMB=Vas/(rho*c^2*SD^2); 
CRES=Cms*CMB/(Cms+CMB); 
FC=1/(2*pi*sqrt(Mms*CRES)); 
FP=1/(2*pi*sqrt(MAP*CAB)); 
QTS=sqrt(Mms/CRES)/(Bl^2/Re+Rms); 
QP=RAE*sqrt(CAB/MAP);

text(11,97, ['VB=' num2str(1000*Vas) 'liter'])
text(11,95, ['FC=' num2str(round(FC)) 'Hz'])
text(11,93, ['FP=' num2str(round(FP)) 'Hz'])
text(11,91, ['QTS=' num2str(round(100*QTS)/100)]) 
text(11,89, ['QP=' num2str(round(100*QP)/100)]) 
text(11,85, ['UG=' num2str(round(Ug)) ' V']) 
text(11,83, ['R=' num2str(round(R)) ' m']) 
text(11,79, ['RP=' num2str(RP) ' m'])
text(11,77, ['LP=' num2str(LX) ' m'])
