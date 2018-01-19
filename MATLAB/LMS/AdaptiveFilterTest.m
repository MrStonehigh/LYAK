close all, clc, clear all

fs=48000;
f=100;
t=1/fs;
N=10;
n=1:t:N;


s0=1*sin(f*2*pi*n);
s2=3*sin(f*2*2*pi*n);
s3=1*sin(f+50*2*pi*n);

s1=s0+s2+s3;

figure()
plot(n,s1)
grid on
axis([1 1.2 -5 5])

S=fft(s1,fs);

figure()
semilogx(20*log(abs(S)))


%%
sc=sinc(n);

figure()
plot(sc)

SC=fft(sc,fs);

figure()
semilogx(20*log(abs(SC)))



%% Filter
close all, clc
m=500;
w=ones(1,m);
mu=0.0000002;

W=conj(w);
e=zeros(1,length(s1));

for j=1:500
    y(j)=sum(w*s1(j:m+j-1)');
    e(j)=s1(j)-y(j);
    for i=1:m-1
        if i<j
        w(i+1)=w(i)+mu*e(j)*s1(j-i);
        end
    end
    
end

figure()
plot(y)

figure()
plot(w)

figure()
plot(n,e)
%axis([0 2.2 -1 1])
