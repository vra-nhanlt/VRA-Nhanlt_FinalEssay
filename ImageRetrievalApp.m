function varargout = ImageRetrievalApp(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageRetrievalApp_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageRetrievalApp_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ImageRetrievalApp is made visible.
function ImageRetrievalApp_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for ImageRetrievalApp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% init global variables and load data
global inputDataFlowers;
global inputDataBuildings;
global inputData;
global savedImgsIndex;
global savedImgsIndex2;
global savedImgsIndex3;
global savedImgsIndexFlowers;
global savedImgsIndex2Flowers;
global savedImgsIndex3Flowers;
global savedImgsIndexBuildings;
global savedImgsIndex2Buildings;
global savedImgsIndex3Buildings;
global savedBagOfVisualWords;
global savedBagOfVisualWords2;
global savedBagOfVisualWords3;
global savedBagOfVisualWordsFlowers;
global savedBagOfVisualWords2Flowers;
global savedBagOfVisualWords3Flowers;
global savedBagOfVisualWordsBuildings;
global savedBagOfVisualWords2Buildings;
global savedBagOfVisualWords3Buildings;
global imgSize; 
global imgsIndex;
global imgsIndex2;
global imgsIndex3;
global categoriesFlowers;
global categoriesBuildings;
global selectiveCategories;
global categoriesFolder;
global categoriesFolderFlowers;
global categoriesFolderBuildings;
categoriesFolderFlowers = './resources/categoriesFlowers';
categoriesFolderBuildings = './resources/categoriesBuildings';
inputDataFlowers = './data/flowers/training';
inputDataBuildings = './data/vnu/training';
savedImgsIndexFlowers = './data/saved_data/imgsIndex_training_flowers_Color_1000';
savedImgsIndex2Flowers = './data/saved_data/imgsIndex_training_flowers_Color_500';
savedImgsIndex3Flowers = './data/saved_data/imgsIndex_training_flowers_MinEigen_SURF_500';
savedImgsIndexBuildings = './data/saved_data/imgsIndex_training_vnu_FAST_HoG_500';
savedImgsIndex2Buildings = './data/saved_data/imgsIndex_training_vnu_SURF_SURF_1000';
savedImgsIndex3Buildings = './data/saved_data/imgsIndex_training_vnu_SURF_500';
savedBagOfVisualWordsFlowers = './data/saved_data/bagOfVisualWords_training_flowers_Color_1000';
savedBagOfVisualWords2Flowers ='./data/saved_data/bagOfVisualWords_training_flowers_Color_500';
savedBagOfVisualWords3Flowers = './data/saved_data/bagOfVisualWords_training_flowers_MinEigen_SURF_500';
savedBagOfVisualWordsBuildings = './data/saved_data/bagOfVisualWords_training_vnu_FAST_HoG_500';
savedBagOfVisualWords2Buildings ='./data/saved_data/bagOfVisualWords_training_vnu_SURF_SURF_1000';
savedBagOfVisualWords3Buildings = './data/saved_data/bagOfVisualWords_training_vnu_SURF_500';

% Init categories for the topic: Flowers (consists of 102 categories)
labelsCount = 102;
for (i=1:labelsCount)
    categoriesFlowers{1, i} = strcat('label_', num2str(i));
end

% Init categories for the topic Buildings
categoriesBuildings = {'cfnde';'hostel';'uit';'uel';'ut';'us';'iu';'ussh';'vnu_hqt'};

% Default selective topic is Buildings
inputData = inputDataBuildings;
savedImgsIndex = savedImgsIndexBuildings;
savedImgsIndex2 = savedImgsIndex2Buildings;
savedImgsIndex3 = savedImgsIndex3Buildings;
savedBagOfVisualWords = savedBagOfVisualWordsBuildings;
savedBagOfVisualWords2 = savedBagOfVisualWords2Buildings;
savedBagOfVisualWords3 = savedBagOfVisualWords3Buildings;
selectiveCategories = categoriesBuildings;
categoriesFolder = categoriesFolderBuildings;

% Set default image size is 400px
imgSize = 400;

% Load index images
[imgsIndex, imgsIndex2, imgsIndex3] = loadIndexImges('Buildings', inputData, savedBagOfVisualWords, savedImgsIndex, savedBagOfVisualWords2, savedImgsIndex2, savedBagOfVisualWords3, savedImgsIndex3);

% Show default image (image icon) in axeImg
[img]=imread('./resources/icOpenImage.jpg');
showImageInAxe(handles.axeImg, img, imgSize, imgSize);

% init data for pmnExpectantCategory
set(handles.pmnExpectantCategory,'String', selectiveCategories, 'Value', 1); 

% --- Outputs from this function are returned to the command line.
function varargout = ImageRetrievalApp_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pbtnBrowse.
function pbtnBrowse_Callback(hObject, eventdata, handles)
global imgSize; 
selectAnImage(handles.axeImg, imgSize);
% Backup cdata
global originalImg;
originalImg = getimage(handles.axeImg);
% Enable select an area for cropping
global selectedArea;
selectedArea = {};
selectedArea = imrect;

% --- Executes on button press in pbtnCrop.
function pbtnCrop_Callback(hObject, eventdata, handles)
global selectedArea;
global imgSize; 
% Check if user has selected an area in the image or not
if (~isempty(selectedArea))
    selectedPosition = getPosition(selectedArea);
    img = getimage(handles.axeImg);
    img = imcrop(img, [selectedPosition(1) selectedPosition(2) selectedPosition(3) selectedPosition(4)]);
    showImageInAxe(handles.axeImg, img, imgSize, imgSize);
    
    % Enable selecting an area for cropping again
    selectedArea = {};
    selectedArea = imrect;
end

% --- Executes on button press in pbtnReset.
function pbtnReset_Callback(hObject, eventdata, handles)
% Show originalImg
global imgSize; 
global originalImg;
global selectedArea;
showImageInAxe(handles.axeImg, originalImg, imgSize, imgSize);
% Enable select an area for cropping
selectedArea = {};
selectedArea = imrect;

% --- Executes on button press in pbtnSearch.
function pbtnSearch_Callback(hObject, eventdata, handles)
global imgsIndex;
global queryImgWords;
global foundImgIDs;
global scores;
global imgsIndex2;
global queryImgWords2;
global foundImgIDs2;
global scores2;
global imgsIndex3;
global queryImgWords3;
global foundImgIDs3;
global scores3;
global combinedResult;
global selectiveCategories;
global currentPage;
% Show panel Waiting
handles.pnWaiting.Visible = 'on';
drawnow; 
waitingBar = waitbar(0,'Searching. Please wait...');
% Get data of the image to query
global queryImgCdata;
numOfResults = 30;
queryImgCdata = getimage(handles.axeImg);
% Retrieve images using the first IR system
[foundImgIDs, scores, queryImgWords] = retrieveImages(queryImgCdata, imgsIndex, 'NumResults', numOfResults);
% Retrieve images using the second IR system
[foundImgIDs2, scores2, queryImgWords2] = retrieveImages(queryImgCdata, imgsIndex2, 'NumResults', numOfResults);
% Retrieve images using the second IR system
[foundImgIDs3, scores3, queryImgWords3] = retrieveImages(queryImgCdata, imgsIndex3, 'NumResults', numOfResults);
% Combine result from 3 systems
waitbar(0.3, waitingBar,'Combining result from 3 IR systems');
combinedResult = {};
combinedResult = combineResult(combinedResult, imgsIndex, foundImgIDs, scores, 1, 1);
combinedResult = combineResult(combinedResult, imgsIndex2, foundImgIDs2, scores2, 2, 1);
combinedResult = combineResult(combinedResult, imgsIndex3, foundImgIDs3, scores3, 3, 1);
% Get the best result after combining (sort by score)
combinedResult = getBestResultAfterCombining(combinedResult);
% predict Category
[indexOfCategory, predictiveCategory] = predictCategory(selectiveCategories, combinedResult);
set(handles.txtPredictiveCategory, 'String', strcat({'Predictive Category:'}, {' '}, predictiveCategory));
% select expectant category automatically for evaluating the result
set(handles.pmnExpectantCategory, 'Value', indexOfCategory);
pmnExpectantCategory_Callback(handles.pmnExpectantCategory, eventdata, handles);
% Show found images per page
waitbar(0.7, waitingBar,'Showing result. Just a few seconds');
currentPage = 1;
showFoundImagesByPage(combinedResult, currentPage);
% Show panel Page
handles.pnPage.Visible = 'on';
% Hide panel Waiting
handles.pnWaiting.Visible = 'off';
close(waitingBar);
% Show panel Evaluation
handles.pnEvaluation.Visible = 'on';

% --- Executes on selection change in pmnExpectantCategory.
function pmnExpectantCategory_Callback(hObject, eventdata, handles)
global combinedResult;
% Get selected Category
allItems = get(handles.pmnExpectantCategory,'string');
selectedIndex = get(handles.pmnExpectantCategory,'Value');
category = allItems{selectedIndex};
% Calculate precision at k (k = 27, the number of imgs could be shown in
% the 3 first pages
k = 27;
precisionAtK = calculatePrecisionAtK(combinedResult, category, k);
set(handles.txtResult, 'String', strcat('Precision at k (k =', num2str(k), {'): '}, num2str(precisionAtK*100), '%'));
% Show txt Precision@K
handles.txtResult.Visible = 'on';

% --- Executes during object creation, after setting all properties.
function pmnExpectantCategory_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pbtnPre.
function pbtnPre_Callback(hObject, eventdata, handles)
global currentPage;
global combinedResult;
if (currentPage > 1)
    waitingBar = waitbar(0.5,'Please wait...');
    currentPage = currentPage - 1;
    showFoundImagesByPage(combinedResult, currentPage);
    close(waitingBar);
end

% --- Executes on button press in pbtnNext.
function pbtnNext_Callback(hObject, eventdata, handles)
global currentPage;
global combinedResult;
if (currentPage < 3)
    waitingBar = waitbar(0.5,'Please wait...');
    currentPage = currentPage + 1;
    showFoundImagesByPage(combinedResult, currentPage);
    close(waitingBar);
end

% --- Executes on button press in pbtnFoundImg1.
function pbtnFoundImg1_Callback(hObject, eventdata, handles)
global imgsIndex;
global queryImgWords;
global imgsIndex2;
global queryImgWords2;
global imgsIndex3;
global queryImgWords3;
global queryImgCdata;
showFoundImageInDetail(handles.pbtnFoundImg1, queryImgCdata, queryImgWords, imgsIndex, queryImgWords2, imgsIndex2, queryImgWords3, imgsIndex3);

% --- Executes on button press in pbtnFoundImg2.
function pbtnFoundImg2_Callback(hObject, eventdata, handles)
global imgsIndex;
global queryImgWords;
global imgsIndex2;
global queryImgWords2;
global imgsIndex3;
global queryImgWords3;
global queryImgCdata;
showFoundImageInDetail(handles.pbtnFoundImg2, queryImgCdata, queryImgWords, imgsIndex, queryImgWords2, imgsIndex2, queryImgWords3, imgsIndex3);

% --- Executes on button press in pbtnFoundImg3.
function pbtnFoundImg3_Callback(hObject, eventdata, handles)
global imgsIndex;
global queryImgWords;
global imgsIndex2;
global queryImgWords2;
global imgsIndex3;
global queryImgWords3;
global queryImgCdata;
showFoundImageInDetail(handles.pbtnFoundImg3, queryImgCdata, queryImgWords, imgsIndex, queryImgWords2, imgsIndex2, queryImgWords3, imgsIndex3);

% --- Executes on button press in pbtnFoundImg4.
function pbtnFoundImg4_Callback(hObject, eventdata, handles)
global imgsIndex;
global queryImgWords;
global imgsIndex2;
global queryImgWords2;
global imgsIndex3;
global queryImgWords3;
global queryImgCdata;
showFoundImageInDetail(handles.pbtnFoundImg4, queryImgCdata, queryImgWords, imgsIndex, queryImgWords2, imgsIndex2, queryImgWords3, imgsIndex3);

% --- Executes on button press in pbtnFoundImg5.
function pbtnFoundImg5_Callback(hObject, eventdata, handles)
global imgsIndex;
global queryImgWords;
global imgsIndex2;
global queryImgWords2;
global imgsIndex3;
global queryImgWords3;
global queryImgCdata;
showFoundImageInDetail(handles.pbtnFoundImg5, queryImgCdata, queryImgWords, imgsIndex, queryImgWords2, imgsIndex2, queryImgWords3, imgsIndex3);

% --- Executes on button press in pbtnFoundImg6.
function pbtnFoundImg6_Callback(hObject, eventdata, handles)
global imgsIndex;
global queryImgWords;
global imgsIndex2;
global queryImgWords2;
global imgsIndex3;
global queryImgWords3;
global queryImgCdata;
showFoundImageInDetail(handles.pbtnFoundImg6, queryImgCdata, queryImgWords, imgsIndex, queryImgWords2, imgsIndex2, queryImgWords3, imgsIndex3);

% --- Executes on button press in pbtnFoundImg7.
function pbtnFoundImg7_Callback(hObject, eventdata, handles)
global imgsIndex;
global queryImgWords;
global imgsIndex2;
global queryImgWords2;
global imgsIndex3;
global queryImgWords3;
global queryImgCdata;
showFoundImageInDetail(handles.pbtnFoundImg7, queryImgCdata, queryImgWords, imgsIndex, queryImgWords2, imgsIndex2, queryImgWords3, imgsIndex3);

% --- Executes on button press in pbtnFoundImg8.
function pbtnFoundImg8_Callback(hObject, eventdata, handles)
global imgsIndex;
global queryImgWords;
global imgsIndex2;
global queryImgWords2;
global imgsIndex3;
global queryImgWords3;
global queryImgCdata;
showFoundImageInDetail(handles.pbtnFoundImg8, queryImgCdata, queryImgWords, imgsIndex, queryImgWords2, imgsIndex2, queryImgWords3, imgsIndex3);

% --- Executes on button press in pbtnFoundImg9.
function pbtnFoundImg9_Callback(hObject, eventdata, handles)
global imgsIndex;
global queryImgWords;
global imgsIndex2;
global queryImgWords2;
global imgsIndex3;
global queryImgWords3;
global queryImgCdata;
showFoundImageInDetail(handles.pbtnFoundImg9, queryImgCdata, queryImgWords, imgsIndex, queryImgWords2, imgsIndex2, queryImgWords3, imgsIndex3);

% --- Executes on button press in pbtnIndexNewImgs.
function pbtnIndexNewImgs_Callback(hObject, eventdata, handles)
global imgsIndex;
global imgsIndex2;
global imgsIndex3;
global savedImgsIndex;
global savedImgsIndex2;
global savedImgsIndex3;
[imgsIndex, imgsIndex2, imgsIndex3] = addNewImagesToImgIndex(imgsIndex, imgsIndex2, imgsIndex3, savedImgsIndex, savedImgsIndex2, savedImgsIndex3);

% --- Executes on selection change in pmTopic.
function pmTopic_Callback(hObject, eventdata, handles)
global categoriesFlowers;
global categoriesBuildings;
global selectiveCategories;
global categoriesFolder;
global categoriesFolderFlowers;
global categoriesFolderBuildings;
global inputDataFlowers;
global inputDataBuildings;
global inputData;
global savedImgsIndex;
global savedImgsIndex2;
global savedImgsIndex3;
global savedImgsIndexFlowers;
global savedImgsIndex2Flowers;
global savedImgsIndex3Flowers;
global savedImgsIndexBuildings;
global savedImgsIndex2Buildings;
global savedImgsIndex3Buildings;
global savedBagOfVisualWords;
global savedBagOfVisualWords2;
global savedBagOfVisualWords3;
global savedBagOfVisualWordsFlowers;
global savedBagOfVisualWords2Flowers;
global savedBagOfVisualWords3Flowers;
global savedBagOfVisualWordsBuildings;
global savedBagOfVisualWords2Buildings;
global savedBagOfVisualWords3Buildings;
global imgsIndex;
global imgsIndex2;
global imgsIndex3;
% Get selected Category
allItems = get(handles.pmTopic,'string');
selectedIndex = get(handles.pmTopic,'Value');
topic = allItems{selectedIndex};
% change values follows the selected topic
switch topic
    case 'Flowers'
        selectiveCategories = categoriesFlowers;
        categoriesFolder = categoriesFolderFlowers;
        inputData = inputDataFlowers;
        savedBagOfVisualWords = savedBagOfVisualWordsFlowers;
        savedBagOfVisualWords2 = savedBagOfVisualWords2Flowers;
        savedBagOfVisualWords3 = savedBagOfVisualWords3Flowers;
        savedImgsIndex = savedImgsIndexFlowers;
        savedImgsIndex2 = savedImgsIndex2Flowers;
        savedImgsIndex3 = savedImgsIndex3Flowers;
        [imgsIndex, imgsIndex2, imgsIndex3] = loadIndexImges('Flowers', inputData, savedBagOfVisualWords, savedImgsIndex, savedBagOfVisualWords2, savedImgsIndex2, savedBagOfVisualWords3, savedImgsIndex3);
    otherwise
        selectiveCategories = categoriesBuildings;
        categoriesFolder = categoriesFolderBuildings;
        inputData = inputDataBuildings;
        savedBagOfVisualWords = savedBagOfVisualWordsBuildings;
        savedBagOfVisualWords2 = savedBagOfVisualWords2Buildings;
        savedBagOfVisualWords3 = savedBagOfVisualWords3Buildings;
        savedImgsIndex = savedImgsIndexBuildings;
        savedImgsIndex2 = savedImgsIndex2Buildings;
        savedImgsIndex3 = savedImgsIndex3Buildings;
        [imgsIndex, imgsIndex2, imgsIndex3] = loadIndexImges('Buildings', inputData, savedBagOfVisualWords, savedImgsIndex, savedBagOfVisualWords2, savedImgsIndex2, savedBagOfVisualWords3, savedImgsIndex3);
end

% init data for pmnExpectantCategory
set(handles.pmnExpectantCategory,'String', selectiveCategories, 'Value', 1); 


% --- Executes during object creation, after setting all properties.
function pmTopic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pmTopic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ptbnCategoryDetails.
function ptbnCategoryDetails_Callback(hObject, eventdata, handles)
global categoriesFolder;
% open folder that contains example images each category
winopen(categoriesFolder);
