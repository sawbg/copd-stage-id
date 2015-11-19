datatype = 3;
sc = 1;
numpat = size(data{2,datatype,sc});
numpat = numpat(1);
params = med(2,datatype,sc,:);
points = 0:(sfactor-1);
model = params(1)*exp(params(2)*points) + params(3)*exp(params(4)*points);
patrsq = zeros(numpat,1);

for pat = 1:numpat
    patpar = data{2,datatype,sc}(pat,:);
    patmodel = patpar(1)*exp(patpar(2)*points) ...
        + patpar(3)*exp(patpar(4)*points);
    rsq(pat) = corr(patmodel',model')^2;
end

mean(rsq)
median(rsq)
std(rsq)
hist(rsq,20);
title(length(rsq));