function [ k, gx, gy ] = get_kernel( type, radius, w, h )
    if (strcmp(type, 'Gaussian'))
        k = fspecial('gaussian', [h,w], radius);
        
    elseif (strcmp(type, 'Epanechnikov'))
        k = zeros(h,w);
        xp = w/2;
        yp = h/2;
                
        for i=1:h
            for j=1:w

                xx = j;
                xy = i;
                
                xnorm = (norm((xx-xp)/(radius*w)))^2;
                ynorm = (norm((xy-yp)/(radius*h)))^2;

                if (xnorm + ynorm <= 1)
                    k(i,j) = 1 - xnorm - ynorm;
                end

            end
        end
    end
    
    [gx, gy] = gradient(k);
    
end