function precisionAtK = calculatePrecisionAtK(combinedResult, category, k)
    rightResultCount = 0;
    % Calculate precison at k
    for (i = 1:k)
        foundImgPath = combinedResult(i, 1);
        if (contains(foundImgPath,category))
            rightResultCount = rightResultCount + 1;
        end
    end
    precisionAtK = rightResultCount/k;
end


