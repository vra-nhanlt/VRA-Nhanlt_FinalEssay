function tentativeMatches = getTentativeMatches(queryImageWords, foundImgeWords)
queryImageWordsIndex = queryImageWords.WordIndex;
foundImgeWordsIndex = foundImgeWords.WordIndex;

tentativeMatches = [];
for i = 1:numel(queryImageWordsIndex)
    
    idx = find(queryImageWordsIndex(i) == foundImgeWordsIndex);
    
    matches = [repmat(i, numel(idx), 1) idx];
    
    tentativeMatches = [tentativeMatches; matches];
    
end
end

