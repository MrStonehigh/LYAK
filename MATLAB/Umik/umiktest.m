clear all, close all, clc

fs=48000;
bits=24;
chan=2;
%Umik = audiorecorder(fs,bits,chan,1)
Umikinfo = audiodevinfo
IO=1;
Umikinfo.input(2)
ID=1;
nDevices = audiodevinfo(IO)
nameDev = audiodevinfo(IO,ID)
support=audiodevinfo(IO,ID,fs,bits,chan)

%%
Umik = audiorecorder(fs,bits,chan,ID)


%%
clc
disp('Recording Started')
recordblocking(Umik,5)
disp('Recording Ended')

%record(Umik,'off')

%%
clc
load UmikTest1.mat
load 10secBeat.mat



A = [playdata(:,1)' zeros(1, length(RecData(:,1))-length(playdata(:,1))) ; ... 
    playdata(:,2)' zeros(1, length(RecData(:,2))-length(playdata(:,2)))]';
B = [RecData(:,1)' zeros(1, length(playdata(:,1))-length(RecData(:,1))) ; ... 
    RecData(:,2)' zeros(1, length(playdata(:,2))-length(RecData(:,2)))]';
S = (B + A );

soundsc(S,48000)

save('Testing','S')

%%
clc
player=play(Umik)

%% Save recording
RecData = getaudiodata(Umik);
save('UmikTest1','RecData')

%% 
clc
micprof = load('7020960.txt');

figure()
semilogx(micprof(:,1),micprof(:,2))
grid on

%%
clc, close all
soundfile = getaudiodata(Umik);
scalar = 20;
dbref=20e-6;

%soundfile=soundfile/rms(soundfile);
figure()
plot(scalar+mag2db(soundfile/dbref))
grid on
%ylim([-20 100])
% 
% soundfileconv = conv(fft(soundfile(:)'),micprof(:,2)');
% 
% subplot(1,2,2)
% plot(mag2db(soundfile/dbref))
% grid on

Leq = scalar + mag2db(mean(abs(soundfile))/dbref)

%%  script
close all,clc

rectime = 1200; %%total rectime in sec
parttime = 10; %%partwise rectime
LeqArray = 1:1:rectime/parttime;
scalar = -3;
dbref=20e-6;
Leq = scalar + mag2db(mean(abs(soundfile))/dbref)
SPL = figure;
xtime = parttime:parttime:rectime;
%plot(xtime,LegArray,'--o')
figure(SPL)

disp('Recording initiated')
for i=1:rectime/parttime; 
    recordblocking(Umik,parttime);
    soundfile = getaudiodata(Umik);
    Leq = scalar + mag2db(mean(abs(soundfile))/dbref);
    LeqArray(i) = Leq(1);
    figure(SPL)
  %  plot(i*parttime,Leq,'o--b')
  plot(xtime(1:i),LeqArray(1:i),'b--o','Markersize',2) 
  drawnow
    %hold on
    if (i==1)
     xlabel('Time in sec')
    ylabel('Leq in dB')
    grid on
    grid minor
    hold on
    title('SPL measured in time')
    end

end
disp('Recording ended')


%%
% clc
% xtime = parttime:parttime:rectime;
% figure()
% plot(xtime,LegArray,'--o')
% xlabel('Time in sec')
% ylabel('LAeq in dB')
% grid on
% title('SPL measured in time')
    
    
