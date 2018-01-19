
close all, clc, clear all

  load 5secBeat.mat
  load snakfrabord.mat
% load Luderen.mat
 % load lavsnak.mat
  %load 10secBeat.mat
%load Nirvana16bitmono
%load talk.mat
load lavmusikstorsnak1.mat
%load stormusiklavsnak1.mat
%load stormusiklavsnak1.mat
%load 1sectalk2.mat

%%
close all, clc
fs=48000;
n=1000;
ts=1/fs;
time=5;
t=0:ts:time-ts;

s1=playdata(:,1)';
s2=recdata(:,2)';
s3=recdata(:,1)';
%s4=s2-s1;
c=344;
s1=-s1;
s1BM=s1;
s3BM=s3;

figure()
subplot(2,1,1)
plot(t,s1)
grid on
title('s1')
subplot(2,1,2)
plot(t,s2)
grid on
title('s2')

% Find delay
[mag,lag]=xcorr(s3,s1);
[maxmag,maxI] = max(abs(mag));
lagdiff=lag(maxI);
timediff = lagdiff/fs;
lagdist=timediff/c;


[mag3,lag3]=xcorr(s3,s2);
[maxmag3,maxI3] = max(abs(mag3));
lagdiff3=lag3(maxI3);
timediff3 = lagdiff3/fs;
lagdist3=timediff3/c;

dis=16.4;

 TT=round((dis/c)/ts);
%TT=round(0.0481*fs);
%TT=2134;
TT=abs(lagdiff);
TT3=abs(lagdiff3)+0;
s1=s1/rms(s1);
s11=s1;
 
s2=s2/rms(s2);
s3=s3/rms(s3);
s1=[zeros(1,TT) s1(1:end-TT)];
s2=[zeros(1,TT3) s2(1:end-TT3)];
figure()
plot(t,(s1),'b',t,(s2),'r',t,(s3),'g')%,t,s4,'k')
legend('s1','s2','s3')%,'s4')
axis([0 0.1 -3 3])
%axis([0.045 0.055 -0.3 0.8])
%ylim([-5 15])
grid on
%s4=0.01*s1+12*x';
%s2=s1+x';
s4=s2;
% figure()
% plot(t,s4)

 soundsc(s2,fs)

 [mag lag]=xcorr(s3,s1);
 [maxmags2 maxinds2] = max(abs(mag(length(s2)-100:length(s2)+100)))
 mags2=mag(length(s2)+(maxinds2-101))
 ind0mags2norm=abs(mags2)/length(s2)
 mags2rms=rms(mag)
% mags2SNR=mags2/mags2rms
 mags2rms=mags2rms*ones(1,length(lag));
 
 
 
 figure()
 plot(lag, mag,'b')
 grid on
 title('Xcorr ratio')
 hold on
 plot(lag,mags2rms,'r')
 
ss1=s1;
ss2=s2;
ss3=s3;

clear mag lag mag3 lag3 lagdiff lagdiff3 lagdist lagdist3 maxI maxI3 maxmag maxmag3 dis TT TT3 timediff timediff3 c
%clear playdata recdata

%% "Excel"-ark

Excel=["s1 skalar"   "s4 skalar"  "rmsee" "rmss4" "magmaxee" "magmaxs4" "index0ee" "index0s4" "normindex0s4"; ...
0.01 20 425.39 886.60 2303.8 5606.9 225.82 1126.2 0.0047; ...    
0.01 10 213.32 443.28 1205.1 2786.2 145.26 1744.2 0.0073; ...
    0.01 5 114.85 223.86 691.81 2053.2 114.14 2053.2 0.0086; ...
    0.01 1 49.43 65.13 399.88 2300.4 487.10 2300.4 0.0096; ...
    0.1 1 49.24 514.40 1146.3 23560 1043.1 23560 00.0982; ...
    1 1 154.19 5160 11638 236160 10756 236160 0.984;...
    10 1 1484.6 51637 115870 2362100 110140 2362100 09.842;...
    ]


%% Forkortet signal
clc
startsec=1.5;
endtime=2;
nstart=startsec*fs;
nslut=endtime*fs;
s1=s1(nstart:nslut);
s2=s2(nstart:nslut);
s3=s3(nstart:nslut);
%s1=s1(nstart:nslut);



