%Ignoring the XY Detection Function I made and just plotting all variables
%at turn 1  (currently just head turn)

%INTERESTING: LOOK AT THE SPIKES. THERE SEEMS TO BE SOME TURN 1'S
%WITH LARGE SPIKES AND SOME WITH NONE. BUT GOING OFF THIS THERE
%SEEMS TO BE MORE VTE THAN NON VTE TURNS -- changing scope of what
%defines 'turn 1' changes this.

%THINK OF IT AS AVOIDING MOMENTS W/O HEAD TURN INSTEAD OF FINDING
%HEAD TURNS. EG. IT ONLY IS LOOKING LEFT WHEN MAKING ITS LEFT TURN.
%AVOID FINDING THOSE INSTEAD OF FINDING THE MOMENTS WHERE IT LOOKS
%LEFT AND RIGHT. (LOOK AT RANGE 68400:69000)

%CHECK FOR IF ALL THE VALUES ARE POSITIVE, OR ALL NEGATIVE (NO HEAD FLIP).
%FOR THE ONES THAT HAVE 1 SINGULAR HEAD FLIP STARTING FROM ONE GOING TO
%THE OTHER SIDE (EG 99000 TO 99600)MAYBE HAVE AN IF THAT LOOKS FOR THIS
%MOMENT OF INSUFFICIENT DATA AND THEN GOES BACK A FEW DATA POINTS TO SEE IF THERE WERE MORE
%HEAD FLIPS.

startviewing = 60000; 
windowsize = 600;
[m,n] = size(VTE_PositionXY);
figure()

vteVels = [];
nonVTEVels = [];

for i = 1:m
    
    tiledlayout(3,1)
    ax1 = nexttile;
    ax2 = nexttile;
    ax3 = nexttile;
    
%     plot(ax1,VTE_PositionXY(startviewing:startviewing+windowsize,1), ...
%         VTE_PositionXY(startviewing:startviewing+windowsize,2))
%     xlim(ax1,[0 700]) 
%     ylim(ax1,[0 700])
    
    turnIndices = [];
    
    for k = startviewing:startviewing+windowsize
        
                                       %%415 to 350 for k,2 <              
        if((VTE_PositionXY(k,1) > 310 &&  VTE_PositionXY(k,1) < 350) && ...
                (VTE_PositionXY(k,2) < 355 && VTE_PositionXY(k,2) > 250))
            
            turnIndices = [turnIndices,k];

            %display(k)  just save a k vector instead of doing all this.
            %will be faster
            
        end

    end
    
    
    %%Checking if there is no turn 1 in the range. if none just skip frame    
    if isempty(turnIndices)
        fprintf('No turn 1 detected in frame range. Skipping Frame Range: %d to %d\n\n', startviewing,(startviewing + windowsize));
        startviewing = startviewing + windowsize; 
        continue
    end
    
    %checking out avg velocities
%     avg = sum(VTE_LinearVelocity(turnIndices))/length(turnIndices);
%     display(avg)
    
    %%Skipping iterations w/ no change in head direction (and altering head
    %%dirr data)
    CornerShift_rad = 90*pi/180;
    headShiftedArr = VTE_HeadDirection(turnIndices(:));
    headShiftedArr = mod(headShiftedArr+pi-CornerShift_rad,2*pi)-pi;
    
    check = noHeadTurnCheck(headShiftedArr);
    if(~check)
        
        fprintf('No head flip detected. Skipping Frame Range: %d to %d\n\n', startviewing,(startviewing + windowsize));
        startviewing = startviewing + windowsize;
        %%Maybe ask whether to skip display or not
        continue
    end
    
    candidateHeadCheck(headShiftedArr)
    
    %original plot
    plot(ax1,VTE_PositionXY(startviewing:startviewing+windowsize,1), ...
        VTE_PositionXY(startviewing:startviewing+windowsize,2))
    xlim(ax1,[0 700]) 
    ylim(ax1,[0 700])
    
    hold (ax1,'on')
    %red highlight for turn 1
    plot(ax1,VTE_PositionXY(turnIndices(:),1), ...
       VTE_PositionXY(turnIndices(:),2),'.','Color','r')
    xlim(ax1,[0 700]) 
    ylim(ax1,[0 700])
    hold (ax1,'off')
    
    %plotting head direction
    %polarplot(VTE_HeadDirection(turnIndices(:)),1:length(turnIndices))
%     CornerShift_rad = 90*pi/180;
%     headShiftedArr = VTE_HeadDirection(turnIndices(:));
%     headShiftedArr = mod(headShiftedArr+pi-CornerShift_rad,2*pi)-pi;


%plotting head turn
%     plot(ax2,1:length(headShiftedArr),headShiftedArr)
%     ylim(ax2,[0 pi])
%     refline(ax2,[0 pi/2])

%plotting angular velocity
    plot(ax2,1:length(turnIndices),VTE_AngularVelocity(turnIndices))
    ylim(ax2, [-5 5])
    
    z=ones([1,length(headShiftedArr)]);
    polarplot(headShiftedArr,z)    %IDEA: maybe just check for percentage of portion in opp side?
                           %IDEA: maybe just do SSE w/ lin regres (mx+b) and itll be bad for the
                           %non straightish ones (VTE) naturally? dont have
                           %to do the avg stuff i was thinking about

    %plotting vel                       
%     plot(ax3,1:length(turnIndices),VTE_LinearVelocity(turnIndices))
%     ylim(ax3, [0 300])
                           
    fprintf('Frame Range: %d to %d\n\n', startviewing,(startviewing + windowsize));
    
    
    %Testing variability of avg velocities manually
%     prompt = "VTE? (Y/N/SKIP/DONE)";
%     response = input(prompt,'s');
%     if(response=="Y")
%         vteVels = [vteVels,avg];
%     elseif(response=="N")
%         nonVTEVels = [nonVTEVels,avg];
%     elseif(response=="DONE")
%         figure()
%         hold on
%         scatter(vteVels,ones(size(vteVels)))
%         scatter(nonVTEVels,zeros(size(nonVTEVels)))
%         hold off
%         break
%    end
    
    
    startviewing = startviewing + windowsize;    
    
    pause
    
end
