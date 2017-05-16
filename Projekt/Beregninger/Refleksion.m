%% Refleksion

%% Parametre FW168 MIDWOOFER
Re=7.2;                                %DC-Modstand (ohm)
f3=48;
Le=Re/(2*pi*f3);                       %Svingspolens Selvinduktion (H)
Mms=14.7%e-3;                              %Masse af Bev�gelige system (kg)
Cms=0.821%e-3;                             %Eftergivelighed af styr (mm/N)
fs=45;                                 %Resonansfrekvens (Hz)
Qms=3.246;                             %Mekanisk Godhed
Qes=0.452;                             %Elektrisk Godhed
Rms=(1/Qms)*sqrt(Mms/Cms);             %Mekanisk tabsmodstand (ohm)
Vas=16.5e-3;                           %�kvivalent Volumen (L)
Bl=8.2;                                %Kraftfaktor (Tm)
SD=119e-2;                             %Membranens effektive Areal (m^2)
Xmax=4.6e-3;                           %Maksimal Line�r Bev�gelse (m)
%S=87.3;                               %F�lsomhed (dB)

%% Fysiske Parametre
rho=1.18;                            %Air Mass Density (kg/m3)
f=1:10000;                           %Frequency (Hz)
rd=1;                                %Distance to Microphone (m)
v=(Bl*Ug)./(2*pi*f*Mms*Re);           %Volumenhastighed
q=SD*v;
D=1;

k=(2*pi*f)/c;                        %B�lgetallet
h=0.1;                               %H�jtalerens h�jde ift gulv (m)
rR=sqrt(rd^2+4*h^2);                 %Reflekteret lydafstand (m)
%% Beregning 
p=j.*((rho.*f.*q)/(2*rd)).*(1+(rd/rR).*D*exp(-j*k*(rR-rd)));

semilogx(f,mag2db(p))