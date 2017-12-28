function combinedResult = combineResult(combinedResult, imageIndex, foundImgIDs, scores, IRSystemID, weight)
resultCount = size(foundImgIDs, 1);
currentResultCount = size(combinedResult, 1);

for (i = 1:resultCount)
    path = imageIndex.ImageLocation{foundImgIDs(i)};
    combinedResult{currentResultCount + i, 1} = path;
    combinedResult{currentResultCount + i, 2} = foundImgIDs(i);
    combinedResult{currentResultCount + i, 3} = scores(i)*weight;
    combinedResult{currentResultCount + i, 4} =  scores(i);
    combinedResult{currentResultCount + i, 5} = IRSystemID;
end
end

