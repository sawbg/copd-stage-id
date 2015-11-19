function [] = printstats(stats)
%PRINTSTATS Summary
%Details

disp('******* Per-stage analysis *******');
br();

for s=1:5
    switch s
        case 1 
            tit = 'Without COPD';
        case 2 
            tit = 'Stage I';
        case 3 
            tit = 'Stage II';
        case 4 
            tit = 'Stage III';
        case 5 
            tit = 'Stage IV';
    end
    
    if s>1, br(1), end
    disp(['*** ' tit ' ***']);
    
    scount = stats.CountStage(s);
    
    fprintf('Count: %d\n',scount);
    br();
    
    pstat('Correctly Diagnosed With Volume', ...
        stats.CountRight(s,1)/scount);
    pstat('Correctly Diagnosed With Flow', ...
        stats.CountRight(s,2)/scount);
    pstat('Correctly Diagnosed With dV/dt', ...
        stats.CountRight(s,3)/scount);
    br();
    
    pstat('Diagnosed within One Stage With Volume', ...
        stats.CountWinOne(s,1)/scount);
    pstat('Diagnosed within One Stage With Flow', ...
        stats.CountWinOne(s,2)/scount);
    pstat('Diagnosed within One Stage With dV/dt', ...
        stats.CountWinOne(s,3)/scount);
    br();
    
    pstat('Volume and Flow Correctly Diagnose', ...
        stats.DiagSameStageSame(s)/scount);
    pstat('Volume and Flow Diagnose Same Incorrect Stage', ...
        stats.DiagSameStageDiff(s)/scount);
    pstat('Exclusively Volume or Flow Correctly Diagnoses', ...
        stats.DiagDiffStageSame(s)/scount);
    pstat('Volume and Flow Diagnose Separate, Incorrect Stages', ...
        stats.DiagDiffStageDiff(s)/scount);
    
    br();
end

ctotal = sum(stats.CountStage);

disp('***** TOTAL *****');
fprintf('Count: %d\n',ctotal);
    br();
    
    pstat('Correctly Diagnosed With Volume', ...
        sum(stats.CountRight(:,1))/ctotal);
    pstat('Correctly Diagnosed With Flow', ...
        sum(stats.CountRight(:,2))/ctotal);
    pstat('Correctly Diagnosed With dV/dt', ...
        sum(stats.CountRight(:,3))/ctotal);
    br();
    
    pstat('Diagnosed within One Stage With Volume', ...
        sum(stats.CountWinOne(:,1))/ctotal);
    pstat('Diagnosed within One Stage With Flow', ...
        sum(stats.CountWinOne(:,2))/ctotal);
    pstat('Diagnosed within One Stage With dV/dt', ...
        sum(stats.CountWinOne(:,3))/ctotal);
    br();
    
    pstat('Volume and Flow Correctly Diagnose', ...
        sum(stats.DiagSameStageSame(:))/ctotal);
    pstat('Volume and Flow Diagnose Same Incorrect Stage', ...
        sum(stats.DiagSameStageDiff(:))/ctotal);
    pstat('Exclusively Volume or Flow Correctly Diagnoses', ...
        sum(stats.DiagDiffStageSame(:))/ctotal);
    pstat('Volume and Flow Diagnose Separate, Incorrect Stages', ...
        sum(stats.DiagDiffStageDiff(:))/ctotal);
    br();
end