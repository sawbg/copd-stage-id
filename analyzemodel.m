function [ stats ] = analyzemodel(patient, volmed, flowmed, dvolmed )
%ANALYZEMODEL Summary of this function goes here
%   Detailed explanation goes here

lenpat = length(patient);
stages = zeros(1,lenpat);  % finalGold of each patient
countstage = zeros(1,5);  % number of patients in each stage
patdata = cell(lenpat,1);  % patient's r-squared values by stage and data
progress = 0;  % percentage of completion displayed

% stats variables
DiagStage = zeros(lenpat,3);  % diagnoses by data (rtl): vol, flow, dvol
CountRight = zeros(5,3);  % correct dianoses per dataset per stage
CountWinOne = CountRight;  % correct w/in 1 stage point per data per stage
DiagSameStageSame = countstage;
DiagSameStageDiff = countstage;
DiagDiffStageSame = countstage;
DiagDiffStageDiff = countstage;
DiagSameStageSameNextMaxDiff = [];
DiagSameStageDiffNextMaxDiff = [];
DiagSameStageDiffPointDiff = [];
DiagDiffStageSamePointDiff = [];
DiagDiffStageDiffPointDiff = [];


for p=1:lenpat
    if floor(p/lenpat*100) > progress
        progress = progress + 1;
        clc;
        fprintf('%d%%',progress);
    end
    
    trial = patient(p).trial(1);
    stage = abs(patient(p).finalGold) + 1;
    stages(p) = stage;
    countstage(stage) = countstage(stage) + 1;
    rvals = zeros(5,3);
    
    for k=1:5
        rvals(k,1) = corr(volmed(:,k),scale(trial.vol));
        rvals(k,2) = corr(flowmed(:,k),scale(trial.flow));
        rvals(k,3) = corr(dvolmed(:,k),scale(diff(trial.vol)));
    end
    
    patdata{p} = rvals;
    [~,diagvol] = max(rvals(:,1));
    [~,diagflow] = max(rvals(:,2));
    [~,diagdvol] = max(rvals(:,3));
    DiagStage(p,:) = [diagvol diagflow diagdvol];
    PointDiff = stage*ones(1,3) - DiagStage(p,:);
    
    for d=1:length(DiagStage(p,:))
        if stage == DiagStage(p,d)
            CountRight(stage,d) = CountRight(stage,d) + 1;
            CountWinOne(stage,d) = CountWinOne(stage,d) + 1;
        elseif stage == DiagStage(p,d) + 1 ...
                || stage == DiagStage(p,d) - 1
            CountWinOne(stage,d) = CountWinOne(stage,d) + 1;
        end
    end
    
    if diagvol == diagflow
        if diagvol == stage
            DiagSameStageSame(stage) = DiagSameStageSame(stage) + 1;
            test = rvals(:,1);
            test(diagvol) = -Inf;
            DiagSameStageSameNextMaxDiff = ...
                [DiagSameStageSameNextMaxDiff; ...
                abs(rvals(stage,1)-max(test))];
        else
            DiagSameStageDiff(stage) = DiagSameStageDiff(stage) + 1;
            DiagSameStageDiffNextMaxDiff = ...
                [DiagSameStageDiffNextMaxDiff; ...
                abs(rvals(stage,1)-rvals(diagvol,1))];
            DiagSameStageDiffPointDiff = [DiagSameStageDiffPointDiff; ...
                PointDiff];
        end
    elseif diagvol == stage || diagflow == stage
        DiagDiffStageSame(stage) = DiagDiffStageSame(stage) + 1;
        DiagDiffStageSamePointDiff = [DiagDiffStageSamePointDiff; ...
            PointDiff];
    else
        DiagDiffStageDiff(stage) = DiagDiffStageDiff(stage) + 1;
        DiagDiffStageDiffPointDiff = [DiagDiffStageDiffPointDiff; ...
            PointDiff];
    end
end



stats = struct('CountStage',countstage, ...
    'DiagStage',DiagStage, ...
    'CountRight',CountRight, ...
    'CountWinOne',CountWinOne, ...
    'DiagSameStageSame',DiagSameStageSame, ...
    'DiagSameStageDiff',DiagSameStageDiff, ...
    'DiagDiffStageSame',DiagDiffStageSame, ...
    'DiagDiffStageDiff',DiagDiffStageDiff, ...
    'DiagSameStageSameNextMaxDiff',DiagSameStageSameNextMaxDiff, ...
    'DiagSameStageDiffNextMaxDiff',DiagSameStageDiffNextMaxDiff, ...
    'DiagSameStageDiffPointDiff', DiagSameStageDiff ...
    );
end