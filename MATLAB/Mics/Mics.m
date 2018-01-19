clear all, close all, clc

N=2;        %Number of sensors

d=0.30;     %Distance between sensors
c=344;      %Sound velocity

f=1:20000;
maxdist=c./(2*f);

figure()
semilogx(f,maxdist)
xlabel("Frequency (Hz)")
ylabel("Max Distance (m)")
%axis([540 600 0.2 0.4])
xlim([500 15000])
grid on
grid minor

f=570;
maxdist=c/(2*f)
tau=d/c;    %TDOA (Time difference og arrival)

%%

fs=48000;
ts=1/fs;
time=1;
k=0:ts:time;
v=rand(1,length(k))-0.5;
f=5000;
t=1/f;
x=sin(f*2*pi*k);
y=x+v;

L=100;             %Number og filtertaps
h=randn(1,L);
z=zeros(1,L);
e=zeros(1,L);

Ryy=y*y';
[ryx lags bounds]=crosscorr(y,x);
RYX=fft(ryx);
figure()
plot(lags,abs(RYX))
%%
for j=L:length(k)
    z(j)=h'*y((L-j)+1:j+1);
    e(j)=x(j)-z(j);
end

z=(h')*y;


figure()
subplot(2,1,1)
plot(k,v, k,x)
axis([0 t*20 -2 2])
subplot(2,1,2)
plot(k,y)
axis([0 t*20 -2 2])

%%
RHO=corr()
