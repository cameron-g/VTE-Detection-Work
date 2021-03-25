function [avgVelsTurns] = returnAvgVelsTurns(VTE_PositionXY,VTE_LinearVelocity)
%RETURNTURNONEAVGVELS: Returns a matrix of indices of each iteration of
%turn. Each iteration is stored as rows and the indices of each point in
%the turn as columns.

%Forget doing this by indices. it wont work due to different turn 1 sizes.
%just calculate the average velocities here using the code below and just
%fill up a (m x 1) matrix of the avg velocities

    sum = 0;
    
    amt = 0;
    
    avgVelsTurns = [];
    
    whileEntered = false;

    i = 60000;
    while i <= length(VTE_PositionXY)
    %for i = 60000:length(VTE_PositionXY)
        
        if((VTE_PositionXY(i,1) > 310 &&  VTE_PositionXY(i,1) < 350) && ...
                (VTE_PositionXY(i,2) < 355 && VTE_PositionXY(i,2) > 250))
            
            tmp = i;
            
            while((VTE_PositionXY(tmp,1) > 310 &&  VTE_PositionXY(tmp,1) < 350) && ...
                (VTE_PositionXY(tmp,2) < 355 && VTE_PositionXY(tmp,2) > 250))
            
            
                sum = sum + VTE_LinearVelocity(tmp);
                
                amt = amt + 1;
                
                tmp = tmp + 1;
                
                whileEntered = true;
            
            end
            
        end
        
        if whileEntered == true
            i = tmp;
            
            avg = sum/amt;
            
            avgVelsTurns = [avgVelsTurns, avg];
            
            sum=0;
            amt=0;
            whileEntered = false;
            
            continue
        end
        
        i = i + 1;
    
    end

end

