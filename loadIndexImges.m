function [imgsIndex, imgsIndex2, imgsIndex3] = loadIndexImges(topic, inputData, savedBagOfVisualWords, savedImgsIndex, savedBagOfVisualWords2, savedImgsIndex2, savedBagOfVisualWords3, savedImgsIndex3)
switch topic
    case 'Flowers'
        [imgsIndex] = loadDataAndIndex(inputData, savedBagOfVisualWords3, savedImgsIndex3, 'Color', 1000);
        [imgsIndex2] = loadDataAndIndex(inputData, savedBagOfVisualWords, savedImgsIndex, 'Color', 500);
        [imgsIndex3] = loadDataAndIndex(inputData, savedBagOfVisualWords2, savedImgsIndex2, 'MinEigen_SURF', 500);    
    otherwise
        [imgsIndex] = loadDataAndIndex(inputData, savedBagOfVisualWords, savedImgsIndex, 'FAST_HoG', 500);
        [imgsIndex2] = loadDataAndIndex(inputData, savedBagOfVisualWords2, savedImgsIndex2, 'SURF', 1000);
        [imgsIndex3] = loadDataAndIndex(inputData, savedBagOfVisualWords3, savedImgsIndex3, 'FAST_SURF', 500);
end
end

