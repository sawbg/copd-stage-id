function [] = psave( name )
%PSAVE Summary of this function goes here
%   Detailed explanation goes here

saveas(gcf,['plots\' name '.bmp']);
close;

end

