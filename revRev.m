clear all
close all
clc

% Program to test rev-reverb audio effect
% Set appropraite variables
bufSize = 1024;
loc = 1;

inBuffer  = [];
outBuffer = [];

% Final output
output = [];

% Load impulse response
[ir, fs] = audioread('smallRoom.wav');

% Uncomment for stereo IRs
% ir = flip(ir(:,1)');
ir = flip(ir');
extraL = zeros(1,2^nextpow2(length(ir)) - length(ir));
ir = [ir, extraL];
[IR,irBL] = blockIR(ir,bufSize);
tempBuffer = zeros(1,length(IR));

% Load audio file to apply effect to
[guitar] = audioread('stt.wav')';

% Set length of audio file to be power of 2 for ease of calculation
extraL = zeros(1,2^nextpow2(length(guitar)) - length(guitar));
guitar = [guitar, extraL];

% Overlap and Add method
% Create Block-By-Block Effect Calculation
for i = 1:(length(guitar)/bufSize)
    inBuffer = guitar(loc:loc+bufSize-1);
    fftBuffer = doMagic(inBuffer,IR,irBL,bufSize);
    
    % Set output buffer
    % In the case of an actual plugin, this outBuffer block should be
    % the return of the audioCallback function
    outBuffer = tempBuffer + fftBuffer;
    tempBuffer = [outBuffer(bufSize+1:end),zeros(1,bufSize)];
    % Set next position for audio file
    loc = loc+bufSize;
    
    % Set final output for the purpose of nonRealTime calculation
    output = [output, outBuffer(1:bufSize)];
end

output = output/max(abs(output));
audiowrite('revRev.wav',output,fs);