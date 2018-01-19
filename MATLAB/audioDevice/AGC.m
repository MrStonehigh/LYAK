clear all, clc, close all

load stormusiklavsnak1.mat
fs=48000;
ts=1/fs;
t=0:ts:1-ts;

f=500;



s1=sin(2*pi*f*t);
s2=2*s1;
s3=0.4*s1;

input=[s1 s2 s3 s1 s3 s1 s2];
t=0:ts:5-ts;

input=playdata(:,1)';

figure()
plot(t,input)

%% AGC basic

close all, clc
scalar=5;
alfa=0.02;
R=2;
M=length(input)/scalar;
x=zeros(1,M-1);
d=1;
dd=1;

for k=1:M
    
    x=[(input(k*scalar)*dd) x(1:M-1)];
    
    xR=R-(x(1)^2);
    xa=xR*alfa;
    d=dd;
    dd=xa+d;
%     if rem(k,10000)==0
%     plot(k,d(k),'o--b')
%     hold on
%     drawnow
%     end
    
end
    
figure()
plot(x)
hold on
plot(t,input)
grid on
%% Listen
soundsc(input,fs)
pause(8)
soundsc(x,fs)

%% AGC extended

close all, clc

alfa=0.02;
R=2;
M=length(input);
x=randn(1,M-1);
d=randn(1,M);
dd=randn(1,M);

for k=1:M
    
    x=[(input(k)*dd) x(1:M-1)];
    y=(x(1)^2);
    
    xR=log10(abs(R))-log10(abs(y));
    
    xa=xR*alfa;
    
    d(k+1)=xa+d(k);
    dd=10^(d(k+1));
    if rem(k,1)==0
    plot(k,dd,'o--b')
    hold on
    drawnow
    end
    
end
    
figure()
plot(t,x)
%hold on
%plot(t,input)
grid on
    