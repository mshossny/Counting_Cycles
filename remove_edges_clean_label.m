% count removed edges

clc; clear removed_cells accumulate_cells mycells2

double_item_counter = 0;
item_counter1 = 0; item_counter2 = 0; edge_labels = sum([1:Asize-1]);
mycells2 = {mycells};
removed_cells = {}

trial_label = [1 3 23 27]

item1 = 1;
item2 = 2;
% for it1 = 1:3
% for it1 = 1:edge_labels
double_item_counter = 0;
for it1 = 1:length(trial_label)
    item1 = trial_label(it1)
%     item1 = it1
    remove_item_counter = 0;
    accumulate_cells = {}
%     removed_cells = {}
    testing_cells = mycells2{it1};
%     length(testing_cells)
    for ci = 1:length(testing_cells)
        if(it1 == 1)
            cell_buffer = cell2mat(mycells(ci));
        else
            cell_buffer = cell2mat(testing_cells(ci));
        end
        c1 = find( cell_buffer > (item1 - 1) & cell_buffer < (item1 + 1) );
        if(length(c1) > 0)
            ci;
            c1;
            cell_buffer;
            double_item_counter = double_item_counter + 1;
            removed_cells(double_item_counter, 1) = {cell_buffer};
        else
            remove_item_counter = remove_item_counter + 1;
            accumulate_cells(remove_item_counter,1) = {cell_buffer};
        end
    end
    mycells2 = {mycells2{1:it1} accumulate_cells};
%     mymatrix4(it1, it2, it3, it4) = double_item_counter;
end
