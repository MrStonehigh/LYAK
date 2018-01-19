clc
clear all
close all

FS=1000;

%-90 to 90
PrimeAngle=4;
%0 to 4
Distance=4;
%Finds the angles, Angle is the the right of center, Angle2 is to the left
%of center
Angle=90-PrimeAngle;
Angle2=90+PrimeAngle;

%Finds if to the right or left
if le(PrimeAngle, 0)
    Switch=1;
else
    Switch=0;
end
    

%Finds the distance to each ear
A=((0.15^2)+(Distance^2)-2*(0.15)*Distance*cos(degtorad(Angle)))^(1/2);
B=((0.15^2)+(Distance^2)-2*(0.15)*Distance*cos(degtorad(Angle2)))^(1/2);

C=abs(B-A);

D=C/340;

%Finds the frame difference between the ears
D=D*1000;
D=round(D);

%Creates the tones in the sample
left=ones(10000, 1);
left=left*0;
x0=800:1000;
x1=x0+1000;
x2=x0+2000;
x3=x0+3000;
x4=x0+4000;
x5=x0+5000;
x6=x0+6000;
x7=x0+7000;
x8=x0+8000;
x9=x0+9000;
left(x0,:)=1;
left(x1,:)=1;
left(x2,:)=1;
left(x3,:)=1;
left(x4,:)=1;
left(x5,:)=1;
left(x6,:)=1;
left(x7,:)=1;
left(x8,:)=1;
left(x9,:)=1;

right=left;

%Creates the shift in sample time depending on data point D
y=(D+1):10000;
yshift=1:(10000-D);
z=1:D;

right(y,:)=right(yshift);
right(z,:)=0;

%Adjusts the volume of the sample depending on range and angle
left=left*(1/4*cos(degtorad(2*Angle))+1.25)*(-Distance^(1/2)+2.5);
right=right*(-1/2*cos(degtorad(2*Angle))+0.5)*(-Distance^(1/2) +2.5);

%Switches the samples to the appropriate ear depending on the PrimeAngle
if Switch==1
    column1=left;
    column2=right;
else
    column1=right;
    column2=left;
end

%Creates the 3D sounds vectors
threed(:,1)=column1;
threed(:,2)=column2;

%Plays the 3D sound vector
sound(threed, FS)