%% Samlet Bidrag

clc,clear,close all;

%%
Refleksion;
Kabinet;

Lfinal=LT+Lsolo;
figure,
semilogx(f,Lfinal(1,:),'linewidth',2), hold on, grid on, title('Lydtryk i afstanden rD=1m');
semilogx(f,LT,'linewidth',2);
legend('Bas-refleks+Refleksionsbidrag v. h=0.2m','Bas-refleks alene')
xlabel('Frekvens (Hz)');
ylabel('dB SPL');

