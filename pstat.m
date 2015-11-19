function [] = pstat( name, val )
%PSTAT Summary of this function goes here
%   Detailed explanation goes here

fprintf('%s: %s%%\n',name,num2str(per(val)));

end

