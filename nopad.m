function [ vector ] = nopad( vector )
%NOPAD Summary of this function goes here
%   Detailed explanation goes here

vector = vector(find(vector,1,'first'):find(vector,1,'last'));

end

