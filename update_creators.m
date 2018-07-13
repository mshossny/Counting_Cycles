%update_creators

function varargout = update_creators(crint_cells, cell_index, tier_index)

Cees = crint_cells{1,cell_index(1)}{cell_index(2),5};
if(length(Cees) > 0)
    Cees = Cees(1);
end
cell_index(1);
Cees;
next_Cees = crint_cells{1,cell_index(1)}{Cees,6}; % previous tier creators
next_Cees = sort(next_Cees);

creating_buffer = [];
last_j = tier_index;
for i = 1:length(next_Cees)
    for j = last_j : cell_index(2)
        bcr = crint_cells{1,cell_index(1)}{j,5};
        if(next_Cees(i) == bcr(1))
            creating_buffer = [creating_buffer j];
            last_j = j;
            break;
        end
    end
end

creating_buffer = [creating_buffer Cees];
% crint_cells{1, cell_index(1)}{cell_index(2),6} = creating_buffer;

varargout{1} = creating_buffer;