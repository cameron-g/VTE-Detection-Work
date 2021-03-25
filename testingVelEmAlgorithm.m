%turnIndicesMatrix = [];

turnAvgVels = returnAvgVelsTurns(VTE_PositionXY,VTE_LinearVelocity);

%turnAvgVels

x = ones(size(turnAvgVels));
scatter(turnAvgVels,x)


