clear;

closeTable = readtable('close');
X = closeTable(1:end, 1);
Y = closeTable(1:end, 2);

plot(X, Y)