%clc;

% Stage chances: 1: 54.6; 2: 44.2; 3: 50.0; 4: 44.9; 5: 90.3
% Stage +/- 1 chance: 93.4

datasize = size(data);
sc = 2;
source = 2;

params = squeeze(avg(sc,source,:,:));
pts = (0:999)';
diagcount = zeros(1,5);
diagcount2 = diagcount;
count = zeros(1,5);
prop = 0;
%model = zeros(datasize(3),sfactor);

for stage=1:datasize(3)
    for pt=1:length(pts)
        model(pt,stage) = params(stage,1)*exp(params(stage,2)*pt) ...
            + params(stage,3)*exp(params(stage,4)*pt);
    end
end

for stage=1:datasize(3)
    for pat=1:length(data{sc,source,stage})
        patparm = data{sc,source,stage}(pat,1:4);
        
        for pt=1:length(pts)
           patmodel(pt) = patparm(1)*exp(patparm(2)*pt) ...
            + patparm(3)*exp(patparm(4)*pt); 
        end
        
        for tstage=1:datasize(3)
            rsq(tstage) = corr(model(:,tstage),patmodel')^2;
        end
        
        count(stage) = count(stage) + 1;
        
        [~,maxind] = max(rsq);
        
        if maxind == stage
            diagcount2(stage) = diagcount2(stage) + 1;
             prop = prop + 1; 
        end
        
        if maxind == (stage + 1) || maxind == (stage - 1)
           prop = prop + 1; 
        end
        
        if rsq > 0.8
            diagcount(stage) = diagcount(stage) + 1;
        end
    end
end

%diagcount./count
diagcount2./count
round(prop/(length(patient)/skip)*100,1)