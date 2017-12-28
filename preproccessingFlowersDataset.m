function preproccessingFlowersDataset()
 load('./data/Flowers/imagelabels.mat');
 labelsCount=size(labels,2);
 currentLabelCount = zeros([1 labelsCount]);

% rename images to the corresponding labels
for (i=1:labelsCount)
    currentLabel = labels(i);
    currentLabelCount(currentLabel) = currentLabelCount(currentLabel) + 1;
    % rename files to label of images
    oldName = strcat('./data/flowers/flowers/', 'image_', sprintf('%05d',i),'.jpg');
    newName = strcat('./data/flowers/flowers/', 'label_',num2str(currentLabel),'_',num2str(currentLabelCount(currentLabel)),'.jpg');
    movefile(oldName, newName);
end

% % select testing images
totalLabels = 102;
for (i=1:totalLabels)
    testingCount = currentLabelCount(i)*2/10;
    for (j=1:testingCount)
        oldName = strcat('./data/flowers/flowers/', 'label_', num2str(i), '_', num2str(j),'.jpg');
        newName = strcat('./data/flowers/flowers/testing/', 'label_', num2str(i), '_', num2str(j),'.jpg');
        movefile(oldName, newName);
    end
end

% create category details folder
totalLabels = 102;
for (i=1:totalLabels)
    oldName = strcat('./data/flowers/flowers/testing/', 'label_', num2str(i), '_1.jpg');
    newName = strcat('./resources/categoriesFlowers/', 'label_', num2str(i), '.jpg');
    copyfile(oldName, newName);
end
end

