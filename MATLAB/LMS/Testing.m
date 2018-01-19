clc, clear, close all


%%
close all, clc, clear
fs=48000;
f=10;
N=100;
n=[1:f/(fs/N):N];
signal1=sin(f*n*2*pi);
noise1=rand(size(n));

figure()
plot(n, signal1)
grid on

figure()
plot(n, noise1)
grid on
signal2=signal1+noise1;

figure()
plot(n,signal2)
grid on
figure()
plot(n,(signal2-signal1))

%e(n)=signal1(n)-signal2(n);
mu=0.002;
alpha=0.04;
w(1)=0;
%%
for j=2:1:100
u(j)=signal2(j);
f=mu*e(j)*conj(u(j));
w(j)=alpha*w(j-1)+f;
y(j)=w(j-1).'*u(j);
e(j)=signal1(j)-y(j);
disp(j);

plot(j,e(j))
    drawnow
end

%%
close all,  clc
f1=figure
f2=figure
f3=figure
k=1:length(signal2);
x(k)=signal2;
%W(k)=randn(1,length(k));
%plot([hamming(64)]) %zeros(k-length(hamming(64)))]
W(k)=[hamming(64)' zeros(1,length(k)-length(hamming(64)))];
figure(f1)
plot(W)
grid on
d(k)=signal1;

Y=0;

for i=1:length(k)
    Y=Y+x(i)*W(i);
    E=signal1(i)-Y;
    figure(f2)
    plot(i,x(i),'r--o',i,E,'g--x',i,d(i),'b--*')
    hold on
   drawnow
   legend('x','E','d')
   %Eq (7)
   R=mean(x*x');
   %Eq. (8)
   P(i)=mean(d(i)*x');
   %Eq (9)
   delta(i)=2*R*W(i)-2*P(i);
   % Eq. (15)
   W(i+1)=W(i)-mu*delta(i);
   
end


figure(f3)
plot(W)
grid on
%%
figure(4)
plot(n, signal1)
grid on
signal2=signal1+noise1;

figure(5)
plot(n,signal2)
grid on

