clear all, close all, clc

alfa=0.1;
w=0:0.001:1-0.001;
z=exp(1i*w);
PSD(z)=(1-alfa^2)./((1-alfa*z).*(1-alfa*z))

figure()
plot(w,PSD(z))