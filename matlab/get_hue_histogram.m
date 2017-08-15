function [ histogram, hue ] = get_hue_histogram( img, rect, k )
    xi = rect(1);
    yi = rect(2);
    w = rect(3);
    h = rect(4);
        
    template = img(yi:yi+h, xi:xi+w, :);
    
    HSV = rgb2hsv(template);
    H = HSV(:,:,1);
    
    C = sum(k(:));
    step = 1/360;
    
    histogram = zeros(360,1);
    hue = zeros(h,w);
    
    for m=1:360
        sumN = 0;
        for i=1:h
            for j=1:w
                point = H(i,j);
                b = floor(point / step)+1;
                hue(i,j) = b;
                if (b-m == 0)
                    sumN = sumN + k(i,j);
                end
            end
        end
        histogram(m) = sumN;
    end
    
    histogram = histogram / C;
    
end