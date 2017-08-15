%% Given tracker initializations
% These are in the format [x y w h]
track_cup = [ 135 152 41 55];
track_ball = [200 75 45 45 ];

% Pick one of the above
tracker = track_cup(:);
% tracker = track_ball(:);

vid = VideoWriter('desk.mp4');
vid.FrameRate = 20;
open(vid);

%% Initialize the tracker
figure;

first = imread('../data/desk/frame001.png');
firstImage = im2double(first);

% [k, gx, gy] = get_kernel('Gaussian', 2, tracker(3), tracker(4)); % Epanechnikov
[k, gx, gy] = get_kernel('Epanechnikov', 2, tracker(3), tracker(4)); % Epanechnikov
[q,h] = get_hue_histogram(firstImage, tracker, k); 
% q is just the histogram portion


%% Start tracking
% new_tracker = tracker;
for i = 2:145
    im = im2double(imread(sprintf('../data/desk/frame%03d.png', i)));
    new_tracker = meanshift_track(q, im, tracker, k, gx, gy);
    
    clf;
    hold on;
    imshow(im);   
    rectangle('Position', new_tracker, 'EdgeColor', [1 1 0]);
    drawnow;
    tracker = new_tracker;
%     pause(5);
    F = getframe;
    writeVideo(vid,im2double(F.cdata));

end

close(vid);