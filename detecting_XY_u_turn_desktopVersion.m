%VTE noticed between 71400 and 72000

%if x swaps direction and continue for more than ~20 pixels
%its potentially a VTE (solely based of XY data)??? CODE THIS

%change = false;
continueLeft = false;
continueRight = false;
widthCounter = 0; %if goes beyond ~20 pixels we know a turn has been made
rightCounter = 0;
leftCounter = 0;

for i = 71400 : 71700
    
    next = VTE_PositionXY(i+1,1);
    current = VTE_PositionXY(i,1);
    
    
    %%Skip if no change in x movements
    if next == current
        continue
    end        
    
    %%Determine change in direction
    if next > current
        continueRight = true;
        rightCounter = rightCounter + 1;
        
        if continueLeft == true
            %change = true;
            widthCounter = 0;
        end
        
        continueLeft = false;
        
    elseif next < current
        continueLeft = true;
        leftCounter = leftCounter + 1;
        
        if continueRight == true
            %change = true;
            widthCounter = 0;
        end
        
        continueRight = false;
    end
    
    %Increment counter when continuing the same direction
    %***change to jsut always increaseing widthCounter by 1 here****
    %***DONT INC BY 1 INC BY THE X VALUE xyPosition(i,1)***
    if continueRight == true
        widthCounter = widthCounter + abs(next-current);
    elseif continueLeft == true
        widthCounter = widthCounter + abs(next-current);
    end
    
    if (widthCounter >= 50)
        
        %if there has never been a change in direction (this accounts for
        %the only going straight issue) dont count this as a vte and reset
        if (rightCounter ~= 0 && leftCounter ~= 0)
            fprintf('FOUND at %d , %d\n',VTE_PositionXY(i,1),VTE_PositionXY(i,2))
        end
        
        widthCounter = 0;
        continueRight = false;
        continueLeft = false;
        rightCounter = 0;
        leftCounter = 0;
        
        %change contR and contL depending on prev trajectory
        
        
        %mark this spot (maybe plot this portion a diff color?)
        %and also save value of where this happened
    end
    
            
end
