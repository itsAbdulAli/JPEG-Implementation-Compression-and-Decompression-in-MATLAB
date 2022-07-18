%DIP PROJECT JPEG IMPLEMENTATION
%19L-0917 ABDUL ALI BCS 6A
%19L-0949 ABDUL BASIT BCS 6A
%19L-0951 AHMAD NASIR BCS 6A


function varargout = DIP_Project_19L0917_19L0949_19L0951_figure(varargin)
% DIP_PROJECT_19L0917_19L0949_19L0951_FIGURE MATLAB code for DIP_Project_19L0917_19L0949_19L0951_figure.fig
%      DIP_PROJECT_19L0917_19L0949_19L0951_FIGURE, by itself, creates a new DIP_PROJECT_19L0917_19L0949_19L0951_FIGURE or raises the existing
%      singleton*.
%
%      H = DIP_PROJECT_19L0917_19L0949_19L0951_FIGURE returns the handle to a new DIP_PROJECT_19L0917_19L0949_19L0951_FIGURE or the handle to
%      the existing singleton*.
%
%      DIP_PROJECT_19L0917_19L0949_19L0951_FIGURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIP_PROJECT_19L0917_19L0949_19L0951_FIGURE.M with the given input arguments.
%
%      DIP_PROJECT_19L0917_19L0949_19L0951_FIGURE('Property','Value',...) creates a new DIP_PROJECT_19L0917_19L0949_19L0951_FIGURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DIP_Project_19L0917_19L0949_19L0951_figure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DIP_Project_19L0917_19L0949_19L0951_figure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DIP_Project_19L0917_19L0949_19L0951_figure

% Last Modified by GUIDE v2.5 29-May-2022 12:21:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DIP_Project_19L0917_19L0949_19L0951_figure_OpeningFcn, ...
                   'gui_OutputFcn',  @DIP_Project_19L0917_19L0949_19L0951_figure_OutputFcn, ...
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


% --- Executes just before DIP_Project_19L0917_19L0949_19L0951_figure is made visible.
function DIP_Project_19L0917_19L0949_19L0951_figure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DIP_Project_19L0917_19L0949_19L0951_figure (see VARARGIN)

% Choose default command line output for DIP_Project_19L0917_19L0949_19L0951_figure
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DIP_Project_19L0917_19L0949_19L0951_figure wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DIP_Project_19L0917_19L0949_19L0951_figure_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
[file,path] = uigetfile({'*.*'},'File Selector');
imagePath = strcat(path,file);
I=imread(imagePath);
[m, n, z] = size(I);
if z > 1
    I=rgb2gray(I);
end
axes(handles.axes1);
imshow(I);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = get(handles.edit1,'String');
if isempty(str2num(x))
   alert = warndlg('Error: Enter Numeric Value','Alert');
else
    
    QualityReq=str2num(x);
    if (QualityReq >= 1 && QualityReq<=97)
        I=getimage(handles.axes1);
        Image=I;
        [row,col]=size(Image);  %storing size of image

        rows_notin8x8 = rem(row,8);
        row = row-rows_notin8x8;
        cols_notin8x8 = rem(col,8);
        col= col-cols_notin8x8;

        Image = imresize(Image,[row col]); % dropping the rows and cols that are not in 8x8
        Image = double(Image);


        OriginalImage = Image;

        QualityMatrix = [ 16 11 10 16 24 40 51 61;
             12 12 14 19 26 58 60 55;
             14 13 16 24 40 57 69 56;
             14 17 22 29 51 87 80 62; 
             18 22 37 56 68 109 103 77;
             24 35 55 64 81 104 113 92;
             49 64 78 87 103 121 120 101;
             72 92 95 98 112 100 103 99];
        QualityMatrix = double(QualityMatrix);

        if QualityReq > 50
             Factor = (ones(8)*((100-QualityReq)/50));
             QualityMatrix = round(QualityMatrix.*Factor);
             QualityMatrix = double(QualityMatrix);
        elseif QualityReq < 50
             Factor = (ones(8)*(50/QualityReq));
             QualityMatrix = round(QualityMatrix.*Factor);
             QualityMatrix = double(QualityMatrix);
        end

        %step 1: (Level Shift around 0) Subtract 128
        Image = Image - 128;
        
        

        %step 2: 8x8 blocks
        for rows=[1:8:row]            
            for cols=[1:8:col]
                %step 3: DCT2 Transform
                Image(rows:rows+7,cols:cols+7) = dct2(Image(rows:rows+7,cols:cols+7));
            end
        end

        for rows=[1:8:row]
            for cols=[1:8:col]
                %step 4: Normalization/Quantization
                window=Image(rows:rows+7,cols:cols+7);
                Image(rows:rows+7,cols:cols+7) = round(window./QualityMatrix);
            end
        end

        axes(handles.axes4);
        imshow(Image);

        %step 5: Huffman Encoding
        ImagetobeCoded=double(Image(:));
        [frequency,representation]=hist(ImagetobeCoded,unique(ImagetobeCoded));
        probability=frequency/sum(frequency);
        dict = huffmandict(representation,probability); 
        huffmanEncoded = huffmanenco(ImagetobeCoded,dict);

        %step 6: Huffman Decoded
        huffmanDecoded = huffmandeco(huffmanEncoded,dict);
        Image=reshape(huffmanDecoded,[row col]);


        for rows=[1:8:row]
            for cols=[1:8:col]
                %step 7: Inverse Normalization/Quantization
                Image(rows:rows+7,cols:cols+7) = (Image(rows:rows+7,cols:cols+7).*QualityMatrix);
            end
        end

        for rows=[1:8:row]
            for cols=[1:8:col]
                %step 8: Inverse DCT2 Transformation
                Image(rows:rows+7,cols:cols+7) = idct2(Image(rows:rows+7,cols:cols+7));
            end
        end

        %SizeUncompressed=numel(Image);

        %step 9: Inverse Level Shift from 0 by Adding 128
        Image = Image + 128;



        Final = mat2gray(Image);
        axes(handles.axes5);
        imshow(Final);

        axes(handles.axes6);
        imshow(OriginalImage-Image)
        clc;
        clear all;
    else
        alert = warndlg('Error: Numeric Value range (1-97)\n','Alert');
    end

end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=getimage(handles.axes4);
imwrite(I,'DCT_SignalImage.tif')




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=getimage(handles.axes5);
imwrite(I,'DecompressedImage.tif')
