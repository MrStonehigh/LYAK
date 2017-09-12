clear all, clc, close all

load ir_examples.mat

ts=1/fs;
n=0:ts:(length(h_lspk)*ts)-ts;

figure()
plot(n,h_lspk)
title('h_{lspk}')
xlabel('time in sec')
ylabel('Magnitude in gg')
grid on

figure()
plot(n,h_room)
title('h_{room}')
xlabel('time in sec')
ylabel('Magnitude in gg')
grid on

[y ym]=rceps(h_room);

figure()
polarplot(y)

