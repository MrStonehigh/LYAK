clear all, close all, clc

load plant.mat
load Nirvana16bitmono.mat

%% Hvad er d plant
close all, clc

sampletime=5;       %Tid i sek
N=length(recdata);
ts=1/fs;

n=0:ts:sampletime-ts;


figure()
plot(d,'o')

x=playdata(:,1)';
x=x/rms(x);
X=fft(x);

y=recdata(:,1)';
y=y/rms(y);
Y=fft(y);
D=fft(d);

figure()
semilogx(abs(D))
grid on

longd=[d zeros(1,length(y)-length(d))];
NN=0;
longD=[ones(1,NN) D ones(1,length(Y)-length(D)-NN)];

yd=conv(y,d);
YD=Y.*longD;

figure()
plot(yd,'r')

nfs=0:fs/length(Y):fs-(fs/length(Y));
nfsD=0:fs/length(D):fs-(fs/length(D));

figure()
semilogx(nfs,10*log10(abs(Y)),'b',nfs,10*log10(abs(longD)),'r',nfs,10*log10(abs(YD)),'m')
grid on
axis([0 15000 -50 60])
ylabel('Magnitude in dB')
xlabel('Frequency in Hz')

%% LMS noise
clc,close all
u=0.008;
M=80;
N=8000;
e80=zeros(1,N);
w80=zeros(1,M);
xx=zeros(1,M-1);
nois=rand(1,N);
noisd=conv(nois,d);
for k=1:N
  
    xx=[nois(k) xx(1:M-1)];
   
    e80(k) = noisd(k) - sum(xx.*w80);
   
    w80=w80+(u*e80(k).*xx);
   
w180(k)=w80(1);
w280(k)=w80(2);
w380(k)=w80(3);
w480(k)=w80(4);
end

u=0.008;
M=200;

e200=zeros(1,N);
w200=zeros(1,M);
xx=zeros(1,M-1);
nois=rand(1,N);
noisd=conv(nois,d);
for k=1:N
  
    xx=[nois(k) xx(1:M-1)];
   
    e200(k) = noisd(k) - sum(xx.*w200);
   
    w200=w200+(u*e200(k).*xx);
   
w1200(k)=w200(1);
w2200(k)=w200(2);
w3200(k)=w200(3);
w4200(k)=w200(4);
end

u=0.01;
M=500;

e500=zeros(1,N);
w500=zeros(1,M);
xx=zeros(1,M-1);
nois=rand(1,N);
noisd=conv(nois,d);
for k=1:N
  
    xx=[nois(k) xx(1:M-1)];
   
    e500(k) = noisd(k) - sum(xx.*w500);
   
    w500=w500+(u*e500(k).*xx);
   
w1500(k)=w500(1);
w2500(k)=w500(2);
w3500(k)=w500(3);
w4500(k)=w500(4);
end

tt=0:N-1/N;

figure()
subplot(3,3,1)
plot((e80/rms(e80)).^2)
subplot(3,3,2)
plot((w80/rms(w80)),'b')
hold on
plot((d/rms(d)),'r')
subplot(3,3,3)
plot(tt,w180,'b',tt,w280,'r',tt,w380,'g',tt,w480,'y')
grid on
legend('h1', 'h2', 'h3', 'h4')
subplot(3,3,4)
plot((e200/rms(e200)).^2)
subplot(3,3,5)
plot((w200/rms(w200)),'b')
hold on
plot((d/rms(d)),'r')
subplot(3,3,6)
plot(tt,w1200,'b',tt,w2200,'r',tt,w3200,'g',tt,w4200,'y')
grid on
legend('h1', 'h2', 'h3', 'h4')
subplot(3,3,7)
plot((e500/rms(e500)).^2)
subplot(3,3,8)
plot((w500/rms(w500)),'b')
hold on
plot((d/rms(d)),'r')
subplot(3,3,9)
plot(tt,w1500,'b',tt,w2500,'r',tt,w3500,'g',tt,w4500,'y')
grid on
legend('h1', 'h2', 'h3', 'h4')


%% LMS sinus
clc,close all
u=0.008;
M=80;
N=8000;
e80=zeros(1,N);
w80=zeros(1,M);
xx=zeros(1,M-1);
f=650;
nn=0:1/fs:0.2;
nois=sin(2*pi*f*nn);

figure()
plot(nn,nois)

noisd=conv(nois,d);
for k=1:N
  
    xx=[nois(k) xx(1:M-1)];
   
    e80(k) = noisd(k) - sum(xx.*w80);
   
    w80=w80+(u*e80(k).*xx);
   
w180(k)=w80(1);
w280(k)=w80(2);
w380(k)=w80(3);
w480(k)=w80(4);
end

u=0.008;
M=200;

e200=zeros(1,N);
w200=zeros(1,M);
xx=zeros(1,M-1);

for k=1:N
  
    xx=[nois(k) xx(1:M-1)];
   
    e200(k) = noisd(k) - sum(xx.*w200);
   
    w200=w200+(u*e200(k).*xx);
   
w1200(k)=w200(1);
w2200(k)=w200(2);
w3200(k)=w200(3);
w4200(k)=w200(4);
end

u=0.01;
M=500;

e500=zeros(1,N);
w500=zeros(1,M);
xx=zeros(1,M-1);

for k=1:N
  
    xx=[nois(k) xx(1:M-1)];
   
    e500(k) = noisd(k) - sum(xx.*w500);
   
    w500=w500+(u*e500(k).*xx);
   
w1500(k)=w500(1);
w2500(k)=w500(2);
w3500(k)=w500(3);
w4500(k)=w500(4);
end

tt=0:N-1/N;

figure()
subplot(3,3,1)
plot((e80/rms(e80)).^2)
subplot(3,3,2)
plot((w80/rms(w80)),'b')
hold on
plot((d/rms(d)),'r')
subplot(3,3,3)
plot(tt,w180,'b',tt,w280,'r',tt,w380,'g',tt,w480,'y')
grid on
legend('h1', 'h2', 'h3', 'h4')
subplot(3,3,4)
plot((e200/rms(e200)).^2)
subplot(3,3,5)
plot((w200/rms(w200)),'b')
hold on
plot((d/rms(d)),'r')
subplot(3,3,6)
plot(tt,w1200,'b',tt,w2200,'r',tt,w3200,'g',tt,w4200,'y')
grid on
legend('h1', 'h2', 'h3', 'h4')
subplot(3,3,7)
plot((e500/rms(e500)).^2)
subplot(3,3,8)
plot((w500/rms(w500)),'b')
hold on
plot((d/rms(d)),'r')
subplot(3,3,9)
plot(tt,w1500,'b',tt,w2500,'r',tt,w3500,'g',tt,w4500,'y')
grid on
legend('h1', 'h2', 'h3', 'h4')

