clear all
close all

system('start C:\projects\Tools\AlgoFlex\bin\win32_x86\Release\AlgoFlexServer.exe');
ServerIpName = 'localhost';
serverID = AlgoFlexClient('OpenServCon',ServerIpName,4242);

fs = 48000;

AlgoFlexClient(serverID,'SetSampleRate',fs);

% ASIO
%--------------------------------------------------------------------------
[idAS,nameAS] = AlgoFlexClient(serverID,'Create','AsioStream',2,2);
AlgoFlexClient(serverID,'SetData',nameAS,'DriverName','ASIO Fireface USB');
AlgoFlexClient(serverID,'SetData',nameAS,'BufferSize',2048);
AlgoFlexClient(serverID,'SetData',nameAS,'AsioInputIndex',[1 5]);
AlgoFlexClient(serverID,'SetData',nameAS,'AsioOutputIndex',1:2);


% [idFI,nameFI] = AlgoFlexClient(serverID,'Create','IirFilter',1,1);
% [b,a] = butter(4,100/(fs/2),'high');
% sos=tf2sos(b,a);
% AlgoFlexClient(serverID,'SetData',nameFI,'Coefficients',sos);

% [idGA, nameGA] = AlgoFlexClient(serverID, 'Create','GainLS',2,2);

[idAGC, nameAGC] = AlgoFlexClient(serverID, 'Create', 'AGC',2,2);
AlgoFlexClient(serverID,'SetData',nameAGC,'filterL',1024);


rectime=1;      %Recording time for MatrixRecorder in sec
sampno=fs*rectime;
[idMatRec nameMatRec] = AlgoFlexClient(serverID,'Create','MatrixRecorder',3,0);
AlgoFlexClient(serverID,'SetData',nameMatRec,'SamplesToRecord',sampno);
AlgoFlexClient(serverID,'SetData',nameMatRec,'RecordMode','repeat');


% 
% [idBP, nameBP] = AlgoFlexClient(serverID, 'Create', 'Bypass',1,1);

[idMP nameMP]=AlgoFlexClient(serverID,'Create','MatrixPlayer',0,1);
n=1024;
x=ones(1,n);
AlgoFlexClient(serverID,'SetData',nameMP,'Samples',x);
AlgoFlexClient(serverID,'SetData',nameMP,'PlaybackMode','repeat');


%AlgoFlexClient(serverID,'SetData',nameBP,'DummyDataParm',1);
%AlgoFlexClient(serverID,'SetData',nameBP,'DummyTransmitterParm',10);


% Route
%--------------------------------------------------------------------------
% AlgoFlexClient(serverID,'ConnectAudio', idAS,1, idFI,1);  % ASIO --> Filter
% AlgoFlexClient(serverID,'ConnectAudio', idFI,1, idGA,1);  % Filter --> Gain
% AlgoFlexClient(serverID,'ConnectAudio', idGA,1, idAS,1);  % Gain --> ASIO
% AlgoFlexClient(serverID,'ConnectAudio', idAS,2, idGA,2);  % ASIO --> block
% AlgoFlexClient(serverID,'ConnectAudio', idGA,2, idAS,2);  % ASIO --> block


AlgoFlexClient(serverID,'ConnectAudio', idAS,2,  idAGC,2);
AlgoFlexClient(serverID,'ConnectAudio', idMP,1,  idAGC,1);
AlgoFlexClient(serverID,'ConnectAudio', idAGC,2,  idAS,1);
AlgoFlexClient(serverID,'ConnectAudio', idMP,1,  idMatRec,1);
AlgoFlexClient(serverID,'ConnectAudio', idAGC,1,  idMatRec,2);


% Exe sequence
%--------------------------------------------------------------------------
AlgoFlexClient(serverID,'SetExeSeq',[idAS idAGC idMP idMatRec]);

% Start
%--------------------------------------------------------------------------
AlgoFlexClient(serverID,'SetSampleRate',fs);
AlgoFlexClient(serverID,'MultiStart');



%% Set AGC gain
clc
AlgoFlexClient(serverID,'SetData',nameAGC,'SNRdesired',20);     %Master volumen

%AlgoFlexClient(serverID,'SetData',nameAGC,'AGCDb',10);
%AlgoFlexClient(serverID, 'SetData', nameAGC, 'GLD_AGCFactor',{'Linear','2','1e-6'});  %Fading time = 5sec
AlgoFlexClient(serverID, 'SetData', nameAGC, 'GLD_AGCFactor',{'Step','2','1e-6'});  %Fading time = 5sec
AlgoFlexClient(serverID,'BlockInfo',nameAGC) %check the state
%AlgoFlexClient(serverID,'BlockInfo',nameLMS) %check the state

%% Input chan 0 
clc
%AlgoFlexClient(serverID,'SetData',nameBP,'DummyDataParm',15);
n=100;
K=15;       %Noise level: High number = low noise 
x=K*ones(1,n);
AlgoFlexClient(serverID,'SetData',nameMP,'Samples',x);
AlgoFlexClient(serverID,'BlockInfo',nameAGC) %check the state
%AlgoFlexClient(serverID,'BlockInfo',nameMP) %check the state

%% Get MatrixRecorder Data
AlgoFlexClient(serverID,'Stop');
MatRecData = AlgoFlexClient(serverID,'GetData',nameMatRec,'Samples');
% 
% AlgoFlexClient(serverID,'DestroyAll');
% AlgoFlexClient(serverID,'Quit');

%% data

figure()
plot(MatRecData(:,2))
grid on

%% Data analysis
close all, clc

SNRmean = zeros(1,sampno);
meanbuf = zeros(1,fs/2);

for j=1:sampno
    meanbuf = [MatRecData(j,3) meanbuf(1:end-1)];
    SNRmean(j)=mean(meanbuf);
    
end
disp('end for')

t=0:1/fs:rectime-(1/fs);
figure()
subplot(3,1,1)
plot(t,MatRecData(:,1))
title('input d - Mic')
xlabel('Time in sec')
grid on
subplot(3,1,2)
plot(t,MatRecData(:,2))
title('input x - clean music')
xlabel('Time in sec')
grid on
subplot(3,1,3)
plot(t,MatRecData(:,3),t,SNRmean,'r')
title('SNR from LMS-block')
xlabel('Time in sec')
%ylim([-50 50])
grid on




%% AGC gain

AlgoFlexClient(serverID,'SetData',nameAGC,'AGCDb',10);
AlgoFlexClient(serverID,'BlockInfo',nameAGC) %check the state

%% Glide gain
AlgoFlexClient(serverID,'SetData',nameGA,'GLD_GainLSFactor',{'Linear','5','1e-6'});
AlgoFlexClient(serverID,'SetData',nameGA,'GainLSDb',10);
AlgoFlexClient(serverID,'BlockInfo',nameGA) %check the state

%% close server
AlgoFlexClient(serverID,'Stop');
AlgoFlexClient(serverID,'DestroyAll');
AlgoFlexClient(serverID,'Quit');

