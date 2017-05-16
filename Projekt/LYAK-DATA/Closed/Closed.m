clear;

closeTable = readtable('close');
closeFreq = table2array(closeTable(1:end, 1));
closeGain = table2array(closeTable(1:end, 2));

farTable = readtable('far');
farFreq = table2array(farTable(1:end, 1));
farGain = table2array(farTable(1:end, 2));

figure(1)
semilogx(closeFreq, closeGain)
hold on
semilogx(farFreq, farGain)
grid on
axis([10 23E3 -100 -30])
legend('Tæt på', 'Langt fra')
title('Lukket kabinet')