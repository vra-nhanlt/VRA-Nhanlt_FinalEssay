function showFoundImageInDetail(pbtn, queryImg, queryImgWords1, imageIndex1, queryImgWords2, imageIndex2, queryImgWords3, imageIndex3)
% get data
data = get(pbtn,'UserData');
foundImgPath = data.imgPath;
imgID = data.imgID;
score = data.score;
IRSystemID = data.IRSystemID;

queryImgWords = queryImgWords3;
imageIndex = imageIndex3;

% switch IRSystemID
%     case 1
%         queryImgWords = queryImgWords1;
%         imageIndex = imageIndex1;
%     case 2
%         queryImgWords = queryImgWords2;
%         imageIndex = imageIndex2;
%     otherwise
%         queryImgWords = queryImgWords3;
%         imageIndex = imageIndex3;
% end

foundImg = imread(char(foundImgPath));
foundImgWords = imageIndex.ImageWords(imgID);

% show image
f = figure;
set(f, 'units','normalized','outerposition',[0 0 1 1]);
tentativeMatches = getTentativeMatches(queryImgWords, foundImgWords);
queryImageMatchedPoints = queryImgWords.Location(tentativeMatches(:,1),:);
foundImageMatchesPoints = foundImgWords.Location(tentativeMatches(:,2),:);
% remove poor visual words using estimateGeometricTransform function
%[tform,queryImageMatchedPoints,foundImageMatchesPoints] = estimateGeometricTransform(queryImageMatchedPoints,foundImageMatchesPoints,'affine', 'MaxNumTrials',50);
%[tform,queryImageMatchedPoints,foundImageMatchesPoints] = estimateGeometricTransform(queryImageMatchedPoints,foundImageMatchesPoints,'affine');
showMatchedFeatures(queryImg,foundImg,queryImageMatchedPoints,foundImageMatchesPoints,'montage');

% Show text
title(foundImgPath);
str2Show = [' - Score: ', num2str(score)];
xlabel(str2Show);
end