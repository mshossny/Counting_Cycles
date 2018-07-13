clc;

l = 2; k = 5; SAS = sum([1:Asize-1]);
% edges_collection = nchoosek([1: SAS], k);
freq_cell = cell(1,k);
for new_itr = 1:k
    freq_cell(1,new_itr) = {zeros(  ones(1,new_itr)*SAS  )};
end
all_sum = 0;
for new_ci = 1:length(mycells)
    new_ci
    cell_buffer = cell2mat(mycells(new_ci))
    cell_buffer_sum = 0;
    for choose_itr = 2 : k %%% numerical assignment %%%
        choose_itr;
        edges_collection = sort(nchoosek(cell_buffer, choose_itr)')';
        cell_buffer_sum = cell_buffer_sum + length(edges_collection);
        sec = size(edges_collection); sec = sec(1,1);
        
        for ecoll_itr = 1 : sec
            ecoll_itr;
            final_index = edges_collection(ecoll_itr,1);
            for another_itr = choose_itr:-1:l
                buffer_index = edges_collection(ecoll_itr, another_itr);
                final_index = final_index + (buffer_index-1) * SAS.^(another_itr-1);
            end
            buffer_freq_cell = cell2mat(freq_cell(1,choose_itr));
            buffer_freq_cell(final_index) = buffer_freq_cell(final_index) + 1;
            freq_cell(1,choose_itr) = {buffer_freq_cell};
        end
    end
    all_sum = all_sum + cell_buffer_sum;
end
