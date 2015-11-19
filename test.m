tic

temp = zeros(1000,numel(patient));

for k = 1:numel(patient)
   temp(:,k) = scale(patient(k).trial(1).vol);
end

toc;