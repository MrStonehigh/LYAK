%LYAK L7
clc, clear
%% 7.2

Re=3.6;
Bl=2.9;
SD=20;
Mms=2.5;
rho=1.18;
r=30;
pref=20*10^-6;

%% 500Hz

f=500;
w=2*pi*f; 
U_grms=1.489; %V


p_2pi_norm=(rho*SD*Bl)/(2*pi*r*Mms*Re)*U_grms;
v=(Bl*U_grms)/(2*pi*f*Mms*Re)
q=SD*v;

p_2pi=((rho*f)/r)*q

L500=20*log10(rms(p_2pi)/pref)
Lm500=86.2;
%Beregnet= 69.55 dB
%målt=86,2dB


%% 1000Hz

f=1000;
w=2*pi*f; 
U_grms=1.182; %V


p_2pi_norm=(rho*SD*Bl)/(2*pi*r*Mms*Re)*U_grms;
v=(Bl*U_grms)/(2*pi*f*Mms*Re)
q=SD*v;

p_2pi=((rho*f)/r)*q

L1000=20*log10(rms(p_2pi)/pref)
Lm1000=87.4;

%Beregnet= 67.5471 dB
%målt=87,4dB

%% 1500Hz

f=1500;
w=2*pi*f; 
U_grms=0.623; %V


p_2pi_norm=(rho*SD*Bl)/(2*pi*r*Mms*Re)*U_grms;
v=(Bl*U_grms)/(2*pi*f*Mms*Re)
q=SD*v;

p_2pi=((rho*f)/r)*q

L1500=20*log10(rms(p_2pi)/pref)
Lm1500=82.5;

%Beregnet= 61.9845 dB
%målt=82,5dB

%% 2000Hz

f=2000;
w=2*pi*f; 
U_grms=0.700; %V


p_2pi_norm=(rho*SD*Bl)/(2*pi*r*Mms*Re)*U_grms;
v=(Bl*U_grms)/(2*pi*f*Mms*Re)
q=SD*v;

p_2pi=((rho*f)/r)*q

L2000=20*log10(rms(p_2pi)/pref)
Lm2000=84.5;
%Beregnet= 62.9967 dB
%målt=84,5dB


%% 2500Hz

f=2500;
w=2*pi*f; 
U_grms=0.697; %V


p_2pi_norm=(rho*SD*Bl)/(2*pi*r*Mms*Re)*U_grms;
v=(Bl*U_grms)/(2*pi*f*Mms*Re)
q=SD*v;

p_2pi=((rho*f)/r)*q

L2500=20*log10(rms(p_2pi)/pref)
Lm2500=81.1;
%Beregnet= 62.9594 dB
%målt=81,1dB


%% 3000Hz

f=3000;
w=2*pi*f; 
U_grms=0.873; %V


p_2pi_norm=(rho*SD*Bl)/(2*pi*r*Mms*Re)*U_grms;
v=(Bl*U_grms)/(2*pi*f*Mms*Re)
q=SD*v;

p_2pi=((rho*f)/r)*q

L3000=20*log10(rms(p_2pi)/pref)
Lm3000=86.7;

%Beregnet= 64.9150 dB
%målt=86,7dB

%% 3500Hz

f=3500;
w=2*pi*f; 
U_grms=0.680; %V


p_2pi_norm=(rho*SD*Bl)/(2*pi*r*Mms*Re)*U_grms;
v=(Bl*U_grms)/(2*pi*f*Mms*Re)
q=SD*v;

p_2pi=((rho*f)/r)*q

L3500=20*log10(rms(p_2pi)/pref)
Lm3500=87.3;
%Beregnet= 62.7749 dB
%målt=87,3dB

%% 4000Hz

f=4000;
w=2*pi*f; 
U_grms=0.650; %V


p_2pi_norm=(rho*SD*Bl)/(2*pi*r*Mms*Re)*U_grms;
v=(Bl*U_grms)/(2*pi*f*Mms*Re)
q=SD*v;

p_2pi=((rho*f)/r)*q

L4000=20*log10(rms(p_2pi)/pref)
Lm4000=84;
%Beregnet= 62.3530 dB
%målt=84,0dB

%% 5000Hz

f=5000;
w=2*pi*f; 
U_grms=0.627; %V


p_2pi_norm=(rho*SD*Bl)/(2*pi*r*Mms*Re)*U_grms;
v=(Bl*U_grms)/(2*pi*f*Mms*Re)
q=SD*v;

p_2pi=((rho*f)/r)*q

L5000=20*log10(rms(p_2pi)/pref)
Lm5000=82.2;

%Beregnet= 62.0401 dB
%målt=82,2dB

%% 6000Hz

f=6000;
w=2*pi*f; 
U_grms=0.640; %V


p_2pi_norm=(rho*SD*Bl)/(2*pi*r*Mms*Re)*U_grms;
v=(Bl*U_grms)/(2*pi*f*Mms*Re)
q=SD*v;

p_2pi=((rho*f)/r)*q

L6000=20*log10(rms(p_2pi)/pref)
Lm6000=81.5;

