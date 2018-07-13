clc;

k = 4; SAS = sum([1:Asize-1]);
edges_collection = nchoosek([1: SAS], k);
freq_cell = cell(1,k);
for new_itr = 1:k
    freq_cell(1,new_itr) = {zeros(  ones(1,new_itr)*SAS  )};
end

for new_ci = 1:length(mycells)
    cell_buffer = cell2mat(mycells(new_ci))
    for ecoll_itr = 1:length(edges_collection)
        conditions_sum = 0;
        conditions = zeros(1,k);
        for new_itr = 1:k
            check = find( cell_buffer > (edges_collection(ecoll_itr,new_itr) - 1) & cell_buffer < (edges_collection(ecoll_itr, new_itr) + 1) );
            if(check > 0)
                conditions_sum = conditions_sum + 1;
                conditions(1, check) = check;
            end
        end

        for new_itr = k:-1:2
            if(conditions_sum == new_itr)
                cell_buffer;
                edges_collection(ecoll_itr,:);
                refined_conditions = find(conditions > 0);
                sub_interval = sort(cell_buffer([refined_conditions]));
                final_index = sub_interval(1,1);
                for another_itr = new_itr:-1:2
                    buffer_index = sub_interval(1, another_itr);
                    final_index = final_index + (buffer_index-1) * SAS.^(another_itr-1);
                end
                buffer_freq_cell = cell2mat(freq_cell(1,new_itr));
                buffer_freq_cell(final_index) = buffer_freq_cell(final_index) + 1;
                freq_cell(1,new_itr) = {buffer_freq_cell};
            end
        end
    end
end