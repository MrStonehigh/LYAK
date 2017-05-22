%% Refleksion
clc,clear,close all;
%% Parametre FW168 MIDWOOFER
Re=7.2;                              %DC-Modstand (ohm)
Mms=14.7e-3;                         %Masse af Bevægelige system (kg)
Bl=8.2;                              %Kraftfaktor (Tm)
SD=119e-4;                           %Membranens effektive Areal (m^2)
Cms=0.821e-3;                           %Eftergivelighed af styr (m/N)
Qms=3.246;                              %Mekanisk Godhed
Rms=sqrt(Mms/Cms)/Qms;                  %Mekanisk tabsmodstand (ohm)


%% Fysiske Parametre

Ug=2.75;                             %Påtrykt spænding (V)
rho=1.18;                            %Air Mass Density (kg/m3)
f=1:10000;                           %Frequency (Hz)
pRef=20e-6;                          %Referencetryk (pa)
rd=1;                                %Distance to Microphone (m)
c=345;                               %Lydens hastighed (m/s)
h=.20;                               %Højtalerens højde ift gulv (m)
s=j*2*pi*f;                          %Laplace operator
k=2*pi*f./c;                         %Bølgetallet


%% Retningsvirkning

a=sqrt(SD/pi);                       %Enhedsradius (m) 
ka=(2*pi*f*a)./c;                    %Spredningsfaktor 
rR=sqrt((rd^2)+4*(h^2));             %Reflekteret lydafstand (m) 
v=(Bl*Ug)./(2*pi*f*Mms*Re);          %Membranens hastighed (m/s) ?? falder?!
%v=((Bl/Mms)*s)./...
%    ((s.^2)+(((Bl)^2)/(Mms*Re)+Rms/Mms)*s+1/(Mms*Cms))*Ug/Re;
q=SD*v;                              %Volumenhastighed (m3/s) 
sinteta=(2*h)/rR;                    %sin(teta) 
teta=asin(sinteta)

%{
J=0;
for m=1:50
    J=J+(((-1)^m)/(factorial(m)*factorial(m+1))).*(((((teta))/2)).^(2*m+1));
end
%J=sum(J)
%}
J=besselj(1,ka*sinteta);              %Besselfunktionen
D=((2*J)./(ka*sinteta));             %Direktivitet 

%% Beregninger 
%AFSNIT OM REFLEKSION
pD=j.*(rho*f.*q)/(2*rd).*exp(-j*k*rd);
%pR=j*((rho*f.*q)/(2*rR)).*exp(-j*k*rR);
%p=pD+pR;
p=j*((rho*f.*q)./(2*rd)).*(1+(rd/rR).*(D).*exp(-j*k*(rR-rd)));

LR=20*log10(abs(p)/pRef);
%LR=mag2db(abs(p));
figure,
semilogx(LR)
axis([0 f(end) min(LR) max(LR)])