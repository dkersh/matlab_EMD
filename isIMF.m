function outdat = isIMF(imf)

zc = length(zeroCrossings(imf));
exNum = length(findpeaks(imf)) + length(findpeaks(-imf)) + 1;

[upper,lower] = envelope(imf);

if(abs(exNum - zc) <= 1)
    outdat = 1;
else
    outdat = 0;
    
end