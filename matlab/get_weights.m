function [ w ] = get_weights( p, q, hue )
    [rows, cols] = size(hue);
    
    w = zeros(rows, cols);
    
    for i=1:rows
        for j=1:cols
            h = hue(i,j);
            if (p(h) ~= 0)
                w(i,j) = sqrt(q(h)/p(h));
            end
        end
    end
    
end