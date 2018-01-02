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
    0 0 2;
    135 0 9.8];

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
close all
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

figure()
subplot(3,1,1)
plot(x1,normazi,'b')
title('Testsignal no. 1')
hold on
(line([A2(j,1) A2(j,1)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','o'))
legend('Azimuth answers','Actual Azimuth')%,'Elevation answers','Actual Elevation','Distance answers','Actual Distance')

subplot(3,1,2)
plot(x2,normele,'g')
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
legend('Listener position','Testsignal','Answers')

%% Test 2
close all
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

T2 = [  ];

mu=mean(T2);
rho = std(T2);
x1=[30:.01:130];
x2=[-50:.01:80];
x3=[-1:.01:2];
normazi = normpdf(x1,mu(1),rho(1));
normele = normpdf(x2,mu(2),rho(2));
normdis = normpdf(x3,mu(3),rho(3));

figure()
subplot(3,1,1)
plot(x1,normazi,'b')
title('Testsignal no. 2')
hold on
(line([A2(j,1) A2(j,1)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','o'))
legend('Azimuth answers','Actual Azimuth')%,'Elevation answers','Actual Elevation','Distance answers','Actual Distance')

subplot(3,1,2)
plot(x2,normele,'g')
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
close all
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

T2 = [  ];

mu=mean(T2);
rho = std(T2);
x1=[30:.01:130];
x2=[-50:.01:80];
x3=[-1:.01:2];
normazi = normpdf(x1,mu(1),rho(1));
normele = normpdf(x2,mu(2),rho(2));
normdis = normpdf(x3,mu(3),rho(3));

figure()
subplot(3,1,1)
plot(x1,normazi,'b')
title('Testsignal no. 3')
hold on
(line([A2(j,1) A2(j,1)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','o'))
legend('Azimuth answers','Actual Azimuth')%,'Elevation answers','Actual Elevation','Distance answers','Actual Distance')

subplot(3,1,2)
plot(x2,normele,'g')
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
close all
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

T2 = [   ];

mu=mean(T2);
rho = std(T2);
x1=[30:.01:130];
x2=[-50:.01:80];
x3=[-1:.01:2];
normazi = normpdf(x1,mu(1),rho(1));
normele = normpdf(x2,mu(2),rho(2));
normdis = normpdf(x3,mu(3),rho(3));

figure()
subplot(3,1,1)
plot(x1,normazi,'b')
title('Testsignal no. 4')
hold on
(line([A2(j,1) A2(j,1)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','o'))
legend('Azimuth answers','Actual Azimuth')%,'Elevation answers','Actual Elevation','Distance answers','Actual Distance')

subplot(3,1,2)
plot(x2,normele,'g')
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
close all
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


T2 = [  ];

mu=mean(T2);
rho = std(T2);
x1=[30:.01:130];
x2=[-50:.01:80];
x3=[-1:.01:2];
normazi = normpdf(x1,mu(1),rho(1));
normele = normpdf(x2,mu(2),rho(2));
normdis = normpdf(x3,mu(3),rho(3));

figure()
subplot(3,1,1)
plot(x1,normazi,'b')
title('Testsignal no. 5')
hold on
(line([A2(j,1) A2(j,1)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','o'))
legend('Azimuth answers','Actual Azimuth')%,'Elevation answers','Actual Elevation','Distance answers','Actual Distance')

subplot(3,1,2)
plot(x2,normele,'g')
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
close all
j=7;
T1 = [ ];


T2 = [   ];

mu=mean(T2);
rho = std(T2);
x1=[30:.01:130];
x2=[-50:.01:80];
x3=[-1:.01:2];
normazi = normpdf(x1,mu(1),rho(1));
normele = normpdf(x2,mu(2),rho(2));
normdis = normpdf(x3,mu(3),rho(3));

figure()
subplot(3,1,1)
plot(x1,normazi,'b')
title('Testsignal no. 6')
hold on
(line([A2(j,1) A2(j,1)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','o'))
legend('Azimuth answers','Actual Azimuth')%,'Elevation answers','Actual Elevation','Distance answers','Actual Distance')

subplot(3,1,2)
plot(x2,normele,'g')
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
close all
j=8;
T1 = [ ];


T2 = [   ];

mu=mean(T2);
rho = std(T2);
x1=[30:.01:130];
x2=[-50:.01:80];
x3=[-1:.01:2];
normazi = normpdf(x1,mu(1),rho(1));
normele = normpdf(x2,mu(2),rho(2));
normdis = normpdf(x3,mu(3),rho(3));

figure()
subplot(3,1,1)
plot(x1,normazi,'b')
title('Testsignal no. 7')
hold on
(line([A2(j,1) A2(j,1)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','o'))
legend('Azimuth answers','Actual Azimuth')%,'Elevation answers','Actual Elevation','Distance answers','Actual Distance')

subplot(3,1,2)
plot(x2,normele,'g')
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
close all
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

figure()
subplot(3,1,1)
plot(x1,normazi,'b')
title('Testsignal no. 1')
hold on
(line([A2(j,1) A2(j,1)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','o'))
legend('Azimuth answers','Actual Azimuth')%,'Elevation answers','Actual Elevation','Distance answers','Actual Distance')

subplot(3,1,2)
plot(x2,normele,'g')
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

%% Test 3
close all
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

figure()
subplot(3,1,1)
plot(x1,normazi,'b')
title('Testsignal no. 1')
hold on
(line([A2(j,1) A2(j,1)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','o'))
legend('Azimuth answers','Actual Azimuth')%,'Elevation answers','Actual Elevation','Distance answers','Actual Distance')

subplot(3,1,2)
plot(x2,normele,'g')
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

%% Test 3
close all
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

figure()
subplot(3,1,1)
plot(x1,normazi,'b')
title('Testsignal no. 1')
hold on
(line([A2(j,1) A2(j,1)],get(gca,'ylim'),'Color','r','LineWidth',1,'Marker','o'))
legend('Azimuth answers','Actual Azimuth')%,'Elevation answers','Actual Elevation','Distance answers','Actual Distance')

subplot(3,1,2)
plot(x2,normele,'g')
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
