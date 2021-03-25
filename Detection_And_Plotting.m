positionNoZero = VTE_PositionXY;
positionNoZero(positionNoZero(:,1)== 0, :)= [];
positionNoZero(positionNoZero(:,1)== 1, :)= [];

startviewing = 63600;  %60000 previously
windowsize = 600;
[m,n] = size(VTE_PositionXY);
figure()

for i = 1:m
    
%     plot(VTE_PositionXY(startviewing:startviewing+windowsize,1), ...
%         VTE_PositionXY(startviewing:startviewing+windowsize,2))
    
%     subplot(2,2,[1,2])
%     plot(positionNoZero(startviewing:startviewing+windowsize,1), ...
%         positionNoZero(startviewing:startviewing+windowsize,2))
%     xlim([0 700])
%     ylim([0 700])
    
%     subplot(2,2,3)
%     plot((startviewing:startviewing+windowsize),...
%         VTE_LinearVelocity(startviewing:startviewing+windowsize,1))
    
    fprintf('Frame Range: %d to %d\n', startviewing,(startviewing + windowsize));
    
    [VTE_Start,VTE_End] = XY_VTE_Detection_F(startviewing,startviewing+windowsize,positionNoZero);
    
    %%Plot Path Segment
    subplot(length(VTE_Start)+1,1,1)
    plot(positionNoZero(startviewing:startviewing+windowsize,1), ...
        positionNoZero(startviewing:startviewing+windowsize,2))
    xlim([0 700]) 
    ylim([0 700])
    
    %%Plot VTE Moments as found by XY_VTE_Detection_F as red
    hold on
    for j = 1:length(VTE_Start)
        subplot(length(VTE_Start)+1,1,1)
        plot(positionNoZero(VTE_Start(j):VTE_End(j),1),...
            positionNoZero(VTE_Start(j):VTE_End(j),2),'Color','r')
        
        xlim([0 700]) 
        ylim([0 700])
        
    end
    hold off
    
    for k = 1:length(VTE_Start)
        xRange = VTE_Start(k) : 1 : VTE_End(k);
        
        subplot(length(VTE_Start)+1,1,k+1)
        plot( xRange,...
            VTE_LinearVelocity(VTE_Start(k):VTE_End(k),1) )
        
        %xlim([0 700]) 
        %ylim([0 700])        
    end
    
    startviewing = startviewing + windowsize;    
    
    pause
    
end