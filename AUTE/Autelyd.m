close all

fs=48000;
Lyd = [MatRecData(:,7) MatRecData(:,8)];
sound(Lyd,fs)

audiowrite('Reference.wav',Lyd,fs)

%%
close all
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

figure()
plot3(0,0,0,'r o')
hold on
plot3(A(:,1),A(:,2),A(:,3),'b o')
grid on

%% MERGE

Ref = audioread('Reference.wav');
S1 = audioread('Signal1.wav');
Test1 = [Ref' S1' Ref' S1' Ref'];
%sound(Test1,fs)
audiowrite('Test1.wav',Test1',fs);

S2 = audioread('Signal2.wav');
Test2 = [Ref' S2' Ref' S2' Ref'];
%sound(Test1,fs)
audiowrite('Test2.wav',Test2',fs);

S3 = audioread('Signal3.wav');
Test3 = [Ref' S3' Ref' S3' Ref'];
%sound(Test1,fs)
audiowrite('Test3.wav',Test3',fs);

S4 = audioread('Signal4.wav');
Test4 = [Ref' S4' Ref' S4' Ref'];
%sound(Test1,fs)
audiowrite('Test4.wav',Test4',fs);

S5 = audioread('Signal5.wav');
Test5 = [Ref' S5' Ref' S5' Ref'];
%sound(Test1,fs)
audiowrite('Test5.wav',Test5',fs);

S6 = audioread('Signal6.wav');
Test6 = [Ref' S6' Ref' S6' Ref'];
%sound(Test1,fs)
audiowrite('Test6.wav',Test6',fs);

S7 = audioread('Signal7.wav');
Test7 = [Ref' S7' Ref' S7' Ref'];
%sound(Test1,fs)
audiowrite('Test7.wav',Test7',fs);

S8 = audioread('Signal8.wav');
Test8 = [Ref' S8' Ref' S8' Ref'];
%sound(Test1,fs)
audiowrite('Test8.wav',Test8',fs);

S9 = audioread('Signal9.wav');
Test9 = [Ref' S9' Ref' S9' Ref'];
%sound(Test1,fs)
audiowrite('Test9.wav',Test9',fs);

S10 = audioread('Signal10.wav');
Test10 = [Ref' S10' Ref' S10' Ref'];
%sound(Test1,fs)
audiowrite('Test10.wav',Test10',fs);

%%
plot(Ref)
