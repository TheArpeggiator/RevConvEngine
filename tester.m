clear all
close all
clc

[ir,fs] = audioread('chamber.wav');
[guitar] = audioread('stt.wav');
ir = flip(ir);

% out = fftfilt(ir,guitar);
% audiowrite('temp.wav',out,fs);