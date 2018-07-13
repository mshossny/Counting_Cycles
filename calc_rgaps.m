% calculate number of removed gaps
function varargout = calc_rgaps(boundary)
ones = 0; twos = 0;
for i = 1:length(boundary)
    if(boundary(1,i) == 2)
        twos = twos + 1;
    elseif(boundary(1,i) == 1)
        ones = ones + 1;
    end
end

num_gaps = ((2*twos + ones)/2) - twos ;

varargout{1} = num_gaps;

