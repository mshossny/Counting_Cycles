% with new boundary_buffer
% with Cees (Creators) and WITHOUT Bees (Builds)

clc; clear crint_cells

Asize = n;

crint_cells = {{};{}};
for ritr1 = 2:sum([1:Asize-1])
    crint_cells{1,ritr1} = {};
    crint_cells{2,ritr1} = {};
    crint_cells{3,ritr1} = {};
end

% crint_cells = {};
% for ritr1 = 1: sum([1:Asize-1])% basic case commented for 2row crint_cells
%     crint_cells = {crint_cells{:} {}};
% end

r2 = find(triu(A)>0)';
r2map(A(r2)) = r2;
[sub1 sub2] = ind2sub([Asize Asize], [r2map]);
subtmap = [sub1' sub2'];
criug = calc_rem_inters_u_gap(n, (n-2)*prev); %criug


crint_counter = zeros(1,sum([1:Asize-1]));
crint_minds_counter = zeros(Asize,Asize);
for ritr1 = 1:length(remove_edges) 
    boundary_buffer = zeros(2, Asize);
    subt = subtmap(remove_edges(ritr1), :);
    
    boundary_buffer(1,subt(1)) = boundary_buffer(1,subt(1)) + 1; boundary_buffer(1,subt(2)) = boundary_buffer(1,subt(2)) + 1;
    boundary_buffer(2,subt(1)) = boundary_buffer(2,subt(1)) + 1; boundary_buffer(2,subt(2)) = boundary_buffer(2,subt(2)) + 1;
                                                                                                                                           
    crint_cells{1, remove_edges(1,ritr1)} = {remove_edges(ritr1) boundary_buffer calc_rgaps(boundary_buffer(1,:)) criug(Asize-1, 1) [] []};    % crint_cells(:,5:6) & Cees & tier-Cees
    crint_cells{2, remove_edges(1,ritr1)}{1,1} = [1];
    for small_itr = 2:Asize-1
        crint_cells{2, remove_edges(1,ritr1)}{small_itr,1} = [];
    end
    crint_counter(remove_edges(1,ritr1)) = crint_counter(remove_edges(1,ritr1)) + 1;
end

for uritr1 = 1 :sum([1:Asize-1])
        final_crint_counter{1, uritr1} = [1];
end


for ritr1 = 2 : length(remove_edges)
    for ritr2 = 1: ritr1-1
        mfcc = final_crint_counter{1, remove_edges(ritr2)}; % mat_final_crint_counter
        lmfcc = length(mfcc);
        % an if is necessary for first iter of crint_cells vs update
        tfcc = 0;
        for ritr4 = 1 : lmfcc
            % tfcc = 0; % temp_final_crint_counter % as in update_rem_inters_edges_v5
            if(mfcc(ritr4) > 0) %% bp
                ritr3_start = sum(mfcc(1:ritr4-1)) + 1;
                ritr3_end = ritr3_start + mfcc(ritr4) - 1;
            else
                continue;
            end
            if (ritr4 == 1)
                chunk_parent = crint_counter(remove_edges(ritr2)) + 1;
            end
            for ritr3 = ritr3_start : ritr3_end
                boundary_buffer = crint_cells{1, remove_edges(ritr2)}{ritr3,2};
                subt = subtmap(remove_edges(ritr1),:);

                boundary_buffer = update_boundary(boundary_buffer, subt);

                r2 = length(boundary_buffer);
                if(r2>0)
                    tfcc = tfcc + 1;
                    crint_counter(remove_edges(ritr2)) = crint_counter(remove_edges(ritr2)) + 1;
                    crint_minds_counter(subt(1), subt(2)) = crint_minds_counter(subt(1), subt(2)) + 1;
                    crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 1} = [crint_cells{1, remove_edges(ritr2)}{ritr3,1} remove_edges(ritr1)];
                    crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 2} = boundary_buffer;
                    crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 3} = calc_rgaps(boundary_buffer(1,:));
                    crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 4} = criug((Asize-length(crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 1})), crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 3});
                    % notice (ritr)s next line
                    if(ritr4 == 1)
                        crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 5} = [crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 5} ritr3]; %Cee
                        crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 6} = [ crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 6} update_creators(crint_cells, [remove_edges(ritr2) crint_counter(remove_edges(ritr2))], ritr3)  ]; % updated_Cees
                    else
                        crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 5} = [crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 5} ritr3 chunk_parent]; %Cee
                        crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 6} = [  crint_cells{1, remove_edges(ritr2)}{crint_counter(remove_edges(ritr2)), 6}  update_creators(crint_cells, [remove_edges(ritr2) crint_counter(remove_edges(ritr2))], chunk_parent(end))  ]; % updated_Cees
                end
                    buffer_length = length([crint_cells{1, remove_edges(ritr2)}{ritr3,1} remove_edges(ritr1)]);
                    crint_cells{2, remove_edges(ritr2)}{buffer_length, 1} = [crint_cells{2, remove_edges(ritr2)}{buffer_length, 1} crint_counter(remove_edges(ritr2))]; % row two of crint
                end
            end
            % an if is necessary for first iter of crint_cells vs update
            %mfcc = [mfcc tfcc]; %as in update_rem_inters_edges_v5
        end %%bp
        mfcc = [mfcc tfcc]; % specific for first iter of crint_cells
        final_crint_counter{1, remove_edges(ritr2)} = mfcc;
    end
end
done = 1

