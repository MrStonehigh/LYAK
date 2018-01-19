close all, clear all, clc
aDW = audioDeviceWriter()
devices = getAudioDevices(aDW)
inf=info(aDW)
aDW=audioDeviceWriter(44100,'Driver','ASIO')

%afr=dsp.AudioFileReader('RockinBeats.mp3') 

%while ~isDone(afr)
 %   audio = step(afr);
 %   aDW(audio);
%end
%release(afr);
%release(aDW);

%%
clc
afw=dsp.AudioFileWriter('Testing.wav',)
firdec=dsp.FIRDecimator;

%% From Mathworks.com
clc
frameLength = 256;
fileReader = dsp.AudioFileReader('SamplesPerFrame',frameLength);
deviceWriter = audioDeviceWriter('SampleRate',fileReader.SampleRate);
scope = dsp.TimeScope('SampleRate',fileReader.SampleRate,'TimeSpan',16,'BufferLength',1.5e6,'YLimits',[-1 1]);
dRG = noiseGate('SampleRate',fileReader.SampleRate,'Threshold',-25,'AttackTime',10e-3,'ReleaseTime',20e-3,'HoldTime',0);

visualize(dRG);

configureMIDI(dRG);

while ~isDone(fileReader)
    signal = fileReader();
    noisySignal = signal + 0.0025*randn(frameLength,1);
    processedSignal = dRG(noisySignal);
    deviceWriter(processedSignal);
    scope([noisySignal,processedSignal]);
end

release(fileReader);
release(deviceWriter);
release(scope);
release(dRG);

