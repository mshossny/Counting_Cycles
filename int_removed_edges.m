clc;

% intersecting_trial_label = [45 43 40 36 31];
intersecting_trial_label = [1 2 8 13 10];
intersecting_trial_label = [45 40 31 18 1 2 14];
itl2 = [1 2 8 13 10];
itl2 = [8 13 15];
itl2 = [3 10 13];
itl2 = [6 7 12 15];
itl2 = [1 2 8 13];
%--
% itl2 = [45 40 31 18 1];
% itl2 = [43 36 25 10];
%--
% itl2 = [45 40 31 18 1 14];
itl2 = [5 10 25 36 43];
%--
%--
% for n = 9 finishing thesis
% itl2 = [36 31 22 9];
% itl2 = [36 31 22 16];
% itl2 = [36 31 27 22];
% itl2 = [36 34 31 27];
%%%
% itl2 = [8 36 31 22  9  1]
% itl2 = [8 36 31 22 16  9]
% itl2 = [8 36 31 27 22 16]
% itl2 = [8 36 34 31 27 22]
itl2 = [8,36,20,16,22,31,6] %27
% itl2 = [8,36,25,22,27,31,19,9]
itl2 = [36, 31]
%--
% % for solving criug 3_edges issue (starting with n = 8)
itl2 = [1 9 14 23 27 28]
% itl2 = [1 9 14 23 17 28]
% itl2 = [1 5 9 14 17 23 27 28];
% itl2 = [1 3 17 23 27 28];
% itl2 = [1 23 17 22];
% itl2 = [1 14 23 28];
itl2 = [1 3 23 27]
%--
intersecting_removed_cells = removed_cells;
% intersecting_removed_cells = mycells;
for some_itr = 2:length(itl2)
    combinations = nchoosek(itl2, some_itr);
    sec = size(combinations); sec = sec(1,1);
    for some_itr2 = 1:sec
        intersecting_trial_label = combinations(some_itr2,:);
        i_removed_cells = {};
        counted_i_removed_cells = {};
        rdic = 0;
        for iitr = 1:length(intersecting_removed_cells)
            brcell = intersecting_removed_cells{iitr};
            int_counter = 0;
            for itlitr = 1 : length(intersecting_trial_label)
                item1 = intersecting_trial_label(itlitr);
                c1 = find( brcell > (item1 - 1) & brcell < (item1 + 1) );
                if(c1>0)
                    int_counter = int_counter + 1;
                end
            end

            if(int_counter == length(intersecting_trial_label))
                rdic = rdic + 1;
                i_removed_cells(rdic, 1) = {brcell};
                counted_i_removed_cells(rdic, 1) = {brcell}; % finishing thesis
                counted_i_removed_cells(rdic, 2) = {length(brcell)}; % finishing thesis
                aswq = 'QQQQQQQQQQQQ';
            end
        %     aswq = 'PPPPPPPPPPPP'
        end
        [combinations(some_itr2, : ) length(i_removed_cells)]
%         if(length([combinations(some_itr2, : ) length(i_removed_cells)]) == 6)
%         if([combinations(some_itr2, : ) length(i_removed_cells)] == [1 2 8 13 10 1])
%             disp('asdasd')
%         end
%         end
    end
end