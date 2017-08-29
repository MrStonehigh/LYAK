%% Refleksion
clc,clear,close all;
h=0;
for i=1:4
%% Ændring af Måleparametre

rd=1;                                %Distance to Microphone (m)
h=h+.2;                              %Højtalerens højde ift gulv (m)

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
rho=1.18;                            %Luftmassens Densitet (kg/m3)
f=10:10000;                          %Frekvens (Hz)
pRef=20e-6;                          %Referencetryk (pa)
c=345;                               %Lydens hastighed (m/s)
s=j*2*pi*f;                          %Laplace operator
k=2*pi*f/c;                          %Bølgetallet


%% Retningsvirkning

a=sqrt(SD/pi);                       %Enhedsradius (m) 
ka=(2*pi*f*a)./c;                    %Spredningsfaktor 
rR=sqrt((rd^2)+4*(h^2));             %Reflekteret lydafstand (m) 
fR=c/(2*(rR-rd));                    %Første Minimum (Hz)
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

LD(i,:)=20*log10(abs(pD)/pRef);                      %Direkte (dB)
LR(i,:)=20*log10(abs(pR)/pRef);                      %Reflekteret (dB) 
L(i,:)=20*log10(abs(p)/pRef);                        %Samlet (dB)

end


figure,
semilogx(L); title('Lydtryk fra højtalerenhed')
hold on, grid on
semilogx(LD);
semilogx(LR);
axis([10 f(end) min(L(1,:)) max(L(1,:))])
legend('Samlet','Direkte','Reflekteret');
xlabel('Frekvens (Hz)');
ylabel('SPL (dB)');


figure, 
semilogx(L(1,:)-LD(1,:),'LineWidth',3); title('Refleksionsbidrag')
hold on
semilogx(L(2,:)-LD(2,:),'LineWidth',2);
semilogx(L(3,:)-LD(3,:),'LineWidth',1.5);
semilogx(L(4,:)-LD(4,:));
axis([10 2.3e3 -20 10])
xlabel('Frekvens (Hz)');
ylabel('SPL (dB)');
legend('h=.2m','h=.4m','h=.6m','h=.8m')

Lsolo1=L(1,:)-LD(1,:);
Lsolo2=L(2,:)-LD(2,:);
Lsolo3=L(3,:)-LD(3,:);

save Lsolo1; save Lsolo2; save Lsolo3;
