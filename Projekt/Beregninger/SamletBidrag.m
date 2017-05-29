%% Samlet Bidrag

%clc,clear,close all;

%%
Refleksion;
Kabinet;
%Lsolo1;Lsolo3;Lsolo3;

Lfinal1=LT+Lsolo1;
Lfinal2=LT+Lsolo2;
Lfinal3=LT+Lsolo3;

figure,
semilogx(f,Lfinal1,'linewidth',2), hold on, grid on, title('Lydtryk i afstanden rD=1m');
semilogx(f,Lfinal2,'linewidth',1.5),
semilogx(f,Lfinal3,'linewidth',1),
semilogx(f,LT,'linewidth',2);
legend('Bas-refleks+Refleksionsbidrag v. h=0.2m',...
    'Bas-refleks+Refleksionsbidrag v. h=0.4m', ...
    'Bas-refleks+Refleksionsbidrag v. h=0.6m',...
    'Bas-refleks alene')
xlabel('Frekvens (Hz)');
ylabel('dB SPL');

