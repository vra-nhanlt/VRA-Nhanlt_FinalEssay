function [imgsIndex] = loadDataAndIndex(inputData, savedBagOfVisualWords, savedImgsIndex, featuresDetector, vocabularySize)
if ~exist(strcat(savedImgsIndex, '.mat'), 'file')
    % Load datastore
    imgDataStore = imageDatastore(inputData, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
        
    if ~exist(strcat(savedBagOfVisualWords, '.mat'), 'file')
        % create bag of features
        switch featuresDetector
            case 'SURF'
                bag = bagOfFeatures(imgDataStore, 'VocabularySize', vocabularySize,  'CustomExtractor', @extractFeaturesSURF);
            case 'Harris_SURF'
                bag = bagOfFeatures(imgDataStore, 'VocabularySize', vocabularySize,  'CustomExtractor', @extractFeaturesHarrisAndSURF);
            case 'Color'
                bag = bagOfFeatures(imgDataStore, 'VocabularySize', vocabularySize,  'CustomExtractor', @extractColorFeatures);
            case 'FAST_HoG'
                bag = bagOfFeatures(imgDataStore, 'VocabularySize', vocabularySize,  'CustomExtractor', @extractFeaturesFAST_HoG); 
            case 'LBP'
                bag = bagOfFeatures(imgDataStore, 'VocabularySize', vocabularySize,  'CustomExtractor', @extractFeaturesLBP);
            case 'MinEigen_SURF'
                bag = bagOfFeatures(imgDataStore, 'VocabularySize', vocabularySize,  'CustomExtractor', @extractFeaturesMinEigenFeaturesAndSURF);
            case 'FAST_SURF'
                bag = bagOfFeatures(imgDataStore, 'VocabularySize', vocabularySize,  'CustomExtractor', @extractFeaturesFASTAndSURF);
            case 'Grid_SURF'
                bag = bagOfFeatures(imgDataStore, 'VocabularySize', vocabularySize,  'CustomExtractor', @extractFeaturesGridSURF);
            case 'SURF_HoG'
                bag = bagOfFeatures(imgDataStore, 'VocabularySize', vocabularySize,  'CustomExtractor', @extractFeaturesSURF_HoG);
        end
        save(savedBagOfVisualWords, 'bag');
    else
        load(savedBagOfVisualWords);
    end

    % index images
    saveFeatureLocations = ~(strcmp(featuresDetector, 'Color') || strcmp(featuresDetector, 'SURF_HoG')|| strcmp(featuresDetector, 'FAST_HoG') || strcmp(featuresDetector, 'LBP'));
    imgsIndex = indexImages(imgDataStore, bag, 'SaveFeatureLocations', saveFeatureLocations);
    save(savedImgsIndex, 'imgsIndex');
else
    load(savedImgsIndex);
end
end

