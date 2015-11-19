clc; close all; format longg; %clear all;


stagecount = zeros(1,5);
paramstagevals = cell(1,5);
medparam = zeros(5,3);
avgparam = medparam;
skip = 1;
tol = 5000;
patients = patient;
stagevals = cell(1,5);
med = zeros(1000,5);
avg = med;

for p=1:skip:length(patients)
    clc; fprintf('%d%%',floor(p/length(patients)*100));
    stage = abs(patients(p).finalGold) + 1;
    stagecount(stage) = stagecount(stage) + 1;
    flow = patients(p).trial(1).flow';
    [~,index] = max(flow);
    flow = scale(flow(index:length(flow)));
    pts = (0:(length(flow)-1))';
    
    [res gof] = fit(pts,flow,fittype('exp1'));
    value = [res.a res.b gof.rsquare];
    
    if max(value) > tol
        stagecount(stage) = stagecount(stage) - 1;
        continue;
    end
    
    switch stagecount(stage)
        case 1
            paramstagevals{stage} = value;
            stagevals{stage} = flow;
        otherwise
            paramstagevals{stage} = [paramstagevals{stage}; value];
            stagevals{stage} = [stagevals{stage} flow];
    end
end

for stage=1:5
    medparam(stage,:) = median(paramstagevals{stage});
    avgparam(stage,:) = mean(paramstagevals{stage});
    med(:,stage) = median(stagevals{stage},2);
    avg(:,stage) = mean(stagevals{stage},2);
end