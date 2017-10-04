% Function to perform buffer-by-buffer FFT convolution and return temporary
% signal which has 2x(length(inBuffer)) with reverb tail at the beginning

function [fftBuffer] = doMagic(inputBuffer, IR, irBL, bufSize)
fftBuffer = [];
inputBuffer = [inputBuffer,zeros(1,bufSize)];
loc = 1;
ipFFT = fft(inputBuffer);
for i = 1:irBL
    tempFFT = ipFFT.*IR(loc:loc+(2*bufSize)-1);
    tempIFFT = ifft(tempFFT);
    fftBuffer = [fftBuffer,tempIFFT];
    loc = loc+(2*bufSize);
end
end