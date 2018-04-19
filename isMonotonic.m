function outdat = isMonotonic(imf)

if length(findpeaks(imf))*length(findpeaks(-imf)) == 0
    outdat = 1;
else
    outdat = 0;
end