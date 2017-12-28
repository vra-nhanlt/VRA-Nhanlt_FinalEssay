function [indexOfCategory, predictiveCategory] = predictCategory(selectiveCategories, combinedResult)
maxResultCount = 27;
% count result group by category
numOfCategories = length(selectiveCategories);
resultCountGroupByCategory = zeros([1 numOfCategories]);
for (i=1:maxResultCount)
    for(j=1:numOfCategories)
        if (contains(combinedResult(i,1), selectiveCategories(j)))
            resultCountGroupByCategory(j) = resultCountGroupByCategory(j) + 1;
            break;
        end
    end
end

% find the position (index) of the category that founds the most number of result
indexMax = 1;
for (i=1:numOfCategories)
    if (resultCountGroupByCategory(i)>resultCountGroupByCategory(indexMax))
        indexMax = i;
    end
end

% return the category that founds the most number of result
predictiveCategory = selectiveCategories(indexMax);
indexOfCategory = indexMax;
end

