clear;

%% Indlæsning af impulsresponsdata
impulseResponse = readtable('ImpulsRespons');
timeScale = table2array(impulseResponse(1:24000, 1));
Response = table2array(impulseResponse(1:24000, 2));

%% Omregning til dB:SPL
p0 = 20E-6;
Lp = 20 * log10(Response ./ p0);

%% Plot af impulsrespons
figure(1)
plot(timeScale, Lp)
grid on
xlabel('Tid [s]')
ylabel('Sound Pressure Level [dB]')

%% Indlæsning af data - Bottom
% Direct
Bottom20DirectTable = readtable('Bottom/Height20Direct');
Bottom40DirectTable = readtable('Bottom/Height40Direct');
Bottom60DirectTable = readtable('Bottom/Height60Direct');
Bottom80DirectTable = readtable('Bottom/Height80Direct');
Bottom100DirectTable = readtable('Bottom/Height100Direct');

% Listen
Bottom20ListenTable = readtable('Bottom/Height20Listen');
Bottom40ListenTable = readtable('Bottom/Height40Listen');
Bottom60ListenTable = readtable('Bottom/Height60Listen');
Bottom80ListenTable = readtable('Bottom/Height80Listen');
Bottom100ListenTable = readtable('Bottom/Height100Listen');


%% Indlæsning af data - Front
% Direct
Front20DirectTable = readtable('Front/Height20Direct');
Front40DirectTable = readtable('Front/Height40Direct');
Front60DirectTable = readtable('Front/Height60Direct');
Front80DirectTable = readtable('Front/Height80Direct');
Front100DirectTable = readtable('Front/Height100Listen');

% Listen
Front20ListenTable = readtable('Front/Height20Listen');
Front40ListenTable = readtable('Front/Height40Listen');
Front60ListenTable = readtable('Front/Height60Listen');
Front80ListenTable = readtable('Front/Height80Listen');
Front100ListenTable = readtable('Front/Height100Listen');

%% Indlæsning af data - Side
% Direct
Side20DirectTable = readtable('Side/Height20Direct');
Side40DirectTable = readtable('Side/Height40Direct');
Side60DirectTable = readtable('Side/Height60Direct');
Side80DirectTable = readtable('Side/Height80Direct');
Side100DirectTable = readtable('Side/Height100Listen');

% Listen
Side20ListenTable = readtable('Side/Height20Listen');
Side40ListenTable = readtable('Side/Height40Listen');
Side60ListenTable = readtable('Side/Height60Listen');
Side80ListenTable = readtable('Side/Height80Listen');
Side100ListenTable = readtable('Side/Height100Listen');

%% Frekvens (ens for alle målinger)
frequency = table2array(Bottom20DirectTable(1:end, 1));

%% Bottom - Direct
Bottom20Direct = table2array(Bottom20DirectTable(1:end, 2));
Bottom40Direct = table2array(Bottom40DirectTable(1:end, 2));
Bottom60Direct = table2array(Bottom60DirectTable(1:end, 2));
Bottom80Direct = table2array(Bottom80DirectTable(1:end, 2));
Bottom100Direct = table2array(Bottom100DirectTable(1:end, 2));


%% Bottom - Listen
Bottom20Listen = table2array(Bottom20ListenTable(1:end, 2));
Bottom40Listen = table2array(Bottom40ListenTable(1:end, 2));
Bottom60Listen = table2array(Bottom60ListenTable(1:end, 2));
Bottom80Listen = table2array(Bottom80ListenTable(1:end, 2));
Bottom100Listen = table2array(Bottom100ListenTable(1:end, 2));


%% Front - Direct
Front20Direct = table2array(Front20DirectTable(1:end, 2));
Front40Direct = table2array(Front40DirectTable(1:end, 2));
Front60Direct = table2array(Front60DirectTable(1:end, 2));
Front80Direct = table2array(Front80DirectTable(1:end, 2));
Front100Direct = table2array(Front100DirectTable(1:end, 2));

%% Front - Listen
Front20Listen = table2array(Front20ListenTable(1:end, 2));
Front40Listen = table2array(Front40ListenTable(1:end, 2));
Front60Listen = table2array(Front60ListenTable(1:end, 2));
Front80Listen = table2array(Front80ListenTable(1:end, 2));
Front100Listen = table2array(Front100ListenTable(1:end, 2));


%% Side - Direct
Side20Direct = table2array(Front20DirectTable(1:end, 2));
Side40Direct = table2array(Front40DirectTable(1:end, 2));
Side60Direct = table2array(Front60DirectTable(1:end, 2));
Side80Direct = table2array(Front80DirectTable(1:end, 2));
Side100Direct = table2array(Front100DirectTable(1:end, 2));

%% Side - Listen
Side20Listen = table2array(Side20ListenTable(1:end, 2));
Side40Listen = table2array(Side40ListenTable(1:end, 2));
Side60Listen = table2array(Side60ListenTable(1:end, 2));
Side80Listen = table2array(Side80ListenTable(1:end, 2));
Side100Listen = table2array(Side100ListenTable(1:end, 2));

load('Lfinal1', ');

%% Plot af frekvenskarakteristik - Direct
figure(2)
semilogx(frequency, Front20Direct)
hold on
semilogx(frequency, Side20Direct)
hold on
semilogx(frequency, Bottom20Direct)
hold on
semilogx(frequency, Simulering)
grid on
axis tight
legend('Forsiderefleks', 'Siderefleks', 'Undersiderefleks', 'Simulering', 'Location', 'southeast')
%title('Basrefleksen placeret forskellige steder (Direkte)')
xlabel('Frekvens [Hz]')
ylabel('Gain [dBV]')


%% Plot af frekvenskarakteristik - Listen
figure(3)
semilogx(frequency, Front20Listen)
hold on
semilogx(frequency, Side20Listen)
hold on
semilogx(frequency, Bottom20Listen)
hold on
%semilogx(frequency, Simulering)
grid on
axis tight
legend('Forsiderefleks', 'Siderefleks', 'Undersiderefleks', 'Simulering', 'Location', 'southeast')
%title('Basrefleksen placeret forskellige steder (Lytteafstand)')
xlabel('Frekvens [Hz]')
ylabel('Gain [dBV]')