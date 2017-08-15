function [u,v] = LucasKanade(It, It1, rect)
    It = im2double(It);
    It1 = im2double(It1);
    
    [rows,cols] = size(It1);
    p = zeros(2,1);
    
    x = rect(1); y = rect(2); w = rect(3); h = rect(4);
    nx = x;
    ny = y;
    
    [colsM,rowsM] = meshgrid(nx:1:nx+w,ny:1:ny+h);
    warped = interp2(1:cols,1:rows,It1,colsM,rowsM);
    template = interp2(1:cols,1:rows,It,colsM,rowsM);
    err = template - warped;
    delP = 10;
    count = 0;
  
   while ((count < 80) && (norm(delP) > 0.001))
        [Ix,Iy] = gradient(warped);
        Ix2 = Ix.^2;
        IxIy = Ix.*Iy;
        Iy2 = Iy.^2;
        
        H = [sum(Ix2(:)), sum(IxIy(:)); sum(IxIy(:)), sum(Iy2(:))];
    
        xErr = Ix .* err;
        yErr = Iy .* err;
        delP = inv(H) * [sum(xErr(:)); sum(yErr(:))];

        p = p + delP;
        nx = p(1) + x;
        ny = p(2) + y;
        
        [colsM,rowsM] = meshgrid(nx:1:nx+w,ny:1:ny+h);
        warped = interp2(1:cols,1:rows,It1,colsM,rowsM);
        err = template - warped;
        
        count = count + 1;
    end
    
    u = p(1);    
    v = p(2);
        
    
end