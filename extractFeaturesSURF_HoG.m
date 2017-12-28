function [features, metrics] = extractFeaturesSURF_HoG(img)
    % convert RGB to Gray  
    if size(img,3)== 3
            img = rgb2gray(img);
    end
    
     % detect interested points using Fast
    % interestedPoints = detectFASTFeatures(img);
    % interestedPoints = selectStrongest(interestedPoints, 1000);
    
    % detect interested points using MinEigenFeatures
    % interestedPoints = detectMinEigenFeatures(img);
    
    % detect interested points using Harris
    % interestedPoints = detectHarrisFeatures(img);
    
    % detect interested points using Surf
    interestedPoints = detectSURFFeatures(img);
    
    % detect interested points using KAZE
    % interestedPoints = detectKAZEFeatures(img);
    
    % detect interested points using BRISK
    %interestedPoints  = detectBRISKFeatures(img,'MinContrast',0.01);
     
    % detect interested points using MSER
    %interestedPoints = detectMSERFeatures(img); 
    
    % extract features
    [features] = extractHOGFeatures(img, interestedPoints);
    metrics  = var(features, [], 2);
    % metrics = features.Metric;
    
end