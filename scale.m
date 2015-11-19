function [ vector ] = scale( vector, smax, snum )
%SCALE Summary of this function goes here
%   Detailed explanation goes here

    if nargin == 1
        smax = 1000;
    end
    
if nargin < 3
    snum = 1000;
end

vector = nopad(vector);
len = length(vector);
xold = 0:(len - 1);
xnew = linspace(0,len,snum);
vector = (interp1(xold,vector,xnew,'linear','extrap')*(smax/max(vector)))';
end

