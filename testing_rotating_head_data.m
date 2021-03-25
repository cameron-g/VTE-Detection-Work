% Frame Range: 62453 to 62521

CornerShift_rad = 90*pi/180; %either 45 or 135
% ModelStruct.HeadingDirection(iNeuron,:) = ...
%     mod(ModelStruct.HeadingDirection(iNeuron,:)+pi-CornerShift_rad,2*pi)-pi;
% ModelStruct.Axis(iNeuron,:) = mod(hd+pi,pi);

% figure()
% polarplot(VTE_HeadDirection(62453:62521),1:69)


tmp = VTE_HeadDirection(62453:62521);

tmp = mod(tmp+pi-CornerShift_rad,2*pi)-pi;

z=ones([1,length(tmp)]);

figure()
polarplot(tmp,z)

% tiledlayout(1,1)
% ax1 = nexttile;
% 
% plot(ax1,1:69,tmp)
% refline(ax1,[0 pi/2])

