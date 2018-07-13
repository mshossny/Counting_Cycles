% count removed edges

clc; clear removed_cells accumulate_cells mycells2

double_item_counter = 0;
item_counter1 = 0; item_counter2 = 0; edge_labels = sum([1:Asize-1]);
mycells2 = {mycells};
removed_cells = {}
% trial_label = [21 19 13];
% trial_label = [21 16 12];
% trial_label = [21 16 7];
% trial_label = [28 23 14 1];
% trial_label = [28 26 23 19];
% trial_label = [36 31 27 22 9 1];
% trial_label = [36 31 27 22 9 1];
% trial_label = [36 34 31 27 22 16 9 1];
trial_label = [45 40 31 18 1]; % 2 14
trial_label = [5 10 25 36 43];
% trial_label = [9 16 22 4 40];
% trial_label = [45 43 40 36 31];% 4 12
% trial_label = [45 40 36 20 23];% 4 12
% trial_label = [55 50 41 28 11];
% trial_label = [9 8 10 13 2 1 14];
% trial_label = fliplr(trial_label)
%-----------------------------------
% trial_label = [1 2 13 8 10]
% trial_label = [8 13 15]
% trial_label = [3 10 13]
% trial_label = [6 7 12 15]
% trial_label = [1 2 8 13]
% trial_label = [1 2 6 7 8 12 13 15]
% trial_label = [1 2 3 5 8 9 10 13 14]
%------------------------------------------------
% for n=9, finishing thesis
% trial_label = [36 31 22 9]
% trial_label = [36 31 22 16]
% trial_label = [36 31 27 22]
% trial_label = [36 34 31 27]
% trial_label = [15 10 1];
% trial_label = [8 36 31 22  9  1]
% trial_label = [8 36 31 22 16  9]
% trial_label = [8 36 31 27 22 16]
% trial_label = [8 36 34 31 27 22]
trial_label = [8,36,20,16,22,31,6] %27
% trial_label = [8,36,25,22,27,31,19,9]
trial_label = [36 31]
%------------------------------------------------
% for solving criug 3_edges issue (starting with n = 8)
trial_label = [1 9 14 23 27 28]
% trial_label = [1 9 14 23 17 28]
% trial_label = [1 5 9 14 17 23 27 28]
% trial_label = [1 23 17 22]
% trial_label = [1 14 23 28];
% trial_label = [1 2 13 15]
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
