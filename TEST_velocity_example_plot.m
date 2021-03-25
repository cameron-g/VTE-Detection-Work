%Frame Range: 78000 to 78600

tiledlayout(4,1)
ax1=nexttile;
ax2 = nexttile;
ax3 = nexttile;
ax4 = nexttile;

plot(ax2,78100:78250,VTE_PositionXY(78100:78250,1))
plot(ax1,VTE_PositionXY(78100:78250,1),VTE_PositionXY(78100:78250,2))
plot(ax3,78100:78250,VTE_LinearVelocity(78100:78250))
plot(ax4,78100:78250,VTE_HeadDirection(78100:78250))
ylim([-4 4])




