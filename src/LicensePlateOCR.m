function varargout = LicensePlateOCR(varargin)
% LicensePlateOCR MATLAB code for LicensePlateOCR.fig
%      LicensePlateOCR, by itself, creates a new LicensePlateOCR or raises the existing
%      singleton*.
%
%      H = LicensePlateOCR returns the handle to a new LicensePlateOCR or the handle to
%      the existing singleton*.
%
%      LicensePlateOCR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LicensePlateOCR.M with the given input arguments.
%
%      LicensePlateOCR('Property','Value',...) creates a new LicensePlateOCR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LicensePlateOCR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LicensePlateOCR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LicensePlateOCR

% Last Modified by GUIDE v2.5 06-Jun-2023 20:58:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LicensePlateOCR_OpeningFcn, ...
                   'gui_OutputFcn',  @LicensePlateOCR_OutputFcn, ...
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


% --- Executes just before LicensePlateOCR is made visible.
function LicensePlateOCR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LicensePlateOCR (see VARARGIN)

% Choose default command line output for LicensePlateOCR
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LicensePlateOCR wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LicensePlateOCR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Ucitaj.
function Ucitaj_Callback(hObject, eventdata, handles)
    
    slika = uigetfile({'*.jpg*';'*.png*';'*.tif*'}); % ucitavanje slike
    slika = imread(slika);
    set(handles.radiobutton5, 'Value', 1);
    set(handles.radiobutton6, 'Value', 0);
    set(handles.radiobutton7, 'Value', 0);
    slika = imsharpen(slika);

    axes(handles.axes1);
    imshow(slika);
    impixelinfo
    whos slika
    setappdata(0,'slika',slika)
    axis off
    
% hObject    handle to Ucitaj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)

    set(handles.radiobutton6, 'Value', 0);
    set(handles.radiobutton7, 'Value', 0);
    slika = getappdata(0,'slika');
    axes(handles.axes1);
    imshow(slika);
    impixelinfo
    whos slika
    setappdata(0,'slika',slika)
    axis off

% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)

   set(handles.radiobutton5, 'Value', 0);
   set(handles.radiobutton7, 'Value', 0);
   slika = getappdata(0,'slika');
   monohromatska = rgb2gray(slika); % obrada u monohromatsku
   monohromatska = imsharpen(monohromatska);
   axes(handles.axes1);
   imshow(monohromatska);
   impixelinfo
   whos monohromatska
   setappdata(0,'monohromatska',monohromatska)
   axis off

% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6


% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)

   set(handles.radiobutton5, 'Value', 0);
   set(handles.radiobutton6, 'Value', 0);
   slika = getappdata(0,'slika');
   monohromatska = getappdata(0,'monohromatska'); 
   bin = im2bw(monohromatska);
   axes(handles.axes1);
   imshow(bin);
   impixelinfo
   whos bin
   setappdata(0,'bin',bin)
   axis off
    

% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton7


% --- Executes on button press in Detektuj.
function Detektuj_Callback(hObject, eventdata, handles)
    slika = getappdata(0,'slika');
    binarna = getappdata(0,'binarna');
    monohromatska = getappdata(0,'monohromatska');

    slika1 = getimage(handles.axes1);

    slika1 = binarna;

    whiteCountPerRow = sum(slika1,2);
    regions = whiteCountPerRow > 110;
    regions = [0; regions; 0];
    %plot(diff(regions))
    startIdx = find(diff(regions)==1);
    endIdx = find(diff(regions)==-1);
    if endIdx(end) > size(slika1,1)
        endIdx(end) = size(slika1,1);
    end

    [~,widestRegionIdx] = max(endIdx-startIdx);
    upperLimitROI = startIdx(widestRegionIdx);
    lowerLimitROI = endIdx(widestRegionIdx);
    licensNumberROI = slika1(upperLimitROI:lowerLimitROI,:);
    imshow(licensNumberROI)
    
    regioni = regionprops(licensNumberROI, 'BoundingBox');
    broj_regiona = numel(regioni);
    detektovani = "";
    

    for i = 1:broj_regiona
        if regioni(i).BoundingBox(3)>50 && regioni(i).BoundingBox(4)>=50
            rectangle('Position', regioni(i).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 2);
            tekst = ocr(licensNumberROI, regioni(i).BoundingBox);
            detektovani = [detektovani,string(tekst.Text)];
            detektovani = regexprep(detektovani, '^[A-Za-z0-9 ]+$', '');
            prikaz_teksta = join(detektovani);
            set(handles.detektovantekst,'String',prikaz_teksta);
            drawnow();
        end
    end
      

% hObject    handle to Detektuj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in obrada.
function obrada_Callback(hObject, eventdata, handles)

   slika = getappdata(0,'slika');

    if size(slika, 3) == 3
        slika = rgb2gray(slika);
    end

    % Računanje histograma slike
    histogram = imhist(slika);

    % Normalizacija histograma
    normalizovaniHist = histogram / sum(histogram);

    % Inicijalizacija varijabli
    ukupnaSuma = 0;
    ukupnaTezina = 0;
    ukupnaVelicina = numel(slika);
    maksimalnaVarianca = 0;
    prag = 0;

    % Računanje ukupne suma i težine
    for i = 1:numel(normalizovaniHist)
        ukupnaSuma = ukupnaSuma + i * normalizovaniHist(i);
        ukupnaTezina = ukupnaTezina + normalizovaniHist(i);
    end

    % Računanje varijance i pronalaženje optimalnog praga
    for i = 1:numel(normalizovaniHist)
        tezina1 = sum(normalizovaniHist(1:i));
        tezina2 = 1 - tezina1;
        if tezina1 == 0 || tezina2 == 0
            continue;
        end
        suma1 = sum((0:i-1)'.*normalizovaniHist(1:i)) / tezina1;
        suma2 = (ukupnaSuma - suma1 * tezina1) / tezina2;
        varianca = tezina1 * tezina2 * (suma1 - suma2)^2;
        if varianca > maksimalnaVarianca
            maksimalnaVarianca = varianca;
            prag = i-1;
        end
    end

   % Binarizacija slike
   binarna = imbinarize(slika, prag / 255);
   %binarna=~binarna;
   axes(handles.axes1);
   imshow(binarna);
   impixelinfo
   whos binarna
   setappdata(0,'binarna',binarna)
   axis off
% hObject    handle to obrada (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
