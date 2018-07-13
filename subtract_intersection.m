% subtract_intersection

for si_itr1 = 1 : length(remove_edges)
    for(si_itr2 = 1 : crint_counter(remove_edges(si_itr1)))
        crint_cells{1, remove_edges(si_itr1)}{si_itr2,7} = crint_cells{1, remove_edges(si_itr1)}{si_itr2,4};
        for si_itr3 = 1 : (Asize - 2)
            crint_cells{3, remove_edges(si_itr1)}{si_itr2,si_itr3} = [];
        end
    end
end


buffer_crint_cells = {};
buffer_crint_counter = 0;

% fill length_oriented indeces
for si_itr1 = 1 : length(remove_edges)
    
    Asize_1_intervals = crint_cells{ 2, remove_edges(si_itr1) }{( Asize-1) , 1 };
    for si_itr2 = 1 : length(Asize_1_intervals)
        
        buffer_creator = crint_cells{1, remove_edges(si_itr1)}{Asize_1_intervals(si_itr2) , 6 };   % edges of certain length
        
        for si_itr3 = 1 : length(buffer_creator)
            crint_cells{ 3 , remove_edges(si_itr1) }{ buffer_creator(si_itr3) , (Asize-2) } = [ crint_cells{ 3 , remove_edges(si_itr1) }{ buffer_creator(si_itr3) , (Asize-2) }  Asize_1_intervals(si_itr2) ];
        end
        
    end
    
    for si_itr2 = (Asize-2):-1:3
        
        lenintedg = crint_cells{2, remove_edges(si_itr1)}{si_itr2,1};   % edges of certain length
        
        for si_itr3 = 1: length(lenintedg)
            
            buffer_creator = crint_cells{1, remove_edges(si_itr1)}{lenintedg(si_itr3),6};
            
            for si_itr4 = 1 : length(buffer_creator)
                path = cell( ( Asize - si_itr2 - 1 ) ,  1  );
            
                for si_itr2_add = si_itr2 : (Asize-2)
                    
                    if (si_itr2_add == si_itr2)
                        if (length( find( crint_cells{3, remove_edges(si_itr1) }{ buffer_creator(si_itr4) , (si_itr2-1) } == lenintedg(si_itr3) ) ) == 0)
                            crint_cells{3, remove_edges(si_itr1) }{ buffer_creator(si_itr4) , (si_itr2-1) } = [ crint_cells{3, remove_edges(si_itr1) }{ buffer_creator(si_itr4) , (si_itr2-1) }  lenintedg(si_itr3) ]; 
                        end
                    end
                    
                    pre_path = crint_cells{3, remove_edges(si_itr1) }{ buffer_creator(si_itr4) , si_itr2_add };
                    suff_path = crint_cells{3, remove_edges(si_itr1)}{ lenintedg(si_itr3) , si_itr2_add }; 
                    new_suff_path = [];

                    for si_itr5 = 1 : length(suff_path)
                        suff_path_test = find(pre_path == suff_path(si_itr5));
                        
                        if(  length( suff_path_test) == 0 )
                            new_suff_path = [ new_suff_path  suff_path(si_itr5) ];
                        end
                    end
                    crint_cells{3, remove_edges(si_itr1) }{ buffer_creator(si_itr4) , si_itr2_add } = [pre_path new_suff_path];
                    
                end
                
            end
            
        end
    end
end

%update_criug
remove_edges_intersections = zeros(length(remove_edges))-1;
for si_itr1 = 1 : length(remove_edges)
    
    for si_itr2 = (Asize-2):-1:2
        
        lenintedg = crint_cells{2, remove_edges(si_itr1)}{si_itr2,1};   % edges of certain length
        
        for si_itr3 = 1 : length(lenintedg)

            for si_itr2_add = si_itr2 : (Asize-2)
                buffer_criug_editor = crint_cells{3, remove_edges(si_itr1)}{lenintedg(si_itr3), si_itr2_add};

                for si_itr5 = 1 : length(buffer_criug_editor)
                    crint_cells{1, remove_edges(si_itr1)}{lenintedg(si_itr3), 7} = crint_cells{1, remove_edges(si_itr1)}{lenintedg(si_itr3), 7} - crint_cells{1, remove_edges(si_itr1)}{buffer_criug_editor(si_itr5), 7};
                end
            end
        end
    end
    
end



% subtract
number_of_cycles = interval_sum;
for si_itr1 = length(remove_edges) : -1 : 1
    if(remove_edges_intersections(si_itr1) > -1)
        number_of_cycles = number_of_cycles - remove_edges_intersections(si_itr1)
    end
end

