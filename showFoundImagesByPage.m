function showFoundImagesByPage(combinedResult, page)
    % set default width, height
    width = 190;
    height = 190;
    numOfImgsPerPage = 9;
    maxPage = 3;

    firstIndex = (page - 1) * numOfImgsPerPage;
    for (i = 1:numOfImgsPerPage)
        currentIndex = firstIndex + i;
        pbtn = findobj('Tag', strcat('pbtnFoundImg', int2str(i)));

        % attach data to axe
        imgPath = combinedResult(currentIndex, 1);
        imgPath = strrep(imgPath,"C:\FTP\Essay\","E:\Google Drive\Study\Nam 2016\Master\CD_NDTGVUD\Essay\");
        imgID = combinedResult(currentIndex, 2);
        score = combinedResult(currentIndex, 4);
        IRSystemID = combinedResult(currentIndex, 5);
        data = struct('imgPath', imgPath, 'imgID', imgID, 'score', score, 'IRSystemID', IRSystemID);
        set(pbtn, 'UserData',data);

        % show image
        [img] = imread(char(imgPath));
        showImageInPbtn(pbtn, img, width, height);
    end
    
    % Update pnPage
     txtPage = findobj('Tag', 'txtPage');
     set(txtPage, 'String', num2str(page));
     pbtnPre = findobj('Tag', 'pbtnPre');
     pbtnNext = findobj('Tag', 'pbtnNext');
     pbtnPre.Enable = 'on';
     pbtnNext.Enable = 'on';
     if (page == maxPage)
        pbtnNext.Enable = 'off';
     end
     if (page == 1)
        pbtnPre.Enable = 'off';
     end
end