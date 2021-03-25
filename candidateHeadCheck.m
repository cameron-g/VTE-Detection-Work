%function [cadidateHeadTurnCheck] = candidateHeadCheck(headDirArr)
function candidateHeadCheck(headDirArr)
%Return true or false if a candidate head motion is found. This motion is
%defined as looking x amount of degrees to one side and then turning to the
%other. At first ask the user to define whether it looks like a candidate
%moment or not, then at the end of the run show ranges and averages of candidate
%vs candidate moments. Potentially use this info to begin an EM algorithm
%to estimate for future data sets. But for now this will be manual.

cadidateHeadTurnCheck = false;

centerInterceptIndexArr = [];

shiftArr = [];

center = pi/2;

for i = 1:length(headDirArr)-1
    
    %%potential problem w/ rounding for values == pi/2
    if( (headDirArr(i) == center) ||...
            (headDirArr(i)<center && headDirArr(i+1)>center) ||...
            (headDirArr(i)>center && headDirArr(i+1)<center) )
        
        centerInterceptIndexArr = [centerInterceptIndexArr, i];
        
    end
    
end


for j = 1:length(centerInterceptIndexArr)-1
    
    maxShift = abs(center - headDirArr(centerInterceptIndexArr(j)));
    
    %save index for inflection point
    for k = centerInterceptIndexArr(j):centerInterceptIndexArr(j+1)-1

        nextHeadDirVal = abs(center - headDirArr(k+1));
        
        if(nextHeadDirVal > maxShift)
        
            maxShift = nextHeadDirVal;
        end
    end
    
    shiftArr = [shiftArr, maxShift];
       
end

shiftArrKeep = [];
centerInterceptIndexArrKeep = [];

%removing 0's
for h = 1:length(shiftArr)
    if shiftArr(h)~=0
        shiftArrKeep = [shiftArrKeep, h];
        centerInterceptIndexArrKeep = [centerInterceptIndexArrKeep, h];
        centerInterceptIndexArrKeep = [centerInterceptIndexArrKeep, h+1];
    end
end
     

display(shiftArr(shiftArrKeep))
display(centerInterceptIndexArr(centerInterceptIndexArrKeep))

end