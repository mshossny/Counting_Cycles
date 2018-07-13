% whole pipeline based one update_rem_inters_edges_v5 and update_rem_inters_edges_v4
clear all;
news = []; newt = []; neww = [];

n = 8; Asize = n;

mycells = traverse_graph_v2_func(n)

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


% remove_edges = [1 2 8 13 15];
% A_lastrow = [7 13 18 22 25 27 28];

remove_edges = [1 3 4 5 6 9 10 12 14 16 17 20 22 23 27 28];


calc_rem_inters_edges_v7
