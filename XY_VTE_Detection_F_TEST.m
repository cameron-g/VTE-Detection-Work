%%changing the scope to only the first turn

function [VTE_Start,VTE_End] = XY_VTE_Detection_F_TEST(rangeA,rangeB,positionNoZero)

    testBool = false;

    continueLeft = false;
    continueRight = false;
    widthCounter = 0;
    rightCounter = 0;
    
    rightDistCounter = 0;
    leftCounter = 0;
    leftDistCounter = 0;
    VTE_Start = [];
    VTE_End = [];
    
    prvWidth = 5;

    for i = rangeA : 2 : rangeB
        
        if(positionNoZero(i,1)<228 ||  positionNoZero(i,1) > 428)
            widthCounter = 0;
            continueRight = false;
            continueLeft = false;   
            rightCounter = 0;
            leftCounter = 0;
            continue
        end      
        if(positionNoZero(i,2) > 334 || positionNoZero(i,2) < 250)
            widthCounter = 0;
            continueRight = false;
            continueLeft = false;   
            rightCounter = 0;
            leftCounter = 0;
            continue
        end

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

            if continueLeft == true && prvWidth ~=1
                prvWidth = widthCounter;
                widthCounter = 0;
            end

            continueLeft = false;

        elseif next < current
            continueLeft = true;
            leftCounter = leftCounter + 1;
            leftDistCounter = leftDistCounter + abs(next-current);

            if continueRight == true && prvWidth ~=1
                prvWidth = widthCounter;
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
%             if((positionNoZero(i,1)<290 ||  positionNoZero(i,1) > 370) || (positionNoZero(i,2) > 351 || positionNoZero(i,2) < 260))
%                 widthCounter = 0;
%                 continueRight = false;
%                 continueLeft = false;   
%                 rightCounter = 0;
%                 leftCounter = 0;
%                 continue
%             end
            if (rightCounter ~= 0 && leftCounter ~= 0 && prvWidth > 5) 
                fprintf('FOUND at %d , %d\n',positionNoZero(i,1),positionNoZero(i,2))
                VTE_Start = [VTE_Start, i-75];
                VTE_End = [VTE_End,i];
                testBool = true;

            end

            widthCounter = 0;
            prvWidth = 0;
            continueRight = false;
            continueLeft = false;
            rightCounter = 0;
            leftCounter = 0;

            %mark this spot (maybe plot this portion a diff color?)
            %and also save value of where this happened
        end

    end
    
    
    %%Testing pretty sub optimal solution to non detection problem
    
    if testBool == false
        continueLeft = false;
        continueRight = false;
        widthCounter = 0;
        rightCounter = 0;

        rightDistCounter = 0;
        leftCounter = 0;
        leftDistCounter = 0;
        VTE_Start = [];
        VTE_End = [];

        prvWidth = 5;

        for i = rangeA : 1 : rangeB

            if(positionNoZero(i,1)<228 ||  positionNoZero(i,1) > 428)
                widthCounter = 0;
                continueRight = false;
                continueLeft = false;   
                rightCounter = 0;
                leftCounter = 0;
                continue
            end      
            if(positionNoZero(i,2) > 334 || positionNoZero(i,2) < 250)
                widthCounter = 0;
                continueRight = false;
                continueLeft = false;   
                rightCounter = 0;
                leftCounter = 0;
                continue
            end

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

                if continueLeft == true && prvWidth ~=1
                    prvWidth = widthCounter;
                    widthCounter = 0;
                end

                continueLeft = false;

            elseif next < current
                continueLeft = true;
                leftCounter = leftCounter + 1;
                leftDistCounter = leftDistCounter + abs(next-current);

                if continueRight == true && prvWidth ~=1
                    prvWidth = widthCounter;
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

                if (rightCounter ~= 0 && leftCounter ~= 0 && prvWidth > 5) 
                    fprintf('FOUND at %d , %d\n',positionNoZero(i,1),positionNoZero(i,2))
                    VTE_Start = [VTE_Start, i-75];
                    VTE_End = [VTE_End,i];
                    testBool = true;

                end

                widthCounter = 0;
                prvWidth = 0;
                continueRight = false;
                continueLeft = false;
                rightCounter = 0;
                leftCounter = 0;

                %mark this spot (maybe plot this portion a diff color?)
                %and also save value of where this happened
            end

        end

    end

end

