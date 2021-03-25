%%FUNCTION PURPOSE:

%%Check if there is a head turn. Will return true if there is none given
%%the interval. The purpose of this function is to omit the turns that do
%%not involve any sort of head flipping behavior of the mouse looking left
%%or right. This function looks for the moments in the data where the
%%mouse is lookin in the  direction it will turn to for a small duration of
%%its approach to the turn.

function [headTurnCheck] = noHeadTurnCheck(headDirArr)
    
    headTurnCheck = false;
    
    initialVal = headDirArr(1);
    
    if(initialVal <= pi/2)
        for i = 1:length(headDirArr)
            if( headDirArr(i) > pi/2 )
                headTurnCheck = true;
                return
            end
        end
    
    elseif(initialVal >= pi/2)
        for i = 1:length(headDirArr)
            if( headDirArr(i) < pi/2 )
                headTurnCheck = true;
                return
            end
        end
    end
                    

end

