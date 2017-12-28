function originalImage = selectAnImage(axeImg, imgSize)
% show open Image Dialog
[filename, pathname] = uigetfile({'*.jpg','JPEG files (*.jpg)'},'Select an image');
if ~isequal(filename,0)
    % show selected image
    [originalImage]=imread(strcat(pathname, filename));
    showImageInAxe(axeImg, originalImage, imgSize, imgSize);
    
    % show buttons
    pbtnCrop = findobj('Tag', 'pbtnCrop');
    pbtnCrop.Enable = 'on';
    pbtnReset = findobj('Tag', 'pbtnReset');
    pbtnReset.Enable = 'on';
    pbtnSearch = findobj('Tag', 'pbtnSearch');
    pbtnSearch.Enable = 'on';
    
    % Hide panel Evaluation
    pnEvaluation = findobj('Tag', 'pnEvaluation');
    pnEvaluation.Visible = 'off';
end
end

