clear builders_intersection

eui = 1;

item_builders = crint_cells{3,eui}{769, 5} % [1 3 23 27] 2 gaps with 2 slots

builders_intersection = cell(length(item_builders),1);
for tr_i1 = 1 : length(item_builders)
    builders_intersection{tr_i1,1} = [];
end
endinterval_intersection = cell(length(i_removed_cells),1);

for tr_i1 = 1 : length(item_builders)
    
    bib = item_builders(tr_i1); % buffer item_builders
    bib_edge = crint_cells{1,eui}{bib, 1};

    for tr_i2 = 1 : length(i_removed_cells)
        
        birc = i_removed_cells{tr_i2,1}; % buffer i_removed_cells
        
        test_inclusion = 1;
        
        for tr_i3 = 1 : length(bib_edge)
            
            test_inclusion = find(birc == bib_edge(tr_i3));
            if (length(test_inclusion) == 0)
                break;
            end
            
            if(tr_i3 == length(bib_edge))
                builders_intersection{tr_i1,1} = [builders_intersection{tr_i1,1} tr_i2];
                endinterval_intersection{tr_i2,1} = [endinterval_intersection{tr_i2,1} tr_i1];
            end
            
        end
        
    end
    
end