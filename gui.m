function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 03-Feb-2020 18:36:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)
image1 = imread('aceeeagle3.png');
image2 = imread('aceeeagle2.png');
tone = [1, 2, 3, 2, 1, 2, 5, 1, -7, 1, 4, 3];
rhythms = [1, 1, 2, 1, 1, 1, 3, 1, 0.5, 1, 1, 2];
y = [];
for i = 1:12
    yx = gen_wave(tone(i), rhythms(i));
    y = cat(2, y, yx);
end
flag = 0;
index=1;
for i = 1:12
    rep = tone(i) + 1;
    if(tone(i) < 0)
        rep = 1;
    end
    totalframe = 0.5 * rhythms(i) * 30;
    eachframe = floor(10 / rep);
    flag = 0;
    for i = 1:totalframe
        if(flag == 0)
            D(:, :, :, index) = image1;
            index = index + 1;
        else
            D(:, :, :, index) = image2;
            index = index + 1;
        end
        if(mod(i, eachframe) == 0)
            if(flag == 0)
                flag = 1;
            else
                flag = 0;
            end
        end
    end
end
handles.state = 0;
handles.mov = immovie(D);
handles.y = y;
DD(:, :, :, 1) = image1;
handles.mov2 = immovie(DD);
movie(handles.mov2, 1, 30);
hold on;



% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
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
handles.state=1;
while handles.state==1
sound(handles.y, 44100);
movie(handles.mov, 1, 30);
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear sound;
handles.state=0;
movie(handles.mov2, 1, 30);
guidate(hObject, handles);


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1
while get(hObject, 'Value')
    set(hObject, 'string', '½áÊø');
    sound(handles.y, 44100);
    movie(handles.mov, 1, 30);
    
end
if get(hObject, 'Value') == 0
    set(hObject, 'string', '¿ªÊ¼');
    clear sound;
    movie(handles.mov2, 1, 30);
    
end
