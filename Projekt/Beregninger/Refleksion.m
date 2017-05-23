%% Refleksion
clc,clear,close all;

%% Ændring af Måleparametre

rd=1;                                %Distance to Microphone (m)
h=.2;                                %Højtalerens højde ift gulv (m)

%% Parametre FW168 MIDWOOFER
Re=7.2;                              %DC-Modstand (ohm)
Mms=14.7e-3;                         %Masse af Bevægelige system (kg)
Bl=8.2;                              %Kraftfaktor (Tm)
SD=119e-4;                           %Membranens effektive Areal (m^2)
Cms=0.821e-3;                        %Eftergivelighed af styr (m/N)
Qms=3.246;                           %Mekanisk Godhed
Rms=sqrt(Mms/Cms)/Qms;               %Mekanisk tabsmodstand (ohm)


%% Fysiske Parametre

Ug=2.75;                             %Påtrykt spænding (V)
rho=1.18;                            %Air Mass Density (kg/m3)
f=1:10000;                           %Frequency (Hz)
pRef=20e-6;                          %Referencetryk (pa)
c=345;                               %Lydens hastighed (m/s)
s=j*2*pi*f;                          %Laplace operator
k=2*pi*f/c;                          %Bølgetallet


%% Retningsvirkning

a=sqrt(SD/pi);                       %Enhedsradius (m) 
ka=(2*pi*f*a)./c;                    %Spredningsfaktor 
rR=sqrt((rd^2)+4*(h^2));             %Reflekteret lydafstand (m) 
           
v=abs(((Bl/Mms)*s)./...
((s.^2)+(((Bl)^2)/(Mms*Re)+Rms/Mms)...
    *s+1/(Mms*Cms))*Ug/Re);          %Membranens hastighed (m/s)

q=SD*v;                              %Volumenhastighed (m3/s) 
sinteta=(2*h)/rR;                    %sin(teta) 

J=besselj(1,ka*sinteta);             %Besselfunktionen 
D=((2*J)./(ka*sinteta));             %Direktivitet 

%% Beregninger 
%AFSNIT OM REFLEKSION
pD=j.*(rho*f.*q)/(2*rd).*exp(-j*k*rd);          %Direkte lydtryk (pa)
pR=j*((rho*f.*q)/(2*rR)).*exp(-j*k*rR);         %Reflekteret bidrag (pa)
%p=pD+pR;                                       %Samlet, u. direktivitet

p=j*((rho*f.*q)/(2*rd)).*(1+(rd/rR)*(D)...
    .*exp(-j*k*(rR-rd)));                       %Samlet Lydtryk (pa)

LD=20*log10(abs(pD)/pRef);                      %Direkte (dB)
LR=20*log10(abs(pR)/pRef);                      %Reflekteret (dB) 
L=20*log10(abs(p)/pRef);                        %Samlet (dB)


figure,
semilogx(L); title('Lydtryk fra højtalerenhed')
hold on, grid on
semilogx(LD);
semilogx(LR);
axis([10 f(end) min(L) max(L)])
legend('Samlet','Direkte','Reflekteret');
xlabel('Frekvens (Hz)');
ylabel('SPL (dB)');

figure, 
semilogx(L-LD); title('Refleksionsbidrag')
xlabel('Frekvens (Hz)');
ylabel('SPL (dB)');
