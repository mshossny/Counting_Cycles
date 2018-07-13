clc
tsix = nchoosek([1:6], 5);
tsix = tsix(2:end, :)

tfivesss = [];
tfoursss = [];

for itrsix = 1:length(tsix)
    
    tfive = nchoosek(tsix(itrsix,:), 4);    %tsix contents has 5 columns
    tfive = tfive(2:end, :);
    
    tfivesss = vertcat( tfivesss, tfive)
        
end

for itrfive = 1:length(tfivesss)
    tfour = nchoosek(tfivesss(itrfive,:), 3);   %tfive contents has 4 columns
    tfour = tfour(2:end, :);
    tfoursss = vertcat(tfoursss, tfour);
end

tfoursss

decimal_tfoursss = 100.* tfoursss(:,1) + 10.* tfoursss(:,2) + tfoursss(:,3);