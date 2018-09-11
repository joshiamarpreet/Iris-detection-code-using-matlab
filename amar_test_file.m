function varargout = amar_test_file(varargin)
% AMAR_TEST_FILE MATLAB code for amar_test_file.fig
%      AMAR_TEST_FILE, by itself, creates a new AMAR_TEST_FILE or raises the existing
%      singleton*.
%
%      H = AMAR_TEST_FILE returns the handle to a new AMAR_TEST_FILE or the handle to
%      the existing singleton*.
%
%      AMAR_TEST_FILE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AMAR_TEST_FILE.M with the given input arguments.
%
%      AMAR_TEST_FILE('Property','Value',...) creates a new AMAR_TEST_FILE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before amar_test_file_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to amar_test_file_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help amar_test_file

% Last Modified by GUIDE v2.5 20-Aug-2018 18:10:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @amar_test_file_OpeningFcn, ...
                   'gui_OutputFcn',  @amar_test_file_OutputFcn, ...
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


% --- Executes just before amar_test_file is made visible.
function amar_test_file_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to amar_test_file (see VARARGIN)

% Choose default command line output for amar_test_file
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes amar_test_file wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = amar_test_file_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in webcam.
function webcam_Callback(hObject, eventdata, handles)
% hObject    handle to webcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
add=get(handles.ipadd,'string');
disp(add)
st=strcat('http://',add,':8080/shot.jpg');
img=imread(st);
img=rgb2gray(img);
setappdata(handles.figure1,'IrisImg1',img);
axes(handles.axes2);
imshow(img)


% --- Executes on button press in manual.
function manual_Callback(hObject, eventdata, handles)
% hObject    handle to manual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% [filename, pathname]=uigetfile('*.*','Choose an iris image');
% fig=imread(strcat(pathname,filename));
% setappdata(handles.figure1,'IrisImg2',fig);
% axes(handles.axes2);
% imshow(fig);
add=get(handles.ipadd,'string');
disp(add)
st=strcat('http://',add,':8080/shot.jpg');
img=imread(st);
img=rgb2gray(img);
setappdata(handles.figure1,'IrisImg2',img);
axes(handles.axes1);
imshow(img)

% --- Executes on button press in temp1.
function temp1_Callback(hObject, eventdata, handles)
% hObject    handle to temp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eye=getappdata(handles.figure1,'IrisImg1');
[local xc yc time]=localisation2(eye,0.2);
[ci cp out time]=thresh(local,50,200);
[ring,parr]=normaliseiris(local,ci(2),ci(1),ci(3),cp(2),cp(1),cp(3),'normal.bmp',100,300);
[temp th tv]=gen_templateVVV(parr);
setappdata(handles.figure1,'temp1',temp);
axes(handles.axes3);
imshow(temp)

% --- Executes on button press in temp2.
function temp2_Callback(hObject, eventdata, handles)
% hObject    handle to temp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

eye=getappdata(handles.figure1,'IrisImg2');
[local xc yc time]=localisation2(eye,0.2);
[ci cp out time]=thresh(local,50,200);
[ring,parr]=normaliseiris(local,ci(2),ci(1),ci(3),cp(2),cp(1),cp(3),'normal.bmp',100,300);
[temp2 th tv]=gen_templateVVV(parr);
axes(handles.axes4);
imshow(temp2);
temp1=getappdata(handles.figure1,'temp1');
hd=hammingdist(temp1, temp2);
% set(handles.Result,'Visible','on');
% set(handles.HammingVal,'Visible','on');
% set(handles.HammingVal,'String',hd);
if(hd<=0.5)
      set(handles.tv,'string','match success ');
%     set(handles.HammingDist,'Visible','on');
%     set(handles.Success,'Visible','on');
%     set(handles.Fail,'Visible','off');

else
    set(handles.tv,'string','match failed ');
%     set(handles.HammingDist,'Visible','on');
%     set(handles.Fail,'Visible','on');
%     set(handles.Success,'Visible','off');
end

function ipadd_Callback(hObject, eventdata, handles)
% hObject    handle to ipadd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ipadd as text
%        str2double(get(hObject,'String')) returns contents of ipadd as a double


% --- Executes during object creation, after setting all properties.
function ipadd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ipadd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
