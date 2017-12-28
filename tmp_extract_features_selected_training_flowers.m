inputData = './data/flowers/training';
savedImgsIndex= './data/saved_data/imgsIndex_training_flowers_Color_1000';
savedImgsIndex2 = './data/saved_data/imgsIndex_training_flowers_Color_500';
savedImgsIndex3 = './data/saved_data/imgsIndex_training_flowers_MinEigen_SURF_500';

% savedImgsIndex= './data/saved_data/imgsIndex_selected_training_flowers_FAST_SURF_500';
% savedImgsIndex2 = './data/saved_data/imgsIndex_selected_training_flowers_SURF_HoG_500';
% savedImgsIndex3 = './data/saved_data/imgsIndex_selected_training_flowers_MinEigen_SURF_500';
% savedImgsIndex4 = './data/saved_data/imgsIndex_selected_training_flowers_Grid_SURF_500';
% savedImgsIndex5 = './data/saved_data/imgsIndex_selected_training_flowers_Harris_SURF_500';
% savedImgsIndex6 = './data/saved_data/imgsIndex_selected_training_flowers_SURF_500';
% savedImgsIndex7 = './data/saved_data/imgsIndex_selected_training_flowers_FAST_HoG_500';
% savedImgsIndex8 = './data/saved_data/imgsIndex_selected_training_flowers_LBP_500';
% savedImgsIndex9 = './data/saved_data/imgsIndex_selected_training_flowers_Color_500';

savedBagOfVisualWords = './data/saved_data/bagOfVisualWords_training_flowers_Color_1000';
savedBagOfVisualWords2 ='./data/saved_data/bagOfVisualWords_training_flowers_Color_500';
savedBagOfVisualWords3 = './data/saved_data/bagOfVisualWords_training_flowers_MinEigen_SURF_500';

% savedBagOfVisualWords = './data/saved_data/bagOfVisualWords_selected_training_flowers_FAST_SURF_500';
% savedBagOfVisualWords2 ='./data/saved_data/bagOfVisualWords_selected_training_flowers_SURF_HoG_500';
% savedBagOfVisualWords3 = './data/saved_data/bagOfVisualWords_selected_training_flowers_MinEigen_SURF_500';
% savedBagOfVisualWords4 = './data/saved_data/bagOfVisualWords_selected_training_flowers_Grid_SURF_500';
% savedBagOfVisualWords5 = './data/saved_data/bagOfVisualWords_selected_training_flowers_Harris_SURF_500';
% savedBagOfVisualWords6 = './data/saved_data/bagOfVisualWords_selected_training_flowers_SURF_500';
% savedBagOfVisualWords7 = './data/saved_data/bagOfVisualWords_selected_training_flowers_FAST_HoG_500';
% savedBagOfVisualWords8 = './data/saved_data/bagOfVisualWords_selected_training_flowers_LBP_500';
% savedBagOfVisualWords9 = './data/saved_data/bagOfVisualWords_selected_training_flowers_Color_500';

vocabularySize = 1000;
loadDataAndIndex(inputData, savedBagOfVisualWords, savedImgsIndex, 'Color', vocabularySize);
vocabularySize = 500;
loadDataAndIndex(inputData, savedBagOfVisualWords2, savedImgsIndex2, 'Color', vocabularySize);
loadDataAndIndex(inputData, savedBagOfVisualWords3, savedImgsIndex3, 'MinEigen_SURF', vocabularySize);

% loadDataAndIndex(inputData, savedBagOfVisualWords, savedImgsIndex, 'FAST_SURF', vocabularySize);
% loadDataAndIndex(inputData, savedBagOfVisualWords2, savedImgsIndex2, 'SURF_HoG', vocabularySize);
% loadDataAndIndex(inputData, savedBagOfVisualWords3, savedImgsIndex3, 'MinEigen_SURF', vocabularySize);
% loadDataAndIndex(inputData, savedBagOfVisualWords4, savedImgsIndex4, 'Grid_SURF', vocabularySize);
% loadDataAndIndex(inputData, savedBagOfVisualWords5, savedImgsIndex5, 'Harris_SURF', vocabularySize);
% loadDataAndIndex(inputData, savedBagOfVisualWords6, savedImgsIndex6, 'SURF', vocabularySize);
% loadDataAndIndex(inputData, savedBagOfVisualWords7, savedImgsIndex7, 'FAST_HoG', vocabularySize);
% loadDataAndIndex(inputData, savedBagOfVisualWords8, savedImgsIndex8, 'LBP', vocabularySize);
% loadDataAndIndex(inputData, savedBagOfVisualWords9, savedImgsIndex9, 'Color', vocabularySize);