%Beregnet= 62.2183 dB
%målt=81,5dB

%% 7000Hz

f=7000;
w=2*pi*f; 
U_grms=0.555; %V


p_2pi_norm=(rho*SD*Bl)/(2*pi*r*Mms*Re)*U_grms;
v=(Bl*U_grms)/(2*pi*f*Mms*Re)
q=SD*v;

p_2pi=((rho*f)/r)*q

L7000=20*log10(rms(p_2pi)/pref)
Lm7000=78.5;
%Beregnet= 62.9806 dB
%målt=78,5dB

%% 8000Hz

f=8000;
w=2*pi*f; 
U_grms=0.332; %V


p_2pi_norm=(rho*SD*Bl)/(2*pi*r*Mms*Re)*U_grms;
v=(Bl*U_grms)/(2*pi*f*Mms*Re)
q=SD*v;

p_2pi=((rho*f)/r)*q

L8000=20*log10(rms(p_2pi)/pref)
Lm8000=77.7;

%Beregnet= 56,5175 dB
%målt=77,7dB

%% 9000Hz

f=9000;
w=2*pi*f; 
U_grms=0.322; %V


p_2pi_norm=(rho*SD*Bl)/(2*pi*r*Mms*Re)*U_grms;
v=(Bl*U_grms)/(2*pi*f*Mms*Re)
q=SD*v;

p_2pi=((rho*f)/r)*q

L9000=20*log10(rms(p_2pi)/pref)
Lm9000=78.4;

%Beregnet= 56.2518 dB
%målt=78,4dB

%% 10000Hz

f=10000;
w=2*pi*f; 
U_grms=0.281; %V


p_2pi_norm=(rho*SD*Bl)/(2*pi*r*Mms*Re)*U_grms;
v=(Bl*U_grms)/(2*pi*f*Mms*Re)
q=SD*v;

p_2pi=((rho*f)/r)*q

L10000=20*log10(rms(p_2pi)/pref)
Lm10000=80;

%Beregnet= 55.0689 dB
%målt=80,0 dB

%% 12000Hz

f=12000;
w=2*pi*f; 
U_grms=0.201; %V


p_2pi_norm=(rho*SD*Bl)/(2*pi*r*Mms*Re)*U_grms;
v=(Bl*U_grms)/(2*pi*f*Mms*Re)
q=SD*v;

p_2pi=((rho*f)/r)*q

L12000=20*log10(rms(p_2pi)/pref)
Lm12000=72.5;

%Beregnet= 52.1586 dB
%målt=72,5dB

%% 14000Hz

f=14000;
w=2*pi*f; 
U_grms=0.133; %V


p_2pi_norm=(rho*SD*Bl)/(2*pi*r*Mms*Re)*U_grms;
v=(Bl*U_grms)/(2*pi*f*Mms*Re)
q=SD*v;

p_2pi=((rho*f)/r)*q

L14000=20*log10(rms(p_2pi)/pref)
Lm14000=69.9;

%Beregnet= 48.5718 dB
%målt=69.9dB

%% 16000Hz

f=16000;
w=2*pi*f; 
U_grms=0.121; %V


p_2pi_norm=(rho*SD*Bl)/(2*pi*r*Mms*Re)*U_grms;
v=(Bl*U_grms)/(2*pi*f*Mms*Re)
q=SD*v;

p_2pi=((rho*f)/r)*q

L16000=20*log10(rms(p_2pi)/pref)
Lm16000=71.7;

%Beregnet= 47.7504 dB
%målt=71.7dB

%% 18000Hz

f=18000;
w=2*pi*f; 
U_grms=0.088; %V


p_2pi_norm=(rho*SD*Bl)/(2*pi*r*Mms*Re)*U_grms;
v=(Bl*U_grms)/(2*pi*f*Mms*Re)
q=SD*v;

p_2pi=((rho*f)/r)*q

L18000=20*log10(rms(p_2pi)/pref)
Lm18000=72.1;

%Beregnet= 44.9844 dB
%målt=72.1dB

%% 20000Hz

f=20000;
w=2*pi*f; 
U_grms=0.056; %V


p_2pi_norm=(rho*SD*Bl)/(2*pi*r*Mms*Re)*U_grms;
v=(Bl*U_grms)/(2*pi*f*Mms*Re)
q=SD*v;

p_2pi=((rho*f)/r)*q

L20000=20*log10(rms(p_2pi)/pref)
Lm20000=77.3;

%Beregnet= 41.0585 dB
%målt=77.3dB

%%
L=[L500 L1000 L1500 L2000 L2500 L3000 L4000 L5000 L6000 L7000 L8000 L9000 L10000 L12000 L14000 L16000 L18000 L20000];
Lm=[Lm500 Lm1000 Lm1500 Lm2000 Lm2500 Lm3000 Lm4000 Lm5000 Lm6000 Lm7000 Lm8000 Lm9000 Lm10000 Lm12000 Lm14000 Lm16000 Lm18000 Lm20000];

figure, subplot(221),
plot(L);title('Beregnet karakteristik');

subplot(222),
plot(Lm);title('Målt karakteristik');
