function varargout = gen_compare(varargin)
% GEN_COMPARE MATLAB code for gen_compare.fig
%      GEN_COMPARE, by itself, creates a new GEN_COMPARE or raises the existing
%      singleton*.
%
%      H = GEN_COMPARE returns the handle to a new GEN_COMPARE or the handle to
%      the existing singleton*.
%
%      GEN_COMPARE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GEN_COMPARE.M with the given input arguments.
%
%      GEN_COMPARE('Property','Value',...) creates a new GEN_COMPARE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gen_compare_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gen_compare_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gen_compare

% Last Modified by GUIDE v2.5 31-Aug-2018 00:23:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gen_compare_OpeningFcn, ...
                   'gui_OutputFcn',  @gen_compare_OutputFcn, ...
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


% --- Executes just before gen_compare is made visible.
function gen_compare_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gen_compare (see VARARGIN)

% Choose default command line output for gen_compare
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gen_compare wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gen_compare_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in image1.
function image1_Callback(hObject, eventdata, handles)
% hObject    handle to image1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname]=uigetfile('*.*','Choose an iris image');
fig=imread(strcat(pathname,filename)); % first image
setappdata(handles.figure1,'IrisImg1',fig);
subplot(3,1,1);imshow(fig);


% 
% % --- Executes on button press in image2.
% function image2_Callback(hObject, eventdata, handles)
% % hObject    handle to image2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)



% A handle is an object that indirectly references its data.  When a
%    handle is constructed, an object with storage for property values is
%    created.  The constructor returns a handle to this object.  When a
%    handle object is copied, for example during assignment or when passed
%    to a MATLAB function, the handle is copied but not the underlying
%    object property values.

% --- Executes on button press in template1.
function template1_Callback(hObject, eventdata, handles)
% hObject    handle to template1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eye=getappdata(handles.figure1,'IrisImg1');
% VALUE = getappdata(H, NAME) gets the value of the
%   application-defined data with name specified by NAME in the
%   object with handle H.  If the application-defined data does
%   not exist, an empty matrix will be returned in VALUE.


[local xc yc time]=localisation2(eye,0.2);
[ci cp out time]=thresh(local,50,200);
[ring,parr]=normaliseiris(local,ci(2),ci(1),ci(3),cp(2),cp(1),cp(3),'normal.bmp',100,300);
[temp th tv]=gen_templateVVV(parr);
setappdata(handles.figure1,'temp1',temp);
subplot(3,1,1);imshow(temp);



% --- Executes on button press in template2.
function template2_Callback(hObject, eventdata, handles)
% hObject    handle to template2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% VALUE = getappdata(H, NAME) gets the value of the
%   application-defined data with name specified by NAME in the
%   object with handle H.  If the application-defined data does
%   not exist, an empty matrix will be returned in VALUE.

%..........................................................
% subplot(3,1,2);imshow(temp2);
% temp1=getappdata(handles.figure1,'temp1');
%..........................................................  

