close all, clear all, clc
A = [1 0 0;
    0 1 0;
    0 -2 0;
    -1 0 0;
    -1 0 -0.7;
    1 0 0.7;
    1.5 2.8 0;
    -0.2 -0.4 -0.1;
    1.1 0.1 -0.4;
    0 0 2;
    -7 7 0]

A2 = [0 0 1;
    90 0 1;
    270 0 2;
    180 0 1;
    180 -30 1;
    0 30 1;
    60 10 3;
    240 -10 0.5;
    5 -20 1.1;
    0 90 2;
    135 0 9.8];

azimeandiff = zeros(1,10);
elemeandiff = zeros(1,10);
distmeandiff = zeros(1,10);

azistddiff = zeros(1,10);
elestddiff = zeros(1,10);
diststddiff = zeros(1,10);

figure()
plot3(0,0,0,'r o')
title('Placement of testsignals')
hold on
xlabel('X');
ylabel('Y');
zlabel('Z');
plot3(A(:,1),A(:,2),A(:,3),'b o')
grid on
legend('Listener position','Testsignal')

%% Test 1
%close all
j=2;
T1 = [0.3 0.3 0.4;
    0 1 0;
    0 1 0;
    0 0.5 0;
    0 1.9 0.7;
    0.4 0.6 0.7;
    0 0.4 0.4;
    0 1 0;
    0 0.5 0];

T2 = [45 45 0.5;
    90 0 1;
    90 0 1;
    90 0 1;
    90 20 1;
    60 45 1;
    90 45 0.5;
    90 0 1;
    90 0 0.5   ];

mu=mean(T2);
rho = std(T2);
x1=[30:.01:130];
x2=[-50:.01:80];
x3=[-1:.01:2];
normazi = normpdf(x1,mu(1),rho(1));
normele = normpdf(x2,mu(2),rho(2));
normdis = normpdf(x3,mu(3),rho(3));

azimeandiff(j-1) = A2(j,1)-mu(1);
elemeandiff(j-1) = A2(j,2)-mu(2);
dismeandiff(j-1) = A2(j,3)-mu(3);

azistddiff(j-1) = rho(1);
elestddiff(j-1) = rho(2);
diststddiff(j-1) = rho(3);

figure()
subplot(3,1,1)
plot(x1,normazi,'b')
title('Testsignal no. 1')
grid on
hold on
(line([A2(j,1) A2(j,1)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','o'))
legend('Azimuth answers','Actual Azimuth')%,'Elevation answers','Actual Elevation','Distance answers','Actual Distance')

subplot(3,1,2)
plot(x2,normele,'g')
grid on
hold on
(line([A2(j,2) A2(j,2)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','+'))
legend('Elevation answers','Actual Elevation')%,'Distance answers','Actual Distance')

subplot(3,1,3)
plot(x3,normdis,'y')
hold on
(line([A2(j,3) A2(j,3)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','*'))
grid on
legend('Distance answers','Actual Distance')


figure()
plot3(0,0,0,'r o','Markersize',10)
title('Test no. 1 answers')
hold on
xlabel('X');
ylabel('Y');
zlabel('Z');
plot3(A(2,1),A(2,2),A(2,3),'b o','Markersize',10)
grid on
plot3(T1(:,1),T1(:,2),T1(:,3),'g o')
legend('Listener position','Testsignal','Answers','Location','NorthEast')

%% Test 2
%close all
j=3;
T1 = [0 -10 0;
    0 0.5 0;
    -5.8 -5.8 -5.7;
    -4.3 -4.3 -3.5;
    -0.4 -0.8 -0.5;
    -1.3 -3.5 -1.4;
    0 -7.1 7.1;
    0.9 -1.5 4.7;
    0 -0.4 0.4];

T2 = [270 0 10;
    90 0 0.5;
    225 -35 10;
    225 -30 7;
    240 -30 1;
    250 -20 4;
    270 45 10;
    300 70 5;
    270 45 0.5];

mu=mean(T2);
rho = std(T2);
x1=[50:.01:400];
x2=[-100:.01:120];
x3=[-5:.01:20];
normazi = normpdf(x1,mu(1),rho(1));
normele = normpdf(x2,mu(2),rho(2));
normdis = normpdf(x3,mu(3),rho(3));

azimeandiff(j-1) = A2(j,1)-mu(1);
elemeandiff(j-1) = A2(j,2)-mu(2);
dismeandiff(j-1) = A2(j,3)-mu(3);

azistddiff(j-1) = rho(1);
elestddiff(j-1) = rho(2);
diststddiff(j-1) = rho(3);

figure()
subplot(3,1,1)
plot(x1,normazi,'b')
title('Testsignal no. 2')
grid on
hold on
(line([A2(j,1) A2(j,1)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','o'))
legend('Azimuth answers','Actual Azimuth')%,'Elevation answers','Actual Elevation','Distance answers','Actual Distance')

subplot(3,1,2)
plot(x2,normele,'g')
grid on
hold on
(line([A2(j,2) A2(j,2)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','+'))
legend('Elevation answers','Actual Elevation')%,'Distance answers','Actual Distance')

subplot(3,1,3)
plot(x3,normdis,'y')
hold on
(line([A2(j,3) A2(j,3)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','*'))
grid on
legend('Distance answers','Actual Distance')

figure()
plot3(0,0,0,'r o','Markersize',10)
title('Test no. 2 answers')
hold on
xlabel('X');
ylabel('Y');
zlabel('Z');
plot3(A(j,1),A(j,2),A(j,3),'b o','Markersize',10)
grid on
plot3(T1(:,1),T1(:,2),T1(:,3),'g o')
legend('Listener position','Testsignal','Answers')

%% Test 3
%close all
j=4;
T1 = [1 0 0;
    0.5 0.5 0.7;
    1 0 0;
    1 0 0;
    1 0 0;
    0 0 1;
    1 0 0;
    1 0 0;
    0 0 5];

T2 = [0 0 1;
    45 45 1;
    0 0 1;
    0 0 1;
    0 0 1;
    0 90 1;
    0 0 1;
    0 0 1;
    270 90 5];

mu=mean(T2);
rho = std(T2);
x1=[-200:.01:300];
x2=[-80:.01:120];
x3=[-4:.01:8];
normazi = normpdf(x1,mu(1),rho(1));
normele = normpdf(x2,mu(2),rho(2));
normdis = normpdf(x3,mu(3),rho(3));

azimeandiff(j-1) = A2(j,1)-mu(1);
elemeandiff(j-1) = A2(j,2)-mu(2);
dismeandiff(j-1) = A2(j,3)-mu(3);

azistddiff(j-1) = rho(1);
elestddiff(j-1) = rho(2);
diststddiff(j-1) = rho(3);

figure()
subplot(3,1,1)
plot(x1,normazi,'b')
title('Testsignal no. 3')
grid on
hold on
(line([A2(j,1) A2(j,1)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','o'))
legend('Azimuth answers','Actual Azimuth')%,'Elevation answers','Actual Elevation','Distance answers','Actual Distance')

subplot(3,1,2)
plot(x2,normele,'g')
grid on
hold on
(line([A2(j,2) A2(j,2)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','+'))
legend('Elevation answers','Actual Elevation')%,'Distance answers','Actual Distance')

subplot(3,1,3)
plot(x3,normdis,'y')
hold on
(line([A2(j,3) A2(j,3)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','*'))
grid on
legend('Distance answers','Actual Distance')

figure()
plot3(0,0,0,'r o','Markersize',10)
title('Test no. 3 answers')
hold on
xlabel('X');
ylabel('Y');
zlabel('Z');
plot3(A(j,1),A(j,2),A(j,3),'b o','Markersize',10)
grid on
plot3(T1(:,1),T1(:,2),T1(:,3),'g o')
legend('Listener position','Testsignal','Answers')

%% Test 4
%close all
j=5;
T1 = [0.7 0 0.7;
    0.4 0 0.4;
    1 0 0;
    -1 0 0;
    4 0 0.3;
    0.6 -.4 .7;
    1 0 0;
    1 0 0;
    0 0 5];

T2 = [0 45 1;
    0 45 0.5;
    0 0 1;
    180 0 1;
    0 5 4;
    330 45 1;
    0 0 1;
    0 0 1;
    270 90 5];

mu=mean(T2);
rho = std(T2);
x1=[-200:.01:400];
x2=[-80:.01:150];
x3=[-4:.01:8];
normazi = normpdf(x1,mu(1),rho(1));
normele = normpdf(x2,mu(2),rho(2));
normdis = normpdf(x3,mu(3),rho(3));

azimeandiff(j-1) = A2(j,1)-mu(1);
elemeandiff(j-1) = A2(j,2)-mu(2);
dismeandiff(j-1) = A2(j,3)-mu(3);

azistddiff(j-1) = rho(1);
elestddiff(j-1) = rho(2);
diststddiff(j-1) = rho(3);

figure()
subplot(3,1,1)
plot(x1,normazi,'b')
title('Testsignal no. 4')
grid on
hold on
(line([A2(j,1) A2(j,1)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','o'))
legend('Azimuth answers','Actual Azimuth')%,'Elevation answers','Actual Elevation','Distance answers','Actual Distance')

subplot(3,1,2)
plot(x2,normele,'g')
grid on
hold on
(line([A2(j,2) A2(j,2)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','+'))
legend('Elevation answers','Actual Elevation')%,'Distance answers','Actual Distance')

subplot(3,1,3)
plot(x3,normdis,'y')
hold on
(line([A2(j,3) A2(j,3)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','*'))
grid on
legend('Distance answers','Actual Distance')

figure()
plot3(0,0,0,'r o','Markersize',10)
title('Test no. 4 answers')
hold on
xlabel('X');
ylabel('Y');
zlabel('Z');
plot3(A(j,1),A(j,2),A(j,3),'b o','Markersize',10)
grid on
plot3(T1(:,1),T1(:,2),T1(:,3),'g o')
legend('Listener position','Testsignal','Answers')

%% Test 5
%close all
j=6;
T1 = [-.7 0 .7;
    1.9 0 -1.6;
    1 0 0;
    2.5 -1.4 0.8;
    2.6 1.5 0.5;
    -0.5 -0.5 0.7;
    0.5 0 0;
    -1.7 0 4.7;
    0 0 5];


T2 = [180 45 1;
    0 -40 2.5;
    0 0 1;
    330 15 3;
    30 10 3;
    225 45 1;
    0 0 0.5;
    180 70 5;
    270 90 5];

mu=mean(T2);
rho = std(T2);
x1=[-200:.01:400];
x2=[-80:.01:150];
x3=[-3:.01:8];
normazi = normpdf(x1,mu(1),rho(1));
normele = normpdf(x2,mu(2),rho(2));
normdis = normpdf(x3,mu(3),rho(3));

azimeandiff(j-1) = A2(j,1)-mu(1);
elemeandiff(j-1) = A2(j,2)-mu(2);
dismeandiff(j-1) = A2(j,3)-mu(3);

azistddiff(j-1) = rho(1);
elestddiff(j-1) = rho(2);
diststddiff(j-1) = rho(3);

figure()
subplot(3,1,1)
plot(x1,normazi,'b')
title('Testsignal no. 5')
grid on
hold on
(line([A2(j,1) A2(j,1)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','o'))
legend('Azimuth answers','Actual Azimuth')%,'Elevation answers','Actual Elevation','Distance answers','Actual Distance')

subplot(3,1,2)
plot(x2,normele,'g')
grid on
hold on
(line([A2(j,2) A2(j,2)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','+'))
legend('Elevation answers','Actual Elevation')%,'Distance answers','Actual Distance')

subplot(3,1,3)
plot(x3,normdis,'y')
hold on
(line([A2(j,3) A2(j,3)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','*'))
grid on
legend('Distance answers','Actual Distance')


figure()
plot3(0,0,0,'r o','Markersize',10)
title('Test no. 5 answers')
hold on
xlabel('X');
ylabel('Y');
zlabel('Z');
plot3(A(j,1),A(j,2),A(j,3),'b o','Markersize',10)
grid on
plot3(T1(:,1),T1(:,2),T1(:,3),'g o')
legend('Listener position','Testsignal','Answers')

%% Test 6
%close all
j=7;
T1 = [-3.2 1.5 3.5;
    0 7.1 7.1;
    0 5 0;
    0 7.7 -6.4;
    0 8 0;
    -1.5 1.5 -1.3;
    0 10 0;
    -1.6 9.3 -3.4;
    0 5 0];


T2 = [155 45 5;
    90 45 10;
    90 0 5;
    90 -40 10;
    90 0 8;
    135 -30 2.5;
    90 0 10; 
    100 -20 10;
    90 0 5];

mu=mean(T2);
rho = std(T2);
x1=[30:.01:200];
x2=[-100:.01:80];
x3=[-1:.01:15];
normazi = normpdf(x1,mu(1),rho(1));
normele = normpdf(x2,mu(2),rho(2));
normdis = normpdf(x3,mu(3),rho(3));

azimeandiff(j-1) = A2(j,1)-mu(1);
elemeandiff(j-1) = A2(j,2)-mu(2);
dismeandiff(j-1) = A2(j,3)-mu(3);

azistddiff(j-1) = rho(1);
elestddiff(j-1) = rho(2);
diststddiff(j-1) = rho(3);

figure()
subplot(3,1,1)
plot(x1,normazi,'b')
title('Testsignal no. 6')
grid on
hold on
(line([A2(j,1) A2(j,1)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','o'))
legend('Azimuth answers','Actual Azimuth')%,'Elevation answers','Actual Elevation','Distance answers','Actual Distance')

subplot(3,1,2)
plot(x2,normele,'g')
grid on
hold on
(line([A2(j,2) A2(j,2)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','+'))
legend('Elevation answers','Actual Elevation')%,'Distance answers','Actual Distance')

subplot(3,1,3)
plot(x3,normdis,'y')
hold on
(line([A2(j,3) A2(j,3)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','*'))
grid on
legend('Distance answers','Actual Distance')


figure()
plot3(0,0,0,'r o','Markersize',10)
title('Test no. 6 answers')
hold on
xlabel('X');
ylabel('Y');
zlabel('Z');
plot3(A(j,1),A(j,2),A(j,3),'b o','Markersize',10)
grid on
plot3(T1(:,1),T1(:,2),T1(:,3),'g o')
legend('Listener position','Testsignal','Answers')

%% Test 7
%close all
j=8;
T1 = [0 -.4 .4;
    0 -5 0;
    -2.7 -2.7 -3.2;
    0.9 -4.9 0;
    -0.3 -0.4 0;
    -0.3 -0.4 0;
    0.1 -0.4 0.3;
    0 -0.9 0.3;
    0 0 5];


T2 = [270 45 0.5;
    270 0 5;
    225 -40 5;
    280 0 5;
    240 0 0.5;
    235 0 0.5;
    290 30 0.5;
    270 20 1;
    270 90 0.5];

mu=mean(T2);
rho = std(T2);
x1=[150:.01:350];
x2=[-80:.01:120];
x3=[-5:.01:10];
normazi = normpdf(x1,mu(1),rho(1));
normele = normpdf(x2,mu(2),rho(2));
normdis = normpdf(x3,mu(3),rho(3));

azimeandiff(j-1) = A2(j,1)-mu(1);
elemeandiff(j-1) = A2(j,2)-mu(2);
dismeandiff(j-1) = A2(j,3)-mu(3);

azistddiff(j-1) = rho(1);
elestddiff(j-1) = rho(2);
diststddiff(j-1) = rho(3);

figure()
subplot(3,1,1)
plot(x1,normazi,'b')
title('Testsignal no. 7')
grid on
hold on
(line([A2(j,1) A2(j,1)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','o'))
legend('Azimuth answers','Actual Azimuth')%,'Elevation answers','Actual Elevation','Distance answers','Actual Distance')

subplot(3,1,2)
plot(x2,normele,'g')
grid on
hold on
(line([A2(j,2) A2(j,2)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','+'))
legend('Elevation answers','Actual Elevation')%,'Distance answers','Actual Distance')

subplot(3,1,3)
plot(x3,normdis,'y')
hold on
(line([A2(j,3) A2(j,3)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','*'))
grid on
legend('Distance answers','Actual Distance')


figure()
plot3(0,0,0,'r o','Markersize',10)
title('Test no. 7 answers')
hold on
xlabel('X');
ylabel('Y');
zlabel('Z');
plot3(A(j,1),A(j,2),A(j,3),'b o','Markersize',10)
grid on
plot3(T1(:,1),T1(:,2),T1(:,3),'g o')
legend('Listener position','Testsignal','Answers')

%% Test 8 
%close all
j=9;
T1 = [5 0 0;
    5 0 0;
    -2.9 2.9 -2.9;
    -1.3 1.3 -.7;
    0.8 1.4 1.1;
    0 0 1;
    1 0 0;
    4.9 0 0.9;
    0 0 5];


T2 = [0 0 5;
    0 0 5;
    135 -35 5;
    135 -20 2;
    60 35 2;
    0 90 1;
    0 0 1;
    0 10 5;
    270 90 5];

mu=mean(T2);
rho = std(T2);
x1=[-100:.01:300];
x2=[-80:.01:120];
x3=[-1:.01:10];
normazi = normpdf(x1,mu(1),rho(1));
normele = normpdf(x2,mu(2),rho(2));
normdis = normpdf(x3,mu(3),rho(3));

azimeandiff(j-1) = A2(j,1)-mu(1);
elemeandiff(j-1) = A2(j,2)-mu(2);
dismeandiff(j-1) = A2(j,3)-mu(3);

azistddiff(j-1) = rho(1);
elestddiff(j-1) = rho(2);
diststddiff(j-1) = rho(3);

figure()
subplot(3,1,1)
plot(x1,normazi,'b')
title('Testsignal no. 8')
grid on
hold on
(line([A2(j,1) A2(j,1)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','o'))
legend('Azimuth answers','Actual Azimuth')%,'Elevation answers','Actual Elevation','Distance answers','Actual Distance')

subplot(3,1,2)
plot(x2,normele,'g')
grid on
hold on
(line([A2(j,2) A2(j,2)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','+'))
legend('Elevation answers','Actual Elevation')%,'Distance answers','Actual Distance')

subplot(3,1,3)
plot(x3,normdis,'y')
hold on
(line([A2(j,3) A2(j,3)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','*'))
grid on
legend('Distance answers','Actual Distance')

figure()
plot3(0,0,0,'r o','Markersize',10)
title('Test no. 8 answers')
hold on
xlabel('X');
ylabel('Y');
zlabel('Z');
plot3(A(j,1),A(j,2),A(j,3),'b o','Markersize',10)
grid on
plot3(T1(:,1),T1(:,2),T1(:,3),'g o')
legend('Listener position','Testsignal','Answers','Location','NorthEast')

%% Test 9
%close all
j=10;
T1 = [-5 0 0;
    7.7 0 -6.4;
    0 -10 0;
    -4.4 1.6 -1.7;
    3.1 -3.1 -2.5;
    -1.4 1.4 0;
    5.6 0 2.1;
    -6.6 0 -2.4;
    0 -1 0];


T2 = [180 0 5;
    0 -40 10;
    270 0 10;
    160 -20 5;
    315 -30 5;
    135 0 2;
    0 20 6;
    180 -20 7;
    270 0 1];

mu=mean(T2);
rho = std(T2);
x1=[-60:.01:360];
x2=[-60:.01:40];
x3=[-1:.01:15];
normazi = normpdf(x1,mu(1),rho(1));
normele = normpdf(x2,mu(2),rho(2));
normdis = normpdf(x3,mu(3),rho(3));

azimeandiff(j-1) = A2(j,1)-mu(1);
elemeandiff(j-1) = A2(j,2)-mu(2);
dismeandiff(j-1) = A2(j,3)-mu(3);

azistddiff(j-1) = rho(1);
elestddiff(j-1) = rho(2);
diststddiff(j-1) = rho(3);

figure()
subplot(3,1,1)
plot(x1,normazi,'b')
title('Testsignal no. 9')
grid on
hold on
(line([A2(j,1) A2(j,1)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','o'))
legend('Azimuth answers','Actual Azimuth')%,'Elevation answers','Actual Elevation','Distance answers','Actual Distance')

subplot(3,1,2)
plot(x2,normele,'g')
grid on
hold on
(line([A2(j,2) A2(j,2)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','+'))
legend('Elevation answers','Actual Elevation')%,'Distance answers','Actual Distance')

subplot(3,1,3)
plot(x3,normdis,'y')
hold on
(line([A2(j,3) A2(j,3)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','*'))
grid on
legend('Distance answers','Actual Distance')

figure()
plot3(0,0,0,'r o','Markersize',10)
title('Test no. 9 answers')
hold on
xlabel('X');
ylabel('Y');
zlabel('Z');
plot3(A(j,1),A(j,2),A(j,3),'b o','Markersize',10)
grid on
plot3(T1(:,1),T1(:,2),T1(:,3),'g o')
legend('Listener position','Testsignal','Answers')

%% Test 10
%close all
j=11;
T1 = [10 0 0;
    0 -9.8 1.7;
    -5.4 5.4 -6.4;
    -7.2 2.6 -6.4;
    3.8 6.6 -6.4;
    -5.3 5.3 -2.7;
    -1.5 8.5 5;
    2.8 2 9.4;
    0.9 4.9 0];


T2 = [0 0 10;
    270 10 10;
    135 -40 10;
    160 -40 10;
    60 -40 10;
    135 -20 8;
    100 30 10; 
    35 70 10;
    80 0 5];

mu=mean(T2);
rho = std(T2);
x1=[-100:.01:250];
x2=[-80:.01:80];
x3=[4:.01:14];
normazi = normpdf(x1,mu(1),rho(1));
normele = normpdf(x2,mu(2),rho(2));
normdis = normpdf(x3,mu(3),rho(3));

azimeandiff(j-1) = A2(j,1)-mu(1)
elemeandiff(j-1) = A2(j,2)-mu(2)
dismeandiff(j-1) = A2(j,3)-mu(3)

azistddiff(j-1) = rho(1);
elestddiff(j-1) = rho(2);
diststddiff(j-1) = rho(3);

figure()
subplot(3,1,1)
plot(x1,normazi,'b')
title('Testsignal no. 10')
grid on
hold on
(line([A2(j,1) A2(j,1)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','o'))
legend('Azimuth answers','Actual Azimuth')%,'Elevation answers','Actual Elevation','Distance answers','Actual Distance')

subplot(3,1,2)
plot(x2,normele,'g')
grid on
hold on
(line([A2(j,2) A2(j,2)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','+'))
legend('Elevation answers','Actual Elevation')%,'Distance answers','Actual Distance')

subplot(3,1,3)
plot(x3,normdis,'y')
hold on
(line([A2(j,3) A2(j,3)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','*'))
grid on
legend('Distance answers','Actual Distance')

figure()
plot3(0,0,0,'r o','Markersize',10)
title('Test no. 10 answers')
hold on
xlabel('X');
ylabel('Y');
zlabel('Z');
plot3(A(j,1),A(j,2),A(j,3),'b o','Markersize',10)
grid on
plot3(T1(:,1),T1(:,2),T1(:,3),'g o')
legend('Listener position','Testsignal','Answers')

%%
%close all

figure()
bar([abs(azimeandiff') abs(elemeandiff') abs(dismeandiff')])
grid on

figure()
bar([abs(azistddiff') abs(elestddiff') abs(diststddiff')])
grid on
title('Spredning')

figure()
subplot(3,1,1)
b1=bar(abs(azimeandiff'),'b' )
grid on
title('Azimuth differences')
xlabel('Test no.')
ylabel('Difference')
%b1(1).LineWidth = 2;
%b1(1).EdgeColor = 'red';
subplot(3,1,2)
bar( abs(elemeandiff'),'g' )
grid on
title('Elevation differences')
xlabel('Test no.')
ylabel('Difference')


subplot(3,1,3)
bar( abs(dismeandiff'),'y')
grid on
title('Distance differences')
xlabel('Test no.')
ylabel('Difference')

figure()
subplot(3,1,1)
b1=bar(abs(azistddiff'),'b' )
grid on
title('Azimuth spredning')
xlabel('Test no.')
ylabel('Spredning')
%b1(1).LineWidth = 2;
%b1(1).EdgeColor = 'red';
subplot(3,1,2)
bar( abs(elestddiff'),'g' )
grid on
title('Elevation spredning')
xlabel('Test no.')
ylabel('Spredning')


subplot(3,1,3)
bar( abs(diststddiff'),'y')
grid on
title('Distance spredning')
xlabel('Test no.')
ylabel('Spredning')

[azimin aziind] = min(abs(azimeandiff))
[elemin eleind] = min(abs(elemeandiff))
[dismin disind] = min(abs(dismeandiff))

[azimaks aziindma] = max(abs(azimeandiff))
[elemaks eleindma] = max(abs(elemeandiff))
[dismaks disindma] = max(abs(dismeandiff))

%% All plots

T1 = [0.3 0.3 0.4;
    0 1 0;
    0 1 0;
    0 0.5 0;
    0 1.9 0.7;
    0.4 0.6 0.7;
    0 0.4 0.4;
    0 1 0;
    0 0.5 0];
T2 = [0 -10 0;
    0 0.5 0;
    -5.8 -5.8 -5.7;
    -4.3 -4.3 -3.5;
    -0.4 -0.8 -0.5;
    -1.3 -3.5 -1.4;
    0 -7.1 7.1;
    0.9 -1.5 4.7;
    0 -0.4 0.4];
T3 = [1 0 0;
    0.5 0.5 0.7;
    1 0 0;
    1 0 0;
    1 0 0;
    0 0 1;
    1 0 0;
    1 0 0;
    0 0 5];
T4 = [0.7 0 0.7;
    0.4 0 0.4;
    1 0 0;
    -1 0 0;
    4 0 0.3;
    0.6 -.4 .7;
    1 0 0;
    1 0 0;
    0 0 5];
T5 = [-.7 0 .7;
    1.9 0 -1.6;
    1 0 0;
    2.5 -1.4 0.8;
    2.6 1.5 0.5;
    -0.5 -0.5 0.7;
    0.5 0 0;
    -1.7 0 4.7;
    0 0 5];
T6 = [-3.2 1.5 3.5;
    0 7.1 7.1;
    0 5 0;
    0 7.7 -6.4;
    0 8 0;
    -1.5 1.5 -1.3;
    0 10 0;
    -1.6 9.3 -3.4;
    0 5 0];
T7 = [0 -.4 .4;
    0 -5 0;
    -2.7 -2.7 -3.2;
    0.9 -4.9 0;
    -0.3 -0.4 0;
    -0.3 -0.4 0;
    0.1 -0.4 0.3;
    0 -0.9 0.3;
    0 0 5];
T8 = [5 0 0;
    5 0 0;
    -2.9 2.9 -2.9;
    -1.3 1.3 -.7;
    0.8 1.4 1.1;
    0 0 1;
    1 0 0;
    4.9 0 0.9;
    0 0 5]; 
T9 = [-5 0 0;
    7.7 0 -6.4;
    0 -10 0;
    -4.4 1.6 -1.7;
    3.1 -3.1 -2.5;
    -1.4 1.4 0;
    5.6 0 2.1;
    -6.6 0 -2.4;
    0 -1 0]; 
T10 = [10 0 0;
    0 -9.8 1.7;
    -5.4 5.4 -6.4;
    -7.2 2.6 -6.4;
    3.8 6.6 -6.4;
    -5.3 5.3 -2.7;
    -1.5 8.5 5;
    2.8 2 9.4;
    0.9 4.9 0];


figure()
plot3(0,0,0,'r o','Markersize',10)
title('All testplots')
hold on
xlabel('X');
ylabel('Y');
zlabel('Z');
plot3(A(:,1),A(:,2),A(:,3),'b o','Markersize',10)
grid on
plot3(T1(:,1),T1(:,2),T1(:,3),'g o')
plot3(T2(:,1),T2(:,2),T2(:,3),'g o')
plot3(T3(:,1),T3(:,2),T3(:,3),'g o')
plot3(T4(:,1),T4(:,2),T4(:,3),'g o')
plot3(T5(:,1),T5(:,2),T5(:,3),'g o')
plot3(T6(:,1),T6(:,2),T6(:,3),'g o')
plot3(T7(:,1),T7(:,2),T7(:,3),'g o')
plot3(T8(:,1),T8(:,2),T8(:,3),'g o')
plot3(T9(:,1),T9(:,2),T9(:,3),'g o')
plot3(T10(:,1),T10(:,2),T10(:,3),'g o')
legend('Listener position','Testsignals','Answers','Location','NorthEast')