% with new boundary_buffer v4
% with basic Bees & Cees   v5
% with backward builders   v6
% with forward  creators   v7 without basic Bees
% clc; 

criug = calc_rem_inters_u_gap(n, (n-2)*prev); %criug

B = A(2:end , 2:end); B = triu(B)'; C = B + triu(A(1:end-1, 1:end-1));
for ritr1 = 2:length(C)
    for ritr2 = 1:ritr1-1
        smap(C(ritr1,ritr2)) = C(ritr2,ritr1);
    end
end; smap;

lcupdate = []; update_factor = 3;
basic_lcupdate = A(Asize, 1:end-1);
if(zaswitch == 0)
    thisrand = [randi([0,1], 1,(Asize-1-floor(Asize/update_factor))) zeros( 1 , floor(Asize/update_factor) )]
else
    thisrand = [zeros( 1 , floor(Asize/update_factor) ) randi([0,1], 1,(Asize-1-floor(Asize/update_factor)))]
end
lcupdate = basic_lcupdate .* thisrand


if(length(lcupdate) > 0 && lcupdate(1) == Asize-1) rend = 2; else rend = 1; end

for uritr1 = 1:Asize-1 %rend
    crint_cells{1, uritr1} = {};
    crint_cells{2, uritr1} = {};
end

for uritr1 = Asize:length(crint_counter)
    newtemp_crint_counter = 0;    
    for uritr2 = 1 : crint_counter(uritr1)
        smap_buffer = smap(crint_cells{1, uritr1}{uritr2,1});
        f_smap_buffer = find(smap_buffer == 0);
        if(length(f_smap_buffer) == 0)
            newtemp_crint_counter = newtemp_crint_counter + 1;
            crint_cells{1, smap(uritr1)}{newtemp_crint_counter,1} = smap_buffer;
            boundary_buffer = crint_cells{1, uritr1}{uritr2,2};
            crint_cells{1, smap(uritr1)}{newtemp_crint_counter,2} = [boundary_buffer(:,2:end) [0;0]];
            crint_cells{1, smap(uritr1)}{newtemp_crint_counter,3} = crint_cells{1, uritr1}{uritr2,3};
            crint_cells{1, smap(uritr1)}{newtemp_crint_counter,4} = crint_cells{1, uritr1}{uritr2,4};
            crint_cells{1, smap(uritr1)}{newtemp_crint_counter,5} = crint_cells{1, uritr1}{uritr2,5};
            crint_cells{1, smap(uritr1)}{newtemp_crint_counter,6} = crint_cells{1, uritr1}{uritr2,6};
        else
            crint_counter(uritr1) = crint_counter(uritr1) - 1;
        end
    end
    
    if(crint_counter(uritr1) > 0)
        for uritr2 = 1 : Asize-1
            crint_cells{2, uritr1}{uritr2,1}
            crint_cells{2, smap(uritr1)}{uritr2,1} = crint_cells{2, uritr1}{uritr2,1};
        end
    end
    
    crint_counter(smap(uritr1)) = crint_counter(uritr1);
    crint_counter(uritr1) = 0;
    crint_cells{1, uritr1} = {};
    crint_cells{2, uritr1} = {};

end

%Fixing Asize for repetitive update (issue of 5)
crint_counter(Asize-1) = 0;
crint_cells{1, Asize-1} = {};
crint_cells{2, Asize-1} = {};

for ritr1 = 1:length(lcupdate) 
    if(lcupdate(ritr1) > 0)
        boundary_buffer = zeros(2, Asize);
        subt = subtmap(lcupdate(ritr1), :);
        boundary_buffer(1,subt(1)) = boundary_buffer(1,subt(1)) + 1; boundary_buffer(1,subt(2)) = boundary_buffer(1,subt(2)) + 1;
        boundary_buffer(2,subt(1)) = boundary_buffer(2,subt(1)) + 1; boundary_buffer(2,subt(2)) = boundary_buffer(2,subt(2)) + 1;
        crint_cells{1, lcupdate(1,ritr1)} = {lcupdate(ritr1) boundary_buffer [1] criug(Asize-1, 1) [] []};
        crint_cells{2, lcupdate(1,ritr1)}{1,1} = [1];
        for small_itr = 2:Asize-1
            crint_cells{2, lcupdate(1,ritr1)}{small_itr,1} = [];
        end
        crint_counter(lcupdate(1,ritr1)) = crint_counter(lcupdate(1,ritr1)) + 1;
    end
end

for uritr1 = 1 :sum([1:Asize-1])
    if(uritr1 == Asize-1)
        final_crint_counter{1, uritr1} = [1];
    else
        final_crint_counter{1, uritr1} = [crint_counter(uritr1)];
    end
end


smap_remove_edges = smap(remove_edges);
smap_remove_edges = [smap_remove_edges lcupdate];
smap_remove_edges = sort(smap_remove_edges);
smap_remove_edges = smap_remove_edges((length(find(smap_remove_edges == 0))+1) : length(smap_remove_edges));
remove_edges = smap_remove_edges
first_buffer = lcupdate(find(lcupdate > 0));
if(length(first_buffer) > 0)
    start_update = find(remove_edges == first_buffer(1))
else
    start_update = 1;
end



for ritr1 = start_update : length(remove_edges)
    [ritr1 length(remove_edges)]; % for testing computation time using Whole_Pipeline.m
    isNewr1 = find(lcupdate == remove_edges(ritr1));
    for ritr2 = 1: ritr1-1
        isNewr2 = find(lcupdate == remove_edges(ritr2));
        if(length(isNewr1) == 0 && length(isNewr2) == 0)
            continue;
        end
        mfcc = final_crint_counter{1, remove_edges(ritr2)}; % mat_final_crint_counter
        lmfcc = length(mfcc);
        for ritr4 = 1 : lmfcc
            tfcc = 0; % temp_final_crint_counter
            if(mfcc(ritr4) > 0) %% bp
                ritr3_start = sum(mfcc(1:ritr4-1)) + 1;
                ritr3_end = ritr3_start + mfcc(ritr4) - 1;
            else
                continue;
            end
            if (ritr4 == 1)
                chunk_parent = crint_counter(remove_edges(ritr2)) + 1;
            else
                chunk_parent = [ritr3_start chunk_parent(end)];
            end
            for ritr3 = ritr3_start : ritr3_end
                boundary_buffer = crint_cells{1, remove_edges(ritr2)}{ritr3,2};
                subt = subtmap(remove_edges(ritr1),:);
                
                boundary_buffer = update_boundary(boundary_buffer, subt);
                r2 = length(boundary_buffer);
                
                if(r2>0)
                    tfcc = tfcc + 1;
                    crint_counter(remove_edges(ritr2)) = crint_counter(remove_edges(ritr2)) + 1;
                    crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 1} = [crint_cells{1, remove_edges(ritr2)}{ritr3,1} remove_edges(ritr1)];
                    crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 2} = boundary_buffer;
                    crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 3} = calc_rgaps(boundary_buffer);
                    crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 4} = criug((Asize- length(crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 1})), crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 3});
                    % notice (ritr)s next line
                    if(ritr4 == 1 && crint_counter(remove_edges(ritr2)) == chunk_parent)
                        crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 5} = [crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 5} ritr3]; %Cee
                    elseif(ritr3 == ritr3_start)
                        crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 5} = [crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 5} ritr3 chunk_parent(end)]; %Cee
                        chunk_parent(1) = crint_counter(remove_edges(ritr2));
                    else
                        crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 5} = [crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 5} ritr3 chunk_parent]; %Cee
                    end
                    
                    tier_index = crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 5};
                    result_update_creators = update_creators( crint_cells, [remove_edges(ritr2) crint_counter(remove_edges(ritr2))], tier_index(end) );
                    crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 6} = [crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 6}  result_update_creators  ]; % updated_Cees
                    
                    buffer_length = length([crint_cells{1, remove_edges(ritr2)}{ritr3,1} remove_edges(ritr1)]);
                    crint_cells{2, remove_edges(ritr2)}{buffer_length, 1};
                    crint_cells{2, remove_edges(ritr2)}{buffer_length, 1} = [crint_cells{2, remove_edges(ritr2)}{buffer_length, 1} crint_counter(remove_edges(ritr2))]; % row two of crint

                end
            end
            mfcc = [mfcc tfcc];
        end %%bp
        final_crint_counter{1, remove_edges(ritr2)} = mfcc;
    end
end



