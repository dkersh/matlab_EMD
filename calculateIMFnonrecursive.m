function outdat = calculateIMFnonrecursive(x)

limit = 200;

x = x(:);

% figure
% hold('on');

for i=1:limit
tic;
    disp(['Iteration: ' int2str(i)]);
    %Need to improve the cubic spline fitting. Make it more natural.
    paddedX = [fliplr(x')'; x;fliplr(x')'];

    %generate extrema
    [maxima,maxPos] = findpeaks(paddedX);
    [minima,minPos] = findpeaks(-paddedX);
    minima = -minima;

    if length(maxima) > 1
        %fit cubic splines
        N = length(paddedX);
        maxSp = spline(maxPos,maxima,0:N-1)';
        minSp = spline(minPos,minima,0:N-1)';

        maxSp = maxSp(N/3+1:2*N/3);
        minSp = minSp(N/3+1:2*N/3);

        %generate IMF
        imf = x - (maxSp + minSp)/2;
        
%         cla
%         plot(x)
%         plot(maxSp)
%         plot(minSp)
%         plot((maxSp + minSp)/2)
%         plot(imf)
%         plot(x)
%         plot(x-imf)
%         title(['Mean Envelope: ' num2str(i)])
%         axis tight
        drawnow
%         saveas(h,['Res' num2str(i) '.png']);
%         close all

        %Calculate SD
        sd = sum(((x - imf)./x).^2)
% sd = sum((x-imf).^2)/sum(x.^2);
%         sd = sqrt(sum((x-imf).^2)/length(x))

        if isIMF(imf) && (sd < 0.3)
            break
        else
            x = imf;
        end
    end
toc;
end

outdat = imf;


% %Need to improve the cubic spline fitting. Make it more natural.
% % paddedX = [min(x); x; min(x)];
% paddedX = [fliplr(x')'; x;fliplr(x')'];
% 
% %generate extrema
% [maxima,maxPos] = findpeaks(paddedX);
% [minima,minPos] = findpeaks(-paddedX);
% % maxPos = maxPos - 1;
% % minPos = minPos - 1;
% minima = -minima;
% 
% if length(maxima) > 1
%     %fit cubic splines
%     N = length(paddedX);
%     maxSp = spline(maxPos,maxima,0:N-1)';
%     minSp = spline(minPos,minima,0:N-1)';
% 
%     maxSp = maxSp(N/3+1:2*N/3);
%     minSp = minSp(N/3+1:2*N/3);
% 
%     %generate IMF
%     imf = x - (maxSp + minSp)/2;
% %     imf = x - zengBound(x);
% 
%     %Calculate Standard Deviation
% %     sd = sum((x - imf).^2)/sum(x.^2); % Wu et al. Boundary Extension and Stop Criteria for Empirical Mode Decomposition
%     sd = sum(((imf - x)./x).^2);
%     fprintf([num2str(i) ' ' num2str(sd) '\n']);
% %     
% %     derp = sum((maxSp + minSp)/2);
% %     
% % %     Visualise
%     h = figure;
%     plot(x)
%     hold('on');
%     plot(maxSp)
%     plot(minSp)
%     plot((maxSp + minSp)/2)
%     title(['Mean Envelope: ' num2str(i)])
%     saveas(h,['Res' num2str(i) '.png']);
%     close all
% %     
%     
% 
%     if isIMF(imf) && (sd < 0.3) || i>370
%     %     disp('IMF is well behaved');
%         outdat = imf;
%     else
%         outdat = calculateIMF(imf,i+1);
%     end
% else
%     imf = x;
% end

% x_t = 0.5*t + sin(pi*t) + sin(2*pi*t) + sin(6*pi*t)
% x_t = cos(2*pi*80*t) + 0.8*sin(2*pi*50*t) + 0.6*sin(2*pi*25*t) + 0.4*cos(2*pi*10*t) + 0.3*cos(2*pi*3*t);