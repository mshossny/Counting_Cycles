% calculate removed intersecting edges using gaps
% Asize   : maximum size of segment
% G       : number of gaps within the segment
% seg_len : length of segment
function varargout = calc_rem_inters_u_gap(Asize, rem1)

rem_inters_edges(Asize-1,1) = rem1;
rem_inters_edges(Asize-2,1) = rem1/(Asize-2);
n_2 = Asize - 2;
pyr_height = floor(Asize/2);
temp_step = 0;
for pyr_base = Asize-3:-1:1
    rem_inters_edges(pyr_base, 1) = ( rem_inters_edges(pyr_base+1,1) - 1 ) / (pyr_base);
end
rem_inters_edges;

for pyr_steps = 2:pyr_height
    for remaining = pyr_steps:Asize-pyr_steps
        if(remaining - pyr_steps == 0)
            rem_inters_edges(remaining, pyr_steps) = ((remaining-pyr_steps) * rem_inters_edges(remaining-1, pyr_steps-1) )   +   (((pyr_steps-1)*2)*rem_inters_edges(remaining-1, pyr_steps-1));
        else
            rem_inters_edges(remaining, pyr_steps) = ((remaining-pyr_steps) * rem_inters_edges(remaining-1, pyr_steps  ) )   +   (((pyr_steps-1)*2)*rem_inters_edges(remaining-1, pyr_steps-1));
        end
    end
end


varargout{1} = rem_inters_edges;
