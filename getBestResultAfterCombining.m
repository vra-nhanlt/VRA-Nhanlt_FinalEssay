function combinedResult = getBestResultAfterCombining(combinedResult)
% Calculate new score group by filename
combineResultCount = size (combinedResult, 1);
for (i = 1:(combineResultCount - 1))
    for (j = (i + 1):combineResultCount)
        if (strcmp(char(combinedResult(i, 1)), char(combinedResult(j, 1))))
            newScore = cell2mat(combinedResult(i, 3)) + cell2mat(combinedResult(j, 3));
            combinedResult(i, 3) =  num2cell(newScore);
            combinedResult(j, 3) = num2cell(0);
        end
    end
end

% Sort by score
for (i = 1:(combineResultCount - 1))
    for (j = (i + 1):combineResultCount)
         if (cell2mat(combinedResult(i, 3)) < cell2mat(combinedResult(j, 3)))
             tmp = combinedResult(i, :);
             combinedResult(i, :) = combinedResult(j, :);
             combinedResult(j, :) = tmp;
         end
    end
end
end

