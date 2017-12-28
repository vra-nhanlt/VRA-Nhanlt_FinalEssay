function [imageIndex, imageIndex2, imageIndex3] = addNewImagesToImgIndex(imgsIndex, imgsIndex2, imgsIndex3, savedImgsIndex, savedImgsIndex2, savedImgsIndex3)
% show open Image Dialog
[filenames, pathname] = uigetfile({'*.jpg','JPEG files (*.jpg)'},'Select (an) image(s)', 'MultiSelect', 'on');
if ~isequal(filenames,0)   
    % add path to filenames
    filenames = cellstr(filenames); 
    numOfFiles = length(filenames);
    for (i = 1:numOfFiles)
        filenames(i) = strcat(pathname, filenames(i));
    end
    
     % show waiting bar
    waitingBar = waitbar(0.3,strcat({'Indexing'}, {' '}, {num2str(numOfFiles)}, {' '}, {'new image(s). Please wait...'}));
    
    % create datastore
    imds = imageDatastore(filenames);
    addImages(imgsIndex,imds);
    addImages(imgsIndex2,imds);
    addImages(imgsIndex3,imds);
    imageIndex = imgsIndex;
    imageIndex2 = imgsIndex2;
    imageIndex3 = imgsIndex3;
    % save imgsIndex
    save(savedImgsIndex, 'imgsIndex');
    imgsIndex = imageIndex2;
    save(savedImgsIndex2, 'imgsIndex');
    imgsIndex = imageIndex3;
    save(savedImgsIndex3, 'imgsIndex');
    
    % close waiting bar
    close(waitingBar);
end
end

