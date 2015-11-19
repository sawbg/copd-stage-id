clc; close all; format longg; %clear all;

skip = 3;

disp('Calculating time remaining...');
exists = exist('patient','var');
if ~exists, load('patient_vol_flow.mat'), end;

data = cell(2,3,5);
stagecount = zeros(1,5);
patlen = numel(patient);

tol = 20000;
timestep = 10 * skip;
tic;

for k = 1:skip:patlen
    if mod(k,timestep) == 1 && k > 1
        time = toc*(patlen-k) / timestep;
        clc;
        disp(['Time Remaining: ' num2str(round(time/60)) ' minutes, '...
            num2str(mod(round(time),60)) ' seconds']);
        tic;
    end;
    
    pat = patient(k);
    stindex = abs(pat.finalGold) + 1;
    stagecount(stindex) = stagecount(stindex) + 1;
    sfactor = 1000;
    
    for s = [1 2]
        if(s == 1)
            flow = nopad(pat.trial(1).flow');
            vol = nopad(pat.trial(1).vol');
            df = diff(vol);
            
            dv = (0:(length(flow) - 1))';
            dt = (0:(length(vol) - 1))';
            dtf = (0:(length(df) - 1))';
        elseif s == 2          
            flow = scale(flow);
            vol = scale(vol);
            df = scale(df);
           
            dv = (0:(sfactor - 1))';
            dt = dv;
            dtf = dv;
        end
        
        %% Volume-Flow
        % Somewhat of a trend to the slop of the lines
%         [res gof] = fit(dv,flow,fittype('exp2'), fitoptions('Normal','on'));
%         value = [res.a res.b res.c res.d gof.rsquare max(df)];
%         
%         if max(value) < tol
%             data{s,1,stindex}(stagecount(stindex),:) = value;
%         end
        
        %% Time-Volume
        % smoothness inc. and sharp curves dec. with higher stages
        
        [res gof] = fit(dt,vol,fittype('exp2'));
        value = [res.a res.b res.c res.d gof.rsquare max(df)];
        
        if max(value) < tol
            data{s,2,stindex}(stagecount(stindex),:) = value;
        end
        
        %% Time-Flow
        % max(df) is much lower for advanced COPD
        % time to breath out doesn't correlate with stages
        % not sure if the "spike" shape is related to stage
        
%         [res gof] = fit(dtf,df,fittype('exp2'), fitoptions('Normal','on'));
%         value = [res.a res.b res.c res.d gof.rsquare max(df)];
%         
%         if max(value) < tol
%             data{s,3,stindex}(stagecount(stindex),:) = value;
%         end
    end
end

garbage = toc;
datasize = size(data);
paramlen = 6;%length(data{1}(1,:));
avg = zeros([datasize paramlen]);
med = avg;
dev = avg;


for s = 2
    for n = 2
        for k = 1:datasize(3)
            %   plot(data{k}(:,1),data{k}(:,2),'.','MarkerSize',10);
            
            for m = 1:paramlen
                val = data{s,n,k}(:,m);
                avg(s,n,k,m) = mean(val);
                med(s,n,k,m) = median(val);
                dev(s,n,k,m) = std(val);
            end
        end
    end
end

avg
med
dev

%save('current.mat');