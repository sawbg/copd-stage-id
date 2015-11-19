function [] = stdleg( location )
%STDLEG Summary of this function goes here
%   Detailed explanation goes here

if nargin < 1
    location = 'best';
end

legend('No COPD','Stage I','Stage II','Stage III','Stage IV',...
        'Location', location);

end

