clear;

%% Indlæsning af data
impulseResponse = readtable('ImpulsRespons');
timeScale = table2array(impulseResponse(1:end, 1));
Response = table2array(impulseResponse(1:end, 2));

%% Plot
figure(1)
plot(timeScale, Response)