%%current problem: 8/28 : after detecting a turn and continuing in the same
%%direction, the function pings that there is a VTE. Need to add a feature
%%that does not increment the widthCounter unless there is a change in the
%%direction from the previous ping.------FIXED

% new potential idea 8/30 : for positional vte's, maybe specify a certain
% change in direction difference to look for. for example: dont mark
% moving left 1 pixel and then right 50. have a limit of at least 10 
% pixels in one direction before turning.

% Add in lower bound to begin the XY_VTE Detection algorithm