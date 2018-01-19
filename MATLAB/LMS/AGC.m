clear all, close all, clc

f=4900;
fs=48000;
ts=1/fs;

N=0.02;
n=0:ts:N;
s1=1*sin(f*2*pi*n);
s2=2*sin(f*2*pi*n);
s3=0.3*sin(f*2*pi*n);

first=figure;
s=[s1 s2 s1 s3 s1];
x=length(s)/length(n);
X=x*length(n);
figure(first)
plot(s)

R=1;
alfa=0.01;
td=length(n)/fs;
%AGCo=figure;
m=1:length(s);
m1=0;
m2=0;
L=1/f;
fsL=fs*L;
k=0;
%%
for j=2:length(s)
    k=k+1;
    for g=1:ceil(fsL)
        if s(j)>s(j+g)
            SS=s(j);
        else
            SS=s(j+g);
        end
    end
    S=SS;
    m1=((R-S)*alfa)+m2;
    y=s(j)*m2;
    m2=m1;
    
    
    figure(AGCo)
    plot(j,y,'b--x')
    hold on
    drawnow
    axis([0 2405 -4 4])
end

%%
close all, clc
nn=100;
H=1:nn;
for ii=1:nn-1
    H(ii)=0;
end
P=1:length(s);

figure()
plot(s)
for h=1:(length(s)-3)
    for ii=1:ceil(fsL)
        if h+ii<length(s)
        P(h)=(P(h)+sqrt(s(h+ii)*s(h+ii)));
        end
        P(h)=1/ceil(fsL)*P(h);
    end
    E(h)=R-P(h);
    
    H=E(h)*alfa+H;
    
    
    for hh=1:nn
        if (h+hh)<(length(H))
           % disp('h=')
            %disp(h)
            %disp('hh=')
            %disp(hh)
            %length(s(h+hh))
            %length(H((nn-h)))
            if h-hh>0
                s(h-hh)=s(h-hh)*H((hh));
            end
        end
    end
    %s(h)=s(h)*H(nn-1);
    %k=0;
    for jj=1:nn-3
     %   k=k+1;
        H(jj)=H(jj+1);
    end
      
end

figure()
plot(P)
title('Error signal')


figure()
plot(H)
title('Filter weights')

figure()
plot(s)
axis([0 5000 -2 2])
title('controlled signal')