src = dir('C:\Users\ASUS\Desktop\IrisRecognition-master\1\left\');
image_2={src.name};
count=length(image_2);
       for j=1:count-2
            bb = strcat('C:\Users\ASUS\Desktop\IrisRecognition-master\1\left\',num2str(j),'.jpg');
            fig = imread(bb);  %second img
            setappdata(handles.figure1,'IrisImg2',fig);
%             eye=getappdata(handles.figure1,'IrisImg2');
       %.........................
            eye=fig;
            [local xc yc time]=localisation2(eye,0.2);
            [ci cp out time]=thresh(local,50,200);
            [ring,parr]=normaliseiris(local,ci(2),ci(1),ci(3),cp(2),cp(1),cp(3),'normal.jpg',100,300);
            [temp2 th tv]=gen_templateVVV(parr);
            %.........................
            temp1=getappdata(handles.figure1,'temp1');
            hd=hammingdist(temp1, temp2);
            set(handles.Result,'Visible','on');
            set(handles.HammingVal,'Visible','on');
            set(handles.HammingVal,'String',hd);
            if(hd<=0.2)
                set(handles.HammingDist,'Visible','on');
                set(handles.Success,'Visible','on');
                set(handles.Fail,'Visible','off');
                break;
            else
                set(handles.HammingDist,'Visible','on');
                set(handles.Fail,'Visible','on');
                set(handles.Success,'Visible','off');
            end
        end
       
% --- Executes on button press in template2euclid.
% function template2euclid_Callback(hObject, eventdata, handles)
% % hObject    handle to template2euclid (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% % eye=getappdata(handles.figure1,'IrisImg2');
% % VALUE = getappdata(H, NAME) gets the value of the
% %   application-defined data with name specified by NAME in the
% %   object with handle H.  If the application-defined data does
% %   not exist, an empty matrix will be returned in VALUE.
% 
% src = dir('C:\Users\ASUS\Desktop\IrisRecognition-master\1\left\');
% image_2={src.name};
% count=length(image_2);
%        for j=1:count-2
%             bb = strcat('C:\Users\ASUS\Desktop\IrisRecognition-master\1\left\',num2str(j),'.jpg');
%             fig = imread(bb);  %second img
%             setappdata(handles.figure1,'IrisImg2',fig);
%             eye=getappdata(handles.figure1,'IrisImg2');
%        %.........................
%        
%             [local xc yc time]=localisation2(eye,0.2);
%             [ci cp out time]=thresh(local,50,200);
%             [ring,parr]=normaliseiris(local,ci(2),ci(1),ci(3),cp(2),cp(1),cp(3),'normal.jpg',100,300);
%             [temp2 th tv]=gen_templateVVV(parr);
%             %.........................
%             temp1=getappdata(handles.figure1,'temp1');
%             hd=euclidist(temp1, temp2);
%             set(handles.Result,'Visible','on');
%             set(handles.Euclideanvalue,'Visible','on');
%             set(handles.Euclideanvalue,'String',hd);
%             
%             if(hd<0.2)
%                 set(handles.Eucliddist,'Visible','on');
%                 set(handles.Success,'Visible','on');
%                 set(handles.Fail,'Visible','off');
%                 break;
%             else
%                 set(handles.Eucliddist,'Visible','on');
%                 set(handles.Fail,'Visible','on');
%                 set(handles.Success,'Visible','off');
%             end
%         end
% % ...........................................................................................................
% % [local xc yc time]=localisation2(eye,0.2);
% % [ci cp out time]=thresh(local,50,200);
% % [ring,parr]=normaliseiris(local,ci(2),ci(1),ci(3),cp(2),cp(1),cp(3),'normal.bmp',100,300);
% % [temp2 th tv]=gen_templateVVV(parr);
% % subplot(3,1,2);imshow(temp2);
% % temp1=getappdata(handles.figure1,'temp1');
% % hd=euclidist(temp1, temp2);
% % set(handles.Result,'Visible','on');
% % set(handles.Euclideanvalue,'Visible','on');
% % set(handles.Euclideanvalue,'String',hd);
% % if(hd<=0.2)
% %     set(handles.Eucliddist,'Visible','on');
% %     set(handles.Success,'Visible','on');
% %     set(handles.Fail,'Visible','off');
% % 
% % else
% %     set(handles.Eucliddist,'Visible','on');
% %     set(handles.Fail,'Visible','on');
% %     set(handles.Success,'Visible','off');
% % end
% 
% 
% % --- Executes on button press in template2canberra.
% function template2canberra_Callback(hObject, eventdata, handles)
% % hObject    handle to template2canberra (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% % eye=getappdata(handles.figure1,'IrisImg2');
% % VALUE = getappdata(H, NAME) gets the value of the
% %   application-defined data with name specified by NAME in the
% %   object with handle H.  If the application-defined data does
% %   not exist, an empty matrix will be returned in VALUE.
% src = dir('C:\Users\ASUS\Desktop\IrisRecognition-master\1\left\');
% image_2={src.name};
% count=length(image_2);
%        for j=1:count-2
%             bb = strcat('C:\Users\ASUS\Desktop\IrisRecognition-master\1\left\',num2str(j),'.jpg');
%             fig = imread(bb);  %second img
%             setappdata(handles.figure1,'IrisImg2',fig);
%             eye=getappdata(handles.figure1,'IrisImg2');
%             %.........................
%        
%             [local xc yc time]=localisation2(eye,0.2);
%             [ci cp out time]=thresh(local,50,200);
%             [ring,parr]=normaliseiris(local,ci(2),ci(1),ci(3),cp(2),cp(1),cp(3),'normal.jpg',100,300);
%             [temp2 th tv]=gen_templateVVV(parr);
%             %.........................
%             temp1=getappdata(handles.figure1,'temp1');
%             sum=canberradistt(temp1, temp2);
%             set(handles.Result,'Visible','on');
%             set(handles.canberraval,'Visible','on');
%             set(handles.canberraval,'String',sum);
%             if(sum<0.2)   %1.76471 1.09431
%                 set(handles.Canberradist,'Visible','on');
%                 set(handles.Success,'Visible','on');
%                 set(handles.Fail,'Visible','off');
%                 break;   
%             else
%                 set(handles.Canberradist,'Visible','on');
%                 set(handles.Fail,'Visible','on');
%                 set(handles.Success,'Visible','off');
%             end
%         end
% ...............................................................................................................................
% [local xc yc time]=localisation2(eye,0.2);
% [ci cp out time]=thresh(local,50,200);
% [ring,parr]=normaliseiris(local,ci(2),ci(1),ci(3),cp(2),cp(1),cp(3),'normal.bmp',100,300);
% [temp2 th tv]=gen_templateVVV(parr);
% subplot(3,1,2);imshow(temp2);
% temp1=getappdata(handles.figure1,'temp1');
% hd=canberradistt(temp1, temp2);
% set(handles.Result,'Visible','on');
% set(handles.canberraval,'Visible','on');
% set(handles.canberraval,'String',hd);
% if(hd<=0.2)
%     set(handles.Canberradist,'Visible','on');
%     set(handles.Success,'Visible','on');
%     set(handles.Fail,'Visible','off');
% 
% else
%     set(handles.Canberradist,'Visible','on');
%     set(handles.Fail,'Visible','on');
%     set(handles.Success,'Visible','off');
% end



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
setappdata(handles.figure1,'IrisImg11',img);
axes(handles.axes1);
imshow(img)


% --- Executes on button press in valueident_2webcam.
function valueident_2webcam_Callback(hObject, eventdata, handles)
% hObject    handle to valueident_2webcam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
src = dir('C:\Users\ASUS\Desktop\IrisRecognition-master\1\right\');
image_2={src.name};
count=length(image_2);
       for j=1:count-2
            bb = strcat('C:\Users\ASUS\Desktop\IrisRecognition-master\1\right\',num2str(j),'.jpg');
            fig = imread(bb);  %second img
            setappdata(handles.figure1,'IrisImg2',fig);
%             eye=getappdata(handles.figure1,'IrisImg2');
       %.........................
            eye=fig;
            [local xc yc time]=localisation2(eye,0.2);
            [ci cp out time]=thresh(local,50,200);
            [ring,parr]=normaliseiris(local,ci(2),ci(1),ci(3),cp(2),cp(1),cp(3),'normal.jpg',100,300);
            [temp2 th tv]=gen_templateVVV(parr);
            %.........................
            temp1=getappdata(handles.figure1,'temp11');
            hd=hammingdist(temp1, temp2);
            set(handles.Result,'Visible','on');
            set(handles.HammingVal,'Visible','on');
            set(handles.HammingVal,'String',hd);
            if(hd<=0.2)
                set(handles.HammingDist,'Visible','on');
                set(handles.Success,'Visible','on');
                set(handles.Fail,'Visible','off');
                break;
            else
                set(handles.HammingDist,'Visible','on');
                set(handles.Fail,'Visible','on');
                set(handles.Success,'Visible','off');
            end
       end
       
       
% --- Executes on button press in tempweb2.
function tempweb2_Callback(hObject, eventdata, handles)
% hObject    handle to tempweb2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eye=getappdata(handles.figure1,'IrisImg11');
[local xc yc time]=localisation2(eye,0.2);
[ci cp out time]=thresh(local,50,200);
[ring,parr]=normaliseiris(local,ci(2),ci(1),ci(3),cp(2),cp(1),cp(3),'normal.jpg',100,300);
[temp th tv]=gen_templateVVV(parr);
setappdata(handles.figure1,'temp11',temp);
axes(handles.axes2);
imshow(temp);
