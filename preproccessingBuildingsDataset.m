function preproccessingBuildingsDataset()
% Preprocessing - pick up images that are not in RGB format
dir = './data/vnu/';
files = ls(dir);
filesCount = size(files, 1);
for (i=1:filesCount)
    filename = strtrim(string(files(i, :)));
    if (~(strcmp(filename, '.') || strcmp(filename, '..') || strcmp(filename, 'tiny_training')|| strcmp(filename, 'tmp')))
        filePath = strcat(dir, char(filename));
        try
            img = imread(filePath);
            img = rgb2gray(img);
        catch
            oldName = strcat(dir, char(filename));
            newName = strcat(dir, 'tmp/', char(filename));
            copyfile(oldName, newName);
        end
    end
end
end

