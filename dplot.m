function [ handle ] = dplot( mat )
%DPLOT Summary of this function goes here
%   Detailed explanation goes here

figure;
pts = 0:(length(mat)-1);
handle = plot(pts,mat(:,1),'-',pts,mat(:,2),':',pts,mat(:,3),'--', ...
    pts,mat(:,4),'-.',pts,mat(:,5),'-');
stdlab();
stdleg();
end

