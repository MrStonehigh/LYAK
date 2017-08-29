%% LYAK - Projekt
%  Frekvenskarakteristikker af h�jtalerkabinet
%  Alle frekvenskarakteristikker er m�lt i det lydd�de rum

clear;

%% Import af simuleringsv�rdier
LukketKabinetData = load('LukketKabinetData');
LukketKabinetArray = cell2mat(struct2cell(LukketKabinetData))';
 
LukketKabinetGain = LukketKabinetArray(1:22991, 1);
LukketKabinetFrequency = LukketKabinetArray(1:22991 , 2);

%% Indl�sning af data (Lukket kabinet)
closedCloseTable = readtable('Closed/Close');
closedFarTable = readtable('Closed/Far');


%% Indl�sning af data (basrefleks p� forside)
% Lang basrefleks
frontLongCloseTable = readtable('Front/Long/Close');
frontLongTubeTable = readtable('Front/Long/Tube');
frontLongFarTable = readtable('Front/Long/Far');

% Medium basrefleks
frontMediumCloseTable = readtable('Front/Medium/Close');
frontMediumTubeTable = readtable('Front/Medium/Tube');
frontMediumFarTable = readtable('Front/Medium/Far');

% Kort basrefleks
frontShortCloseTable = readtable('Front/Short/Close');
frontShortTubeTable = readtable('Front/Short/Tube');
frontShortFarTable = readtable('Front/Short/Far');


%% Indl�sning af data (Basrefleks p� siden)
% Lang basrefleks
sideLongCloseTable = readtable('Side/Long/Close');
sideLongTubeTable = readtable('Side/Long/Tube');
sideLongFarTable = readtable('Side/Long/Far');

% Medium basrefleks
sideMediumCloseTable = readtable('Side/Medium/Close');
sideMediumTubeTable = readtable('Side/Medium/Tube');
sideMediumFarTable = readtable('Side/Medium/Far');

% Kort basrefleks
sideShortCloseTable = readtable('Side/Short/Close');
sideShortTubeTable = readtable('Side/Short/Tube');
sideShortFarTable = readtable('Side/Short/Far');

%% Indl�sning af data (Basrefleks p� underside)
% Lang basrefleks
bottomLongCloseTable = readtable('Bottom/Long/Close');
bottomLongTubeTable = readtable('Bottom/Long/Tube');
bottomLongFarTable = readtable('Bottom/Long/Far');

% Medium basrefleks
bottomMediumCloseTable = readtable('Bottom/Medium/Close');
bottomMediumTubeTable = readtable('Bottom/Medium/Tube');
bottomMediumFarTable = readtable('Bottom/Medium/Far');

% Kort basrefleks
bottomShortCloseTable = readtable('Bottom/Short/Close');
bottomShortTubeTable = readtable('Bottom/Short/Tube');
bottomShortFarTable = readtable('Bottom/Short/Far');

%% Frekvens (ens for alle m�linger)
frequency = table2array(closedCloseTable(1:end, 1));
axLim = [10 23E3 -100 -30];

%% Gain-data (lukket kabinet)
closedClose = table2array(closedCloseTable(1:end, 2));
closedFar = table2array(closedFarTable(1:end, 2));


%% Gain-data (basrefleks p� forside)
% Lang basrefleks
frontLongClose = table2array(frontLongCloseTable(1:end, 2));
frontLongTube = table2array(frontLongTubeTable(1:end, 2));
frontLongFar = table2array(frontLongFarTable(1:end, 2));

% Medium basrefleks
frontMediumClose = table2array(frontMediumCloseTable(1:end, 2));
frontMediumTube = table2array(frontMediumTubeTable(1:end, 2));
frontMediumFar = table2array(frontMediumFarTable(1:end, 2));

% Kort basrefleks
frontShortClose = table2array(frontShortCloseTable(1:end, 2));
frontShortTube = table2array(frontShortTubeTable(1:end, 2));
frontShortFar = table2array(frontShortFarTable(1:end, 2));


%% Gain-data (basrefleks p� siden)
% Lang basrefleks
sideLongClose = table2array(sideLongCloseTable(1:end, 2));
sideLongTube = table2array(sideLongTubeTable(1:end, 2));
sideLongFar = table2array(sideLongFarTable(1:end, 2));

% Medium basrefleks
sideMediumClose = table2array(sideMediumCloseTable(1:end, 2));
sideMediumTube = table2array(sideMediumTubeTable(1:end, 2));
sideMediumFar = table2array(sideMediumFarTable(1:end, 2));

% Kort basrefleks
sideShortClose = table2array(sideShortCloseTable(1:end, 2));
sideShortTube = table2array(sideShortTubeTable(1:end, 2));
sideShortFar = table2array(sideShortFarTable(1:end, 2));


%% Gain-data (basrefleks p� underside)
% Lang basrefleks
bottomLongClose = table2array(bottomLongCloseTable(1:end, 2));
bottomLongTube = table2array(bottomLongTubeTable(1:end, 2));
bottomLongFar = table2array(bottomLongFarTable(1:end, 2));

% Medium basrefleks
bottomMediumClose = table2array(bottomMediumCloseTable(1:end, 2));
bottomMediumTube = table2array(bottomMediumTubeTable(1:end, 2));
bottomMediumFar = table2array(bottomMediumFarTable(1:end, 2));

% Kort basrefleks
bottomShortClose = table2array(bottomShortCloseTable(1:end, 2));
bottomShortTube = table2array(bottomShortTubeTable(1:end, 2));
bottomShortFar = table2array(bottomShortFarTable(1:end, 2));


%% Plot - Lukket kabinet
diff = sum(closedClose - closedFar)/length(closedClose);

figure(1)
semilogx(frequency, closedClose)
hold on
semilogx(frequency, closedFar)
hold on
semilogx(frequency, closedFar + 25)
hold on
semilogx(LukketKabinetFrequency, LukketKabinetGain - 130)
grid on
axis tight
legend('Ved membran', 'Afstand 1 meter', 'Forskudt +30 dB', 'Simulering', 'Location', 'southeast')
%title('Lukket kabinet')
xlabel('Frekvens [Hz]')
ylabel('Gain [dBV]')

%% Plot - Basrefleks p� forsiden (forskellige l�ngder) m�lt p� membran
figure(2)
semilogx(frequency, frontLongFar)
hold on
semilogx(frequency, frontMediumFar)
hold on
semilogx(frequency, frontShortFar)
hold on
semilogx(frequency, closedFar)
grid on
axis tight
legend('Lang refleks', 'Medium refleks', 'Kort refleks','Lukket kabinet', 'Location', 'southeast')
%title('Membranens karakteristik ved forskellige l�ngder basrefleks')
xlabel('Frekvens [Hz]')
ylabel('Gain [dBV]')

%% Plot - Basrefleks p� forsiden (forskellige l�ngder)
figure(3)
semilogx(frequency, frontLongTube)
hold on
semilogx(frequency, frontMediumTube)
hold on
semilogx(frequency, frontShortTube)
grid on
axis tight
legend('Lang refleks', 'Medium refleks', 'Kort refleks', 'Location', 'southeast')
%title('Basrefleksens karakteristik ved forskellige l�ngder basrefleks')

%% Plot - Basrefleks placeret forskellige steder (close)
figure(4)
semilogx(frequency, frontLongFar)
hold on
semilogx(frequency, sideLongFar)
hold on
semilogx(frequency, bottomLongFar)
grid on
axis tight
legend('Forsiderefleks', 'Siderefleks', 'Undersiderefleks', 'Location', 'southeast')
%title('Basrefleksen placeret forskellige steder (refleks)')
xlabel('Frekvens [Hz]')
ylabel('Gain [dBV]')


%% Plot - Basrefleks placeret forskellige steder (far)
figure(5)
semilogx(frequency, frontLongFar)
hold on
semilogx(frequency, sideLongFar)
hold on
semilogx(frequency, bottomLongFar)
hold on
semilogx(frequency, closedFar)
grid on
axis tight
legend('Forsiderefleks', 'Siderefleks', 'Undersiderefleks', 'Ingen refleks', 'Location', 'southeast')
%title('Basrefleksen placeret forskellige steder (lytteafstand)')
xlabel('Frekvens [Hz]')
ylabel('Gain [dBV]')