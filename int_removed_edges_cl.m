% intersecting removed edges clean labels
clc;

intersecting_trial_label = [];
itl2 = [1 3 23 27]

%--

intersecting_removed_cells = removed_cells;
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
    end
end