%% Bandpass filter
clc,close all
%bpfilt=designfilt('bandpassfir','FilterOrder',500,'CutoffFrequency1',200,'CutoffFrequency2',800,'SampleRate',fs);
bpfilt=designfilt('bandpassiir','FilterOrder',50,'HalfPowerFrequency1',300,'HalfPowerFrequency2',5000,'SampleRate',fs);
freqz(bpfilt) 
axis([0 6000/(fs/2) -40 10])
s2filt=filter(bpfilt,s2);
%s1=filter(bpfilt,s1);

clear bpfilt

 %% LMS loop1
close all,clc

brk=1/40;
ee=zeros(1,length(ss1));
cc=0;
for a=0.01:brk:(time-0.01)
    
    startsec=a;
endtime=a+brk-0.01;
nstart=startsec*fs;
nslut=(endtime*fs)-1;
s1=ss1(nstart:nslut);
s2=ss2(nstart:nslut);
s3=ss3(nstart:nslut);

M=length(s1);             %FIR filter length
u=0.00005;           %adaption constant (mu)
v=zeros(1,M); %FIR delay line
d=zeros(1,M);
b=0.01*randn(1,M);  %Initial filter coefs
%b=zeros(1,M);
bb=b;
 N=length(s1);
 e=s1*0;
% figure()
   b1=zeros(1,N);
   b2=zeros(1,N);
   b3=zeros(1,N);
   b4=zeros(1,N);
   b5=zeros(1,N);
   b6=zeros(1,N);
   b7=zeros(1,N);
   b8=zeros(1,N);
 
 for k=1:N
     
     %if rem(k,20000)==0
    %     plot(b);
       %  ylim([-0.5 0.5]);
      %   drawnow
    % end
   yy(k)=sum(v.*b);
    d = [s2(k) d(1:M-1)];
     v = [s1(k) v(1:M-1)];
     e(k)=s2(k)-sum(v.*b);
     b=b + (u*e(k)*v);
     
     
     b1(k)=b(1);
     b2(k)=b(2);
     b3(k)=b(3);
     b4(k)=b(4);
     b5(k)=b(5);
     b6(k)=b(6);
     b7(k)=b(7);
     b8(k)=b(8);
     
     ee(k+(N*cc))=e(k);
 end
 nn=1:N;
 cc=cc+1;
 t=0:ts:(length(s1)/fs)-ts;
 if rem(a,(1*brk+0.01))==0
 subplot(3,1,1)
 plot(t,(e.^2))
 xlabel('Time in sec')
 ylabel('e(n)^2')
 grid on
%  subplot(3,1,2)
%  plot(b,'r')
%  hold on 
%  plot(bb,'b')
 subplot(3,1,2)
 plot(nn,b1,'k',nn,b2,'r',nn,b3,'b',nn,b4,'g')%,nn,b5,'r',nn,b6,'c',nn,b7,'m',nn,b8,'y')
 title('First coefficients')
 xlabel('Iteration no.')
 ylabel('Coefficient value')
 legend('b1','b2','b3','b4')
 grid on
 subplot(3,1,3)
 plot(t,s1,'b',t,s2,'r',t,s3,'g')%,t,s4,'k')
title('Blockview')
xlabel('Time in sec')
ylabel('Magnitude in gg')
 legend('s1','s2','s3')%,'s4')
%axis([0 0.1 -2 2])
grid on

%################## Playtime######## 
%   soundsc(e,fs)
%   pause(brk)

%  pause(time)
%  soundsc(yy,fs)
%  pause(time)
%  soundsc(s2,fs)
 
%  figure()
%  plot(t,e.^2,'b',t,s2.^2,'r')
%  
disp(a);
 middel1=mean(e.^2);
 middel2=mean(s2.^2);
 middel3=mean((s2.^2-e.^2))
 
 middel1=middel1*ones(1,length(s2));
 middel2=middel2*ones(1,length(s2));
 middel3=middel3*ones(1,length(s2));
 
 figure()
 plot(t,(s2.^2-e.^2),'b',t,middel1,'--k',t,middel2,'--y',t,middel3,'m')
 legend('differens', 'middel e','middel s2','middel differens')
 grid on
 end
