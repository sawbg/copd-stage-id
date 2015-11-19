function [ num ] = per( num, roundto )
%PER Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    roundto = 1;
end

num = round(num*100,roundto);

end

