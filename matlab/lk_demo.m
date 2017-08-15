tracker = [185 130 120 120];       % TODO Pick a bounding box in the format [x y w h]

% You can use ginput to get pixel coordinates

vid = VideoWriter('car.mp4');
vid.FrameRate = 20;
open(vid);

%% Initialize the tracker
figure;

oldFrame = imread('../data/car/frame0020.jpg');

%% Start tracking[pp
for i = 21:280
    newFrame = imread(sprintf('../data/car/frame%04d.jpg', i));
    [u, v] = LucasKanade(oldFrame, newFrame, tracker);
    tracker(1) = tracker(1) + u;
    tracker(2) = tracker(2) + v;
    clf;
    hold on;
    imshow(newFrame);   
    rectangle('Position', tracker, 'EdgeColor', [1 1 0]);
    drawnow;
    F = getframe;
    writeVideo(vid,im2double(F.cdata));

    oldFrame = newFrame;
%    pause(5);
end

close(vid);

