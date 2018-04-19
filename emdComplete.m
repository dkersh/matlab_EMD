function outdat = emdComplete(x,N)
origSig = x;

x = x(:);

if nargin == 1
    N = -1;
end

outdat = [];
i = 0;

t=0:1/(length(x)-1):1;

stopCriterion = 0;

while ~isMonotonic(x) && (i ~= N+1)
    i = i+1;
    fprintf(['Calculating IMF' num2str(i) ' Iteration ']);
    x1 = calculateIMFnonrecursive(x);
    
    outdat(i,:) = x1;
    x = x - x1;
    fprintf('\n');
end

figure
for i=1:size(outdat,1)
    if i == 1
        subplot(size(outdat,1)+1,1,i)
        plot(t,origSig)
        ylabel('Original Signal')
    else
        subplot(size(outdat,1)+1,1,i)
        plot(t,outdat(i-1,:))
        ylabel(['IMF ' num2str(i-1)]);
        %     ylim([-0.02 0.02]);
    end
end