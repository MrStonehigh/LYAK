%% Noget andet
clc
fs=48000;
top=fs/4;
input=MatRecData(1:top,2);
R=input*input';
P=trace(R);
mu=1/(3*P)
P_A=0;
P_A=P_A+input.*input;
mu_A=1/(3*P_A)
