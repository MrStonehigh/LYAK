%% Refleksion
clc,clear,close all;
%% Parametre FW168 MIDWOOFER
Re=7.2;                                %DC-Modstand (ohm)
Mms=14.7e-3;                           %Masse af Bevægelige system (kg)
Bl=8.2;                                %Kraftfaktor (Tm)
SD=119e-4;                             %Membranens effektive Areal (m^2)
Xmax=4.6e-3;                           %Maksimal Lineær Bevægelse (m)


%% Fysiske Parametre

Ug=2.75;                             %Påtrykt spænding (V)
rho=1.18;                            %Air Mass Density (kg/m3)
f=0:1000;                            %Frequency (Hz)
pRef=20e-6;                          %Referencetryk (pa)
rd=1;                                %Distance to Microphone (m)
c=343;                               %Lydens hastighed (m/s)
h=.20;                               %Højtalerens højde ift gulv (m)


%% Retningsvirkning

a=sqrt(SD/pi);                       %Enhedsradius (m)
ka=(2*pi*f.*a)/c;                    %Spredningsfaktor
rR=sqrt(rd^2+4*h^2);                 %Reflekteret lydafstand (m)
v=(Bl*Ug)./(2*pi*f*Mms*Re);          %Membranens hastighed (m/s)
q=SD*v;                              %Volumenhastighed (m3/s)
sinteta=(2*h)/rR;                    %sin(teta)

J=zeros(length(f));
for k=1:f(end)+1
    J(k)=sum((((-1)^k)/(factorial(k)*factorial(1+k)))*((ka*sinteta)/2).^(2*k+1));
end
J=sum(J(:));
D=(2*J)./(ka*sinteta);             %Spredning 

%% Beregninger 
k=2*pi*f./c;                                    %Bølgetallet

pR=j.*((rho*f.*q)/(2*rd)).*(1+(rd/rR)*D.*exp(-j*k*(rR-rd)));
LR=20*log10(abs(pR)/pRef);

figure,
semilogx(LR)