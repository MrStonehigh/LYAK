%% LYAK Projekt - Beregninger af Rumparametre

clc,clear, close all;

%%

H=2.5;                  %Rummets Højde  (m)
L=5.8;                  %Rummets Længde (m)
B=4.8;                  %Rummets Bredde (m)

a=0.015                 %Gennemsnitlig Absorptionskoefficient
m=0.0011;

V=H*L*B;
S=a*(2*H+2*L+2*B);

T60=0.16*(V/(4*m*V-S*log(1-a)))



H=1+alpha0/(1-rho^2*exp(-s*dt))