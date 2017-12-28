function img = imgResize(imgInput, desiredWidth, desiredHeight)
    % real width, height
    realHeight = size(imgInput, 1);
    realWidth = size(imgInput, 2);
    
    % calculate ratio for scaling
    hRatio = realHeight/desiredHeight;
    wRatio = realWidth/desiredWidth;
    
    if (hRatio > wRatio)
        maxRatio =  hRatio
    else
        maxRatio = wRatio;
    end

    %% Resize image
    img = imresize(imgInput, [realHeight/maxRatio realWidth/maxRatio]);
end

