%78000 to 78600
 
tiledlayout(2,1)
ax1 = nexttile;
ax2 = nexttile;

range1 = 78130;
range2 = 78250;

flip1=find(VTE_PositionXY==342,292);  %78150:78153
flip2 = find(VTE_PositionXY == 305,284); %78176:78178
flip3 = find(VTE_HeadDirection == -104.9)

plot(ax1,VTE_PositionXY(range1:range2,1),VTE_PositionXY(range1:range2,2))

hold(ax1,'on')
plot(ax1,VTE_PositionXY(78150:78153,1),VTE_PositionXY(78150:78153,2),'color','r')
plot(ax1,VTE_PositionXY(78174:78180,1),VTE_PositionXY(78174:78180,2),'color','r')
hold(ax1,'off')

polarplot(VTE_HeadDirection(range1:range2),1:(range2-range1 + 1 ))

hold on
polarplot(VTE_HeadDirection(78150:78153),20:23,'color','r')
polarplot(VTE_HeadDirection(78174:78180),44:50,'color','r')
hold off

% tmp1 = 61250;
% tmp2 = 61300;
% 
% hold (ax1,'on')
% plot(ax1,VTE_PositionXY(tmp1:tmp2,1),VTE_PositionXY(tmp1:tmp2,2),'color','r')
% hold (ax1,'off')
% hold on
% polarplot(VTE_HeadDirection(tmp1:tmp2),50:100,'color','r')
% hold off



