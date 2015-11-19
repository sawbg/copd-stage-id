function [ med avg ] = expmodel( patients, skip )
%EXPMODEL Summary of this function goes here
%   There's only about a 5s time savings by passing in already data

if nargin == 1
    skip = 1;
end

sfactor = 1000;
numpat = length(patients);
xdata = (0:(sfactor - 1))';
trinum = 1;
tol = 1500;
hold = cell(1,5);
stagecount = zeros(1,5);
avg = zeros(sfactor,5);
med = avg;
mkdata = @(mat) mat(1)*exp(mat(2)*xdata) + mat(3)*exp(mat(4)*xdata);

for k=1:skip:numpat
    stage = abs(patients(k).finalGold) + 1;
    stagecount(stage) = stagecount(stage) + 1;
    [res gof] = fit(xdata,scale(patients(k).trial(trinum).vol), ...
        fittype('exp2'));
    value = [res.a res.b res.c res.d gof.rsquare];
    
    if max(abs(value)) < tol && min(abs(value)) > 0
        hold{stage}(stagecount(stage),:) = value;
    end
end

for s=1:5
    avg(:,s) = mkdata(mean(hold{s}));
    med(:,s) = mkdata(median(hold{s}));
end
end

