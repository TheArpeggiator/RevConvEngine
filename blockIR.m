% Function to create block-wise FFT for the IR
function [IR,irBL] = blockIR(ir, bufSize)

loc = 1;
IR = [];

for i = 1:(length(ir)/bufSize)
    tempir = [ir(loc:loc+bufSize-1), zeros(1,bufSize)];
    IR = [IR, fft(tempir)];
    loc = loc+bufSize;    
end
irBL = length(ir)/bufSize;
end