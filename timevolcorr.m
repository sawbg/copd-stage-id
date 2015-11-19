% 60% chance of correctly identifying stage
% 95% chance of being within one "stage point"


function [ prop ] = timevolcorr( patient )
%TIMEVOLCORR Summary of this function goes here
%   Detailed explanation goes here

stagecount = zeros(1,5);
stagevals = zeros(1000,1);
med = zeros(1000,5);
count = 0;

for m=1:5
    for k=1:length(patient)
        if abs(patient(k).finalGold) + 1 == m
            stagecount(m) = stagecount(m) + 1;
            
            if stagecount(m) == 2
                stagevals = stagevals(:,2);
            else
                stagevals = [stagevals scale(patient(k).trial(1).vol)];
            end
        end
    end
    
    med(:,m) = mean(stagevals,2);
    
end

for p=1:length(patient)
    stage = abs(patient(p).finalGold) + 1;
    [~,index] = max(corr(scale(patient(p).trial(1).vol'),med));
    
    if index == stage || index == stage + 1 || index == stage - 1
        count = count + 1;
    end
end

prop = round(100*count/length(patient),1);
end