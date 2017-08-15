function [ dx, dy ] = calculate_mean_shift( width, height, w, gx, gy )
    g = sqrt(gx.^2 + gy.^2);
    
   [X, Y] = meshgrid(1:width, 1:height);


    mx = sum(X .* w .* g) / (sum(w .* g));
    my = sum(Y .* w .* g) / (sum(w .* g));

    h2 = height/2;
    w2 = width/2;

    dx = mx - w2;
    dy = my - h2;
end