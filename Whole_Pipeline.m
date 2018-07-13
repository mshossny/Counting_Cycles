% whole pipeline based one update_rem_inters_edges_v5 and update_rem_inters_edges_v4
clear all;
news = []; newt = []; neww = [];

n = 12; Asize = n;
for i =1:n
    news = [news, i*ones(1, n-i)];
    newt = [newt [i+1 :n]];
end
weights = size(news(1,:));
neww = [1:weights(1,2)];
newG = graph(news, newt, neww);

[ms, mt] = findedge(newG);
A = sparse(ms, mt, newG.Edges.Weight, n, n);
A = full(A);
A = A+A'

prev = 1;
interval_sum = 0;
for i = 2:n-1
    if(i == 2)
        prev = nchoosek(i, 2) * (((i-2) * 1) + 1)
        interval_sum  = nchoosek(i, 2) * (((i-2) * 1) + 1)
    else
        interval_sum = interval_sum + (nchoosek(i, 2) * (    ((i - 2) * prev) + 1)    )
        prev = ((i - 2) * prev) + 1
    end
end
interval_sum;
n_2_prev = (n-2)*prev;


remove_edges = [1 2 8 13 15];
calc_rem_inters_edges_v5
% for za = 1: floor(n*2.5)
for za = 1: 12
    za
    zaswitch = mod(za,2)
    update_rem_inters_edges_v4
%     clc;
end