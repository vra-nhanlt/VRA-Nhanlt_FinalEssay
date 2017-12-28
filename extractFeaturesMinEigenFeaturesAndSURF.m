function [features, metrics, location] = extractFeaturesMinEigenFeaturesAndSURF(img)

   % convert RGB to Gray  
    if size(img,3)== 3
            img = rgb2gray(img);
    end
    
    % detect interested points using SURF
    % interestedPoints = detectSURFFeatures(img);
    
    % detect interested points using Harris
    % interestedPoints = detectHarrisFeatures(img);
    
    % detect interested points using MSER
    %interestedPoints = detectMSERFeatures(img);
    
    % detect interested points using Fast
    % interestedPoints = detectFASTFeatures(img);
    % interestedPoints = selectStrongest(interestedPoints, 1000);
    
    % detect interested points using BRISK
    % interestedPoints = detectBRISKFeatures(img);
    
    % detect interested points using MinEigenFeatures
    interestedPoints = detectMinEigenFeatures(img);
    interestedPoints = selectStrongest(interestedPoints, 1000);
    
    % extract features
    [features] = extractFeatures(img, interestedPoints, 'Method', 'SURF', 'Upright', true);
    location = interestedPoints.Location;
    metrics  = var(features, [], 2);
end
