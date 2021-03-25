positionNoZero = VTE_PositionXY;

% removing values of 0 (and 1)
positionNoZero(positionNoZero(:,1)== 0, :)= [];
positionNoZero(positionNoZero(:,1)== 1, :)= [];


figure()
 
%6492 values removed before VTE start 39124

plot(positionNoZero((VTE_TTTStart-6492):length(positionNoZero),1), ...
    positionNoZero((VTE_TTTStart-6492):length(positionNoZero),2))
 
xlim([0 700]) 
ylim([0 700])
