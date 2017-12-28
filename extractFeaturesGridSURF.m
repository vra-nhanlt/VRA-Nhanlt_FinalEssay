function [features, featureMetrics, varargout] = extractFeaturesGridSURF(I)
%% Preprocess the Image
% Convert I to grayscale if required.
[height,width,numChannels] = size(I);
if numChannels > 1
    grayImage = rgb2gray(I);
else
    grayImage = I;
end

%% Step 2: Select Point Locations for Feature Extraction
% Define a regular grid over I.
gridStep = 8; % in pixels
gridX = 1:gridStep:width;
gridY = 1:gridStep:height;

[x,y] = meshgrid(gridX, gridY);

gridLocations = [x(:) y(:)];

%%
% Concatenate multiple SURFPoint objects at different scales to achieve
% multiscale feature extraction.
multiscaleGridPoints = [SURFPoints(gridLocations, 'Scale', 1.6); 
                        SURFPoints(gridLocations, 'Scale', 3.2);
                        SURFPoints(gridLocations, 'Scale', 4.8);
                        SURFPoints(gridLocations, 'Scale', 6.4)];
                    
%% Step 3: Extract features
% Finally, extract features from the selected point locations. By default,
% bagOfFeatures extracts upright SURF features. 
features = extractFeatures(grayImage, multiscaleGridPoints,'Upright',true);

%% Step 4: Compute the Feature Metric
% Use the variance of the SURF features as the feature metric.
featureMetrics = var(features,[],2);

if nargout > 2
    % Return feature location information
    varargout{1} = multiscaleGridPoints.Location;
end


