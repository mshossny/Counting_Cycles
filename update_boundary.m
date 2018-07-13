%returns updated boundary if successful and empty one if failure
function varargout = update_boundary(boundary_buffer, subt)

if(boundary_buffer(1,subt(1)) == 2 || boundary_buffer(1,subt(2)) == 2)
    boundary_buffer = [];
else
    mymax = max(boundary_buffer(2,:));
    if(boundary_buffer(1, subt(1)) + boundary_buffer(1, subt(2)) == 0)
        
        boundary_buffer(1, subt(1)) = boundary_buffer(1, subt(1)) + 1; boundary_buffer(1, subt(2)) = boundary_buffer(1, subt(2)) + 1;
        boundary_buffer(2, subt(1)) = mymax + 1; boundary_buffer(2, subt(2)) = mymax + 1;
        
    elseif(boundary_buffer(1, subt(1)) + boundary_buffer(1, subt(2)) == 1)
        
        boundary_buffer(1, subt(1)) = boundary_buffer(1, subt(1)) + 1; boundary_buffer(1, subt(2)) = boundary_buffer(1, subt(2)) + 1;
        if(boundary_buffer(2, subt(1)) == 0)
            boundary_buffer(2, subt(1)) = boundary_buffer(2, subt(2));
        else
            boundary_buffer(2, subt(2)) = boundary_buffer(2, subt(1));
        end
        
    elseif(boundary_buffer(1, subt(1)) + boundary_buffer(1, subt(2)) == 2)
        if (boundary_buffer(2, subt(1)) == boundary_buffer(2, subt(2)))
            boundary_buffer = [];
        else
            boundary_buffer(1, subt(1)) = boundary_buffer(1, subt(1)) + 1; boundary_buffer(1, subt(2)) = boundary_buffer(1, subt(2)) + 1;
            findeces = find(boundary_buffer(2,:) == boundary_buffer(2, subt(1)));
            boundary_buffer(2,findeces) = boundary_buffer(2, subt(2));
        end
    end
end

varargout{1} = boundary_buffer;