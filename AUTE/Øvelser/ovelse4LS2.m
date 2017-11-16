 close all, clc

load ir_examples.mat
load Nirvana16bitmono.mat

%% opg 4.1

close all, clc

s1=playdata(:,1);

soundsc(s1,fs)
pause(5)

s1room=conv(s1,h_room);

soundsc(s1room,fs)

s1roomLPC=conv(s1room,abs(G_room10msLPC));

pause(5)
soundsc(s1roomLPC,fs)

%% Båndpasfilter

lpf2=500/(fs/2);
lpf3=1000/(fs/2);

lp=fir2(12, [0 lpf2 lpf3 1], [50 20 0 0]);

freqz(lp,1)

s1roomlp=conv(s1room,lp);
soundsc(s1roomlp,fs)

hpf2=5000/(fs/2);
hpf3=8000/(fs/2);

hp=fir2(12, [0 hpf2 hpf3 1], [0 0 30 20]);

freqz(hp,1)
pause(5)
s1roomhp=conv(s1room,hp);
soundsc(s1roomhp,fs)

pause(5)
s1roomlphp=conv(s1roomlp,hp);
soundsc(s1roomlphp,fs)
%%
clc, close all
S1room=fft(s1room);
S1roomlp=fft(s1roomlp);
S1roomhp=fft(s1roomhp);
S1roomlphp=fft(s1roomlphp);
nfs=0:fs/length(s1room):fs-(fs/length(s1room));
nfslp=0:fs/length(s1roomlp):fs-(fs/length(s1roomlp));
nfslphp=0:fs/length(s1roomlphp):fs-(fs/length(s1roomlphp));
figure()
subplot(2,2,1)
semilogx(nfs,10*log10(abs(S1room)))
title('S1room')
axis([10 fs/2 -150 50])
subplot(2,2,2)
semilogx(nfslp,10*log10(abs(S1roomlp)))
title('S1roomlp')
axis([10 fs/2 -150 50])
subplot(2,2,3)
semilogx(nfslp,10*log10(abs(S1roomhp)))
title('S1roomhp')
axis([10 fs/2 -150 50])
subplot(2,2,4)
semilogx(nfslphp,10*log10(abs(S1roomlphp)))
axis([10 fs/2 -150 50])
title('S1roomlphp')