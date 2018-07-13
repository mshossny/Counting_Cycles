clc; clear crint_cells

Asize = n;
% remove_edges = [45 40 31 18 1]
remove_edges = [1 2 6 7 8 12 13 15]
crint_cells(1,1) = {remove_edges(1:2)};
one = find(A > remove_edges(1,1)- 1 & A < remove_edges(1,1)+ 1);
two = find(A > remove_edges(1,2)- 1 & A < remove_edges(1,2)+ 1);
[sub1 sub2] = ind2sub([Asize Asize] , [one(1) two(1)]);
boundary_buffer = zeros(1,Asize);
boundary_buffer(sub1(1,1)) = boundary_buffer(sub1(1,1))+1; boundary_buffer(sub1(1,2)) = boundary_buffer(sub1(1,2))+1;
boundary_buffer(sub2(1,1)) = boundary_buffer(sub2(1,1))+1; boundary_buffer(sub2(1,2)) = boundary_buffer(sub2(1,2))+1;
crint_cells(1,2) = {boundary_buffer};
crint_counter = 1;


for ritr1 = 3 : length(remove_edges)
    itr_crint_counter = crint_counter;
    for ritr2 = 1: ritr1-1
        crint_counter = crint_counter+1;
        crint_cells(crint_counter, 1) = {[remove_edges(ritr2) remove_edges(ritr1)]};
        one = find(A > remove_edges(ritr2)- 1 & A < remove_edges(ritr2)+ 1);
        two = find(A > remove_edges(ritr1)- 1 & A < remove_edges(ritr1)+ 1);
        [sub1 sub2] = ind2sub([Asize Asize] , [one(1) two(1)]);
        boundary_buffer = zeros(1,Asize);
        boundary_buffer(sub1(1,1)) = boundary_buffer(sub1(1,1))+1; boundary_buffer(sub1(1,2)) = boundary_buffer(sub1(1,2))+1;
        boundary_buffer(sub2(1,1)) = boundary_buffer(sub2(1,1))+1; boundary_buffer(sub2(1,2)) = boundary_buffer(sub2(1,2))+1;
        crint_cells(crint_counter,2) = {boundary_buffer};
    end
    for ritr2 = 1 : itr_crint_counter
        boundary_buffer = cell2mat(crint_cells(ritr2,2));
        r1 = find(A > remove_edges(ritr1) - 1 & A < remove_edges(ritr1) + 1);
        [sub1 sub2] = ind2sub([Asize Asize] , [r1(1)]);
        boundary_buffer(sub1) = boundary_buffer(sub1) + 1; boundary_buffer(sub2) = boundary_buffer(sub2) + 1;
        r2 = find(boundary_buffer > 2);
        if(length(r2)==0)
            crint_counter = crint_counter+1;
            [cell2mat(crint_cells(ritr2,1)) remove_edges(ritr1)];
            crint_cells(crint_counter,1) = {[cell2mat(crint_cells(ritr2,1)) remove_edges(ritr1)]};
            crint_cells(crint_counter,2) = {boundary_buffer};
        end
    end
end

