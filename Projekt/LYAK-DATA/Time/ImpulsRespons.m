clear;

%% Indlæsning af data
impulseResponse = readtable('ImpulsRespons');
timeScale = table2array(impulseResponse(1:12000, 1));
Response = table2array(impulseResponse(1:12000, 2));

%% Plot
figure(1)
plot(timeScale, Response)
grid on