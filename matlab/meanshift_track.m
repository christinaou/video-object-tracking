function [ newrect ] = meanshift_track( q, newframe, rect, k, gx, gy)
    [rows, cols] = size(newframe);
    width = rect(3);
    height = rect(4);
    ep = 4;
    
    y0 = rect;
    newrect = y0;
    iter = 0;
    
    
    while true
        [histogram, hues] = get_hue_histogram(newframe, y0, k);
        weights = get_weights(histogram, q, hues);
        
        [dx, dy] = calculate_mean_shift(width, height, weights, gx, gy);
        
        newX = round(y0(1) + dx);
        newY = round(y0(2) + dy);
        
        y1 = [newX; newY; width; height];
        
        comp1 = [y0(1), y0(2)];
        comp2 = [newX, newY];
        diff = norm(comp1-comp2);
        
        if ((diff < ep || iter > 100) && (newX > 0 && newY > 0))
            newrect = y1;
            break;
        end
        if (newX <= 0 || newY <= 0 || ...
                newX + width > cols || newY + height> rows)
            disp('rip');
            pause(1);
            break;
        end
        
        newrect = y1;
        y0 = y1;

        iter = iter + 1;
    end
    
end