end
 
soundsc(ee,fs)
figure()
plot(ee)

clear b b1 b2 b3 b4 b5 b6 b7 b8 bb nstart nslut startsec endtime
 %% FFT analyse
 
 S2=fft(s2);
 S3=fft(s3);
 tfs=fs/length(S2);
 nfs=0:tfs:fs-tfs;
 figure()
 semilogx(nfs,10*log10(abs(S2)),'b',nfs,10*log10(abs(S3)),'r')
 axis([10 17000 0 50])
 grid on
 
  %% LMS loop2 filt
close all,clc
M=400;             %FIR filter length
u=0.0003;           %adaption constant (mu)
vfilt=zeros(1,M);       %FIR delay line
bfilt=0.01*randn(1,M);  %Initial filter coefs

 N=length(s1);
 efilt=s1*0;
 figure()
 for k=1:N
     if rem(k,20000)==0
         plot(bfilt);
         ylim([-0.5 0.5]);
         drawnow
     end
     vfilt = [s1(k) vfilt(1:M-1)];
     efilt(k)=s2filt(k)-sum(vfilt.*bfilt);
     bfilt=bfilt + (u*efilt(k)*vfilt);
 end
 %% Listen
 %e=e/rms(e);
%  %Listen
%  figure()
%  plot(t,e,'b',t,efilt,'r')
 %plot(v,'b')
 %hold on
 %plot(b,'r')
 
 
 
 soundsc(s1,fs)
 pause(time)
 soundsc(s2,fs)
 pause(time)
  soundsc(s3,fs)
%  pause(time)
%  soundsc(efilt,fs)
%  
 
%  
%  ratio1=snr(s2,e)
%  ratio2=snr(s2,s1)
%  ratio3=snr(s2,efilt)

 %% delayline
 
 secdelay=TT*ts;
 c=344;
 dis=secdelay*c
 
 dis=15.3;
 (dis/c)/ts
 
 %% Parameter forståelse
 clc
 xstart=2000;
 xstop=2099;
 R=(s2(xstart:xstop)).*(conj(s2(xstart:xstop))');
 [vect,Value]=eig(R);
 
 trace(R)
 trace(Value)
 
 max(Value)
 
 eye(xstop-xstart);
 1/(3*trace(R))
 
 
 P=mean(s2*s2');
 
 %% LMS 2 mics
 
 close all,clc
M=300;             %FIR filter length
u=0.00002;           %adaption constant (mu)
v=zeros(1,M);       %FIR delay line
b=0.01*randn(1,M);  %Initial filter coefs
sfilt=s3;
d=zeros(1,M);
w=zeros(1,M);

 N=length(s1);
 e=s1*0;
 e1=e;
 w=e;
 figure()
 for k=1:N
     if rem(k,20000)==0
         plot(b);
       %  ylim([-0.5 0.5]);
         drawnow
     end
     v = [s2(k) v(1:M-1)];
     d = [s1(k) d(1:M-1)];
     w = [s3(k) w(1:M-1)];
   
    w(k)=s3(k);
     e1(k)=(sum(v.*b));
     e(k) = w(k)-e1(k);
     b=b + (u*e(k)*d);
%     sfilt(k)=s3(k)-e(k);
 end
 
 
 
 figure()
 plot(t,e,'b',t,e1,'r')
 
 figure()
 plot(s1)
 
 %soundsc(s3,fs)
 %pause(time)
 
 %soundsc(s2,fs)
 %pause(time)
 
 soundsc(e1,fs)
 pause(time)
 
  %% LMS loop4 FxLMS
close all,clc
M=600;             %FIR filter length
u=0.0000003;           %adaption constant (mu)
y=zeros(1,M);       %FIR delay line
b=0.01*randn(1,M);  %Initial filter coefs
b1=b;
d=zeros(1,M);
 N=length(s1);
 e=s1*0;
 q=[zeros(1,M-1) 1];
 ref=zeros(1,M);
 q=[q zeros(1,length(s3)-length(q))];
 s33=s3.*q;
 yy=zeros(1,N);
 figure()
 for jjj=1:3
 for k=1:N
     if rem(k,20000)==0
         plot(yy);
         
        % ylim([-0.5 0.5]);
         drawnow
     end
     y = [s2(k) y(1:M-1)];
     d = [s1(k) d(1:M-1)];
     ref = [s3(k) ref(1:M-1)];
    yy(k)=sum(y.*b);
     eout(k)=s33(k)-sum(d.*b);
% %     e(k) = sum(y.*b1) - sum(d.*b);
%      e(k) =   sum(y.*b1)-eout(k);
%      b=b + ((u)*(eout(k))*(d));
%      b1=b1+(u*e(k)*y);
       e(k) = sum(y.*b1)-sum(d.*b);
        b=b + ((u)*(e(k))*(d));
       b1 = b1 + u*eout(k)*y;
 end      
 end
 
 figure()
 plot(t,eout,'b',t,e,'r')
 soundsc(eout,fs)
 pause(time)
  soundsc(e,fs)
 pause(time)
  soundsc(yy,fs)
 %pause(time)
% %  bfilt=[b zeros(1,length(s2)-length(b))];
% %  filtereds2=s2.*bfilt;
% %  
%  figure()
%  plot(t,filtereds2)
%  soundsc(filtereds2,fs)

%% Correlation
clc,close all
MM=10000;
[mag,lag]=xcorr(s1,s3);

[maxmag,maxI] = max(abs(mag));
lagdiff=lag(maxI)
timediff = lagdiff/fs;
lagdist=timediff/c;
figure()
plot(lag,abs(mag))
grid on
%% 

%% BLMS
close all,clc
M=40;             %FIR filter length
L=40;               %Block size
u=0.0005;           %adaption constant (mu)
x=zeros(1,L); %FIR delay line
d=zeros(1,L);
w=0.01*randn(1,M);  %Initial filter coefs
%b=zeros(1,M);
ww=w;
 N=length(s1);
 e=zeros(1,L);
 figure()
 for kk=1:1000
 y = x.*w;
 e = d-y;
 w = w + (u * sum(e.*x)/L );
     for k=1:L
    x = [s1(kk+k) x(1:L-1)];
    d = [s2(kk+k) d(1:L-1)];
    
     end
    plot(e)
    drawnow
 
 end
 
 %% LMS loop1
close all,clc


ee=zeros(1,length(ss1));

   
   
M=3000;             %FIR filter length
u=0.00005;           %adaption constant (mu)
v=zeros(1,M); %FIR delay line
d=zeros(1,M);
b=0.01*randn(1,M);  %Initial filter coefs
%b=zeros(1,M);
bb=b;
 N=length(s1);
 e=s1*0;
% figure()
   b1=zeros(1,N);
   b2=zeros(1,N);
   b3=zeros(1,N);
   b4=zeros(1,N);
   b5=zeros(1,N);
   b6=zeros(1,N);
   b7=zeros(1,N);
   b8=zeros(1,N);
 
 for k=1:N
     
     %if rem(k,20000)==0
    %     plot(b);
       %  ylim([-0.5 0.5]);
      %   drawnow
    % end
   yy(k)=sum(v.*b);
    d = [s4(k) d(1:M-1)];
     v = [s1(k) v(1:M-1)];
     e(k)=s4(k)-sum(v.*b);
     b=b + (u*e(k)*v);
     
     
     b1(k)=b(1);
     b2(k)=b(2);
     b3(k)=b(3);
     b4(k)=b(4);
     b5(k)=b(5);
     b6(k)=b(6);
     b7(k)=b(7);
     b8(k)=b(8);
     
     ee(k)=e(k);
 end
 nn=1:N;

 t=0:ts:(length(s1)/fs)-ts;

 subplot(3,1,1)
 plot(t,(e.^2))
 xlabel('Time in sec')
 ylabel('e(n)^2')
 grid on
%  subplot(3,1,2)
%  plot(b,'r')
%  hold on 
%  plot(bb,'b')
 subplot(3,1,2)
 plot(nn,b1,'k',nn,b2,'r',nn,b3,'b',nn,b4,'g')%,nn,b5,'r',nn,b6,'c',nn,b7,'m',nn,b8,'y')
 title('First coefficients')
 xlabel('Iteration no.')
 ylabel('Coefficient value')
 legend('b1','b2','b3','b4')
 grid on
 subplot(3,1,3)
 plot(t,s1,'b',t,s2,'r',t,s3,'g')%,t,s4,'k')
title('Blockview')
xlabel('Time in sec')
ylabel('Magnitude in gg')
 legend('s1','s2','s3')%,'s4')
%axis([0 0.1 -2 2])
grid on

%################## Playtime######## 
%   soundsc(e,fs)
%   pause(brk)

%  pause(time)
%  soundsc(yy,fs)
%  pause(time)
%  soundsc(s2,fs)
 
%  figure()
%  plot(t,e.^2,'b',t,s2.^2,'r')
%  
% middel0=rms(s1BM.^2)
%  middel1=rms(e.^2)%/rms(s1BM.^2)
%  middel2=rms(s4.^2)%/rms(s1BM.^2)
%  middel3=rms((s4.^2-e.^2))%/rms(s1BM.^2)
 
%  middel0=rms(s1BM)
%  middel1=rms(e)%/rms(s1BM.^2)
%  middel2=rms(s4)%/rms(s1BM.^2)
%  middel3=rms((s4-e))%/rms(s1BM.^2)
%  
%  middel1=middel1*ones(1,length(s2));
%  middel2=middel2*ones(1,length(s2));
%  middel3=middel3*ones(1,length(s2));
%  
%  figure()
%  plot(t,mag2db(s2.^2-e.^2),'b',t,mag2db(middel1),'--k',t,mag2db(middel2),'--y',t,mag2db(middel3),'m',t,mag2db(middel0),'c')
%  legend('differens', 'middel e','middel s4','middel differens','middel0')
%  grid on
%  ylim([-40 35])


 
soundsc(ee,fs)
figure()
plot(t,abs(ee),'b',t,abs(s2),'r')

 [mag lag]=xcorr(ee,s1);
 [maxmags2 maxinds2] = max(abs(mag(length(ee)-100:length(ee)+100)))
 mags2=mag(length(ee)+(maxinds2-101))
 ind0mags2norm=abs(mags2)/length(ee)
 
 figure()
 plot(lag, mag)

clear b b1 b2 b3 b4 b5 b6 b7 b8 bb M k u

%% Statistik
clc, close all
Es1=mean(abs(s1));
Vs1=var(abs(s1));
Ss1=std(abs(s1));

pds1=makedist('Normal','mu',Es1,'sigma',Ss1)
 pdfs1=pdf(pds1,t);
 
 Es2=mean(abs(s2filt));
Vs2=var(abs(s2filt));
Ss2=std(abs(s2filt));

pds2=makedist('Normal','mu',Es2,'sigma',Ss2)
 pdfs2=pdf(pds2,t);
 
 Es3=mean(abs(s4));
Vs3=var(abs(s4));
Ss3=std(abs(s4));

pds3=makedist('Normal','mu',Es3,'sigma',Ss3)
 pdfs3=pdf(pds3,t);
 
 Eee=mean(abs(ee));
Vee=var(abs(ee));
See=std(abs(ee));

pdee=makedist('Normal','mu',Eee,'sigma',See)
 pdfee=pdf(pdee,t);

 figure()
plot(t,pdfs1,'b',t,pdfs2,'r',t,pdfs3,'g',t,pdfee,'k')
legend('s1','s2filt','s3','ee')
grid on
grid minor
xlim([0 3])

clear Es1 Es2 Es3 Eee Ss1 Ss2 Ss3 See Vs1 Vs2 Vs3 Vee pdfs1 pdfs2 pdfs3 pdfee pds1 pds2 pds3 pdee

%% xcorr SNR
close all, clc
[mags4 lag]=xcorr(s2filt,s1);

figure()
plot(lag,mags4)
grid on

[magmaxs4 indexmax] = max(abs(mags4))

S_snr=lag(indexmax);
rmss4=rms(mags4)

[magee lag]=xcorr(ee,s1);

figure()
plot(lag,magee)
grid on

[magmaxee indexmax] = max(abs(magee))

S_snr=lag(indexmax);
rmsee=rms(magee)

RATIO=mags4((length(s4)))/length(s4)
magee((length(s4)));
soundsc(s4,fs)