function [VTE_Start,VTE_End] = XY_VTE_Detection_F(rangeA,rangeB,positionNoZero)

    continueLeft = false;
    continueRight = false;
    widthCounter = 0;
    rightCounter = 0;
    rightDistCounter = 0;
    leftCounter = 0;
    leftDistCounter = 0;
    VTE_Start = [];
    VTE_End = [];

    for i = rangeA : rangeB

        next = positionNoZero(i+1,1);
        current = positionNoZero(i,1);

        %%Skip if no change in x movements
        if next == current
            continue
        end        

        %%Determine change in direction
        if next > current
            continueRight = true;
            rightCounter = rightCounter + 1;
            rightDistCounter =  rightDistCounter + abs(next-current);

            if continueLeft == true
                widthCounter = 0;
            end

            continueLeft = false;

        elseif next < current
            continueLeft = true;
            leftCounter = leftCounter + 1;
            leftDistCounter = leftDistCounter + abs(next-current);

            if continueRight == true
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
                fprintf('FOUND at %d , %d\n',positionNoZero(i,1),positionNoZero(i,2))
                VTE_Start = [VTE_Start, i-50];
                VTE_End = [VTE_End,i];

            end

            widthCounter = 0;
            continueRight = false;
            continueLeft = false;
            rightCounter = 0;
            leftCounter = 0;

            %mark this spot (maybe plot this portion a diff color?)
            %and also save value of where this happened
        end

    end

end

