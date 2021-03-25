% z=0:1:13;             
% y3=gaussmf(z,[1 6]); %%1 is the broadness of the peak, 6 is the peak point
% y3=y3/sum(y3);
% vels_filt=filtfilt(y3,1,vels);


tiledlayout(4,1)
ax1 = nexttile;
ax2 = nexttile;
ax3 = nexttile;
ax4 = nexttile;

plot(ax1,VTE_PositionXY(78000:78250,1),VTE_PositionXY(78000:78250,2))

hold(ax1,'on')
plot(ax1,VTE_PositionXY(78147:78178,1),VTE_PositionXY(78147:78178,2),'color','r')
hold(ax1,'off')

plot(ax2,1:251,VTE_LinearVelocity(78000:78250))

hold(ax2,'on')
plot(ax2,150:181,VTE_LinearVelocity(78149:78180))
hold(ax2,'off')

z=0:1:13;             
y3=gaussmf(z,[1 6]); %%1 is the broadness of the peak, 6 is the peak point
y3=y3/sum(y3);
vels_filt=filtfilt(y3,1,VTE_LinearVelocity(78000:78250));


plot(ax3,1:251,vels_filt)

plot(ax4,1:251,smoothdata(VTE_LinearVelocity(78000:78250)))