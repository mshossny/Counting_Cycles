% putting loops into cells for later comparisons
%--------------------------------------------------

% clc; clear all;

function varargout = traverse_graph_v2_func(n)

news = []; newt = []; neww = [];

% n = 8; Asize = n;
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
        prev = nchoosek(i, 2) * (((i-2) * 1) + 1);
        interval_sum  = nchoosek(i, 2) * (((i-2) * 1) + 1);
    else
        interval_sum = interval_sum + (nchoosek(i, 2) * (    ((i - 2) * prev) + 1)    );
        prev = ((i - 2) * prev) + 1;
    end
end
interval_sum

% entry_edges = nchoosek(A(1:n-1, n),2);
interval_id = 0; mycells = {} ; Asize = n;
for n = 3:Asize
    entry_edges = nchoosek(A(1:n-1, n),2);
    entry_edges_length = 0;
    if(length(entry_edges) == 2)
        entry_edges_length = 1;
    else
        entry_edges_length = length(entry_edges);
    end
    for i = 1:entry_edges_length
        indeces = [];
        sample_loop = entry_edges(i,:);
        lstart = sample_loop(1,1); lend = sample_loop(1,2);

        % find edges indeces to start traversal
        indstr = 0; indend = 0; jitr = 1; index_sum = n-1;
        for istr = Asize-1 :-1: 1
            if(jitr > 1)
                index_sum = index_sum + istr;
            end
            if(lstart == index_sum)
                indstr = jitr;
            end
            if(lend == index_sum)
                indend = jitr;
            end
            jitr = jitr + 1;
        end

        linebreak = '--------------------------------------------------'

        sample_loop
        indeces = [indstr indend];
        % traverse graph
        buffer_A = A(1:n, 1:n);
        buffer_A(:, n) = abs(buffer_A(:, n)) * -1;
        buffer_A(n, :) = abs(buffer_A(n, :)) * -1;
        sign_mask = ones(1,n); sign_mask(1,end) = -1;

        buffer_A;

        itrindend = indend;
        gti = 1; isRow = 1;
        while (length(indeces) >= 2)
            gti;
            if(buffer_A(itrindend, gti) <= 0)
                display = 'DO NOTHING';
            elseif(buffer_A(itrindend, gti) == buffer_A(itrindend, indstr))
                print_sample_loop = [sample_loop buffer_A(itrindend,gti)];
                interval_id = interval_id+1;
                mycells(interval_id,1) = {print_sample_loop};
                sample_loop;
            else
                sample_loop = [sample_loop buffer_A(itrindend, gti)];
                buffer_A(itrindend, :) = abs(buffer_A(itrindend, :)) * -1;
                buffer_A(:, itrindend) = abs(buffer_A(:, itrindend)) * -1;
                sign_mask(1, itrindend) = sign_mask(1, itrindend) * -1;
                indeces = [indeces gti];
                itrindend = gti;
                gti = 0;
            end
            % reverse negatives
            if(gti == n)
                reverse_row = 0; remitrindend = 0;
                while(length(indeces) >= 2)
                    last_index = indeces(1,end); last_index_1 = indeces(1,end-1);
                    if((last_index < n-1))
                        if(reverse_row == 1)
                            buffer_A(indeces(1,end), :) = abs(buffer_A(indeces(1,end), :)) .* sign_mask;
                            buffer_A(: , indeces(1,end)) = buffer_A(indeces(1,end), :)';
                            buffer_A(gti, :) = abs(buffer_A(gti, :)) .* sign_mask;
                            buffer_A(: , gti) = buffer_A(gti, :)';
                            reverse_row = 0;
                            break;
                        else
                            if ((last_index+1) == last_index_1)
                                gti = last_index + 1;
                            else
                                gti = last_index;
                            end
                            sign_mask(1, indeces(1,end-1)) = 1; %% in prev version
                            sample_loop = [sample_loop(1, 1:(end-1))];
                            indeces = [indeces(1, 1:(end-1))]; %% in prev version
                            itrindend = indeces(1, end);
                            buffer_A(indeces(1,end), :) = abs(buffer_A(indeces(1,end), :)) .* sign_mask;
                            buffer_A(: , indeces(1,end)) = buffer_A(indeces(1,end), :)';
                            break;
                        end
                    else
                        indeces = [indeces(1, 1:(end-1))];
                        if(length(indeces) > 1)
                            sample_loop = [sample_loop(1, 1:(end-2))];
                            sign_mask(1, indeces(1,end)) = 1;
                            sign_mask(1, indeces(1,end-1)) = 1;
                            gti = indeces(1,end);
                            indeces = [indeces(1, 1:(end-1))];
                            itrindend = indeces(1, end);
                            reverse_row = 1;
                        end
                    end
                end
            end
            gti = gti + 1;
        end

    end
end

varargout{1} = mycells;



