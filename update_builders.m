%update_builders

function varargout = update_builders(crint_cells, tiers, index, builders)
Cees = crint_cells{1,1}{index,5}

for citr = 1:length(Cees)
    %base_condition
    if(length(Cees) == 0)
        break;
    end
    
    %update_Bees wrt tiers
    if(tiers)
        builders = [crint_cells{1,1}{fcc_itr2,5}];
    end
    
    %recurse
    update_builders(crint_cells, tiers, index, mfcc, builders);
end

varargout{1} = crint_cells;
varargout{2} = builders;