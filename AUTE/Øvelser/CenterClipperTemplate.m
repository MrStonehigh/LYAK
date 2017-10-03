% CenterClipperTemplate.m



%% load speech signal and play it 
[y,Fs]=audioread('speech_fem_4.wav');
z=[zeros(44100,1); 2*y(1:211733); zeros(44100,1); 2*y(211734:end) ; zeros(44100,1)];
N=length(z);
player = audioplayer(z, Fs);
playblocking(player);

%% add white noise

z=z+0.04*(rand(N,1)-0.5);


%% play noisy signal
player = audioplayer(z, Fs);
playblocking(player);


%% create a center clipper





%% play center clipped signal

player = audioplayer(z, Fs);
playblocking(player);