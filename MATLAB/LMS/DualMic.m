close all, clc, clear

% Distance between sensors & sound velocity
d1=0.4;
d2=1;
c=334;
%Time propagation time between the sensors
T1=d1/c;
T2=d2/c;
tau=T1*1;
tau2=T2*0.2;
k=0.1;
angle=0:k:360;

P1=abs((T1)+cos(angle));
P2=abs((tau2/T2)+cos(angle));

figure()
polarplot(angle, P1,'r', angle, P2,'b')


%% Varying distance
close all, clc

Distance=figure
for j=0:0.1:1
    d=j;
    T=d/c;
tau=0.0005;
k=0.1;
angle=0:k:360;

P=abs((tau/T)+cos(angle));

figure(Distance)
polarplot(angle, P)
hold on
end

%% Varying tau-delay
close all, clc

Distance=figure
for j=0:0.1:1
    d=0.4;
    T=d/c;
tau=j/1000;
k=0.1;
angle=0:k:360;

P=abs((tau/T)+cos(angle));

figure(Distance)
polarplot(angle, P)
hold on
end

%%
close all, clc
fs=48000;

f=200;
n=10;
t=1/fs;
N=0:t:n;
S=1*sin(f*2*pi*N);
Xm=fs/length(N);
f0=fs/2;

figure()
plot(N,S)

Sft=fft(S,fs);

figure()
semilogx(20*log(abs(Sft)))
grid on
axis([500 2000 -600 300])
xlabel('Freq in Hz')
ylabel('Mag in dB')


angle=0:length(N):360;

%Y=2*abs(S*sin((2*pi*f*(tau+T1*cos(angle))/2)));

%figure()
%polarplot(Y)

%% dual mic
close all
x=-5:0.05:5;
y=1:0.05:5;
M = zeros(length(y),length(x));   % allocate matrix
w=d1;
s=c;
t = (0:fs/f-1)/fs;
 for ky = 1:length(y)
    for kx = 1:length(x)
      aa = (x(kx)+w/2)^2;
      bb = y(ky)^2;
      cc = aa+bb;
      d1 = sqrt(cc);  % distance to mic1 (Pythagoras)
      aa = (x(kx)-w/2)^2;
      bb = y(ky)^2;
      cc = aa+bb;
      d2 = sqrt(cc);  % distance to mic2 (Pythagoras)
      T1 = d1/s;  % delay to mic1
      T2 = d2/s;  % delay to mic2
      x1 = sin(2*pi*f*(t-T1))/d1; % signal seen by mic1, level inverse proportinal to distance
      x2 = sin(2*pi*f*(t-T2))/d2; % signal seen by mic2, level inverse proportinal to distance
      xd = x1-x2;
      M(ky,kx) = sqrt(mean(xd.^2)); % level of difference
    end
  end



figure()
imagesc(x,y,10*log10(M));
 set(gca,'ydir','norm');
  xlabel('x, meters');
  ylabel('y, meters');
  colorbar
  set(gcf,'units','norm','pos',[0.2 0.2 0.6 0.6]);  

%%

fh=c/(2*d1);
DI=10*log(2);


