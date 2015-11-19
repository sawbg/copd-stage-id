% 60% chance of correctly identifying stage
% 95% chance of being within one "stage point"


function [ med avg stagepts patstages] = ptmodel( patients, type, skip )
%TIMEVOLCORR Summary of this function goes here
%   Detailed explanation goes here

stagecount = zeros(1,5);
stagepts = cell(1,5);
med = zeros(1000,5);
avg = med;
patstages = 0;
data = 0;

if nargin < 2
    type = 'vol';
    skip = 1;
elseif nargin <3
    skip = 1;
end       

for p=1:skip:length(patients)
    stage = abs(patients(p).finalGold) + 1;
    stagecount(stage) = stagecount(stage) + 1;
    patstages = [patstages stage];
    
    switch type
        case 'vol'
            data = scale(patients(p).trial(1).vol);
        case 'flow'
            data = scale(patients(p).trial(1).flow);
        case 'dvol'
            data = scale(diff(patients(p).trial(1).vol));
    end
    
    switch stagecount(stage)
        case 1
            stagepts{stage} = data;
        otherwise
            stagepts{stage} = [stagepts{stage} data];
    end
end

patstages = patstages(2:length(patstages));

for stage=1:5
    med(:,stage) = median(stagepts{stage},2);
    avg(:,stage) = mean(stagepts{stage},2);
end
end