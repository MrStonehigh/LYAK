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
getaudiodata(Umik)
%%
clc
recordblocking(Umik,10)

%record(Umik,'off')

%%
clc
player=play(Umik)

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

rectime = 7200; %%total rectime in sec
parttime = 10; %%partwise rectime
LeqArray = 1:1:rectime/parttime;
scalar = 15;
dbref=20e-6;
Leq = scalar + mag2db(mean(abs(soundfile))/dbref)
SPL = figure;
xtime = parttime:parttime:rectime;
%plot(xtime,LegArray,'--o')
figure(SPL)

AWeighting = fdesign.audioweighting('WT,Class','A',1,48e3)
Afilter=design(AWeighting,'ansis142','SystemObject',true')
%A = filter(Afilter)

disp('Recording initiated')
for i=1:rectime/parttime; 
    recordblocking(Umik,parttime);
    soundfile = getaudiodata(Umik);
    soundfile = step(Afilter,soundfile);
    Leq = scalar + mag2db(rms(abs(soundfile))/dbref);
    LeqArray(i) = Leq(1);
    figure(SPL)
  %  plot(i*parttime,Leq,'o--b')
  plot(xtime(1:i),LeqArray(1:i),'b--o','Markersize',2) 
  drawnow
    %hold on
    if (i==1)
     xlabel('Time in sec')
    ylabel('LAeq in dB')
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
    
%% Kantine date
clc, close all
load('kantine.mat');
n = length(LeqArray);
year = 2017;
month = 11;
day = 27;
hour = 11;
minutes = 20;
seconds = 1;

timx = datenum(year, month, day,hour, minutes,seconds):1:datenum(year, month, day,12, 20,seconds)
figure()
plot( timx,LeqArray)
grid on
grid minor
dateformat = 21;
datetick('x',dateformat);

% figure()
% plot(datetime(year,month,day,hour,minutes,seconds),LeqArray)
% grid on

