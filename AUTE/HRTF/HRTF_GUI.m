function varargout = HRTF_GUI(varargin)
% HRTF_GUI M-file for HRTF_GUI.fig
%      HRTF_GUI, by itself, creates a new HRTF_GUI or raises the existing
%      singleton*.
%
%      H = HRTF_GUI returns the handle to a new HRTF_GUI or the handle to
%      the existing singleton*.
%
%      HRTF_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HRTF_GUI.M with the given input arguments.
%
%      HRTF_GUI('Property','Value',...) creates a new HRTF_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HRTF_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HRTF_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HRTF_GUI

% Last Modified by GUIDE v2.5 15-Nov-2017 12:08:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HRTF_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @HRTF_GUI_OutputFcn, ...
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


% --- Executes just before HRTF_GUI is made visible.
function HRTF_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HRTF_GUI (see VARARGIN)

cd 'C:\Users\Laste\Documents\GitHub\LYAK\AUTE';

handles.output = hObject;
global Room;
Room = handles;

set(handles.HRTF,'units','normalize','position',[.35 .35 .45 .3])


% Choose default command line output for HRTF_GUI
handles.output = hObject;
handles.serverID = 0;
handles.fs = 48000; 
handles.rectime = 10;
handles.sampno = 0;
handles.playbackFile = 'HRTF\Nirvana.wav';
handles.PosX = 1;
handles.PosY = 0;
handles.PosZ = 0;


set(handles.PosXBox,'String',num2str(handles.PosX));
set(handles.PosYBox,'String',num2str(handles.PosY));
set(handles.PosZBox,'String',num2str(handles.PosZ));

% Plot

Room.ax = axes('box','on','units','norm','pos',[0.5 0.1 0.45 0.85]);
Room.ph = plot3(handles.PosX,handles.PosY,handles.PosZ,'x','MarkerSize',3,'LineWidth',8);
grid on
xlabel('X')
ylabel('Y')
zlabel('Z')
hold on
plot3(0,0,0,'or','MarkerSize',3,'LineWidth',8);
plot3([0 0.1],[0 0],[0 0],'o--r','MarkerSize',3,'LineWidth',2);
legend('Source','Listener','Location','East')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HRTF_GUI wait for user response (see UIRESUME)
% uiwait(handles.HRTF);


% --- Outputs from this function are returned to the command line.
function varargout = HRTF_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function SetPosition_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Room;
set(Room.ph,'xdata',handles.PosX);
set(Room.ph,'ydata',handles.PosY);
set(Room.ph,'zdata',handles.PosZ);



% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton2.
function PLAY_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
system('start C:\projects\Tools\AlgoFlex\bin\win32_x86\Release\AlgoFlexServer.exe');
ServerIpName = 'localhost';
handles.serverID = AlgoFlexClient('OpenServCon',ServerIpName,4242);


AlgoFlexClient(handles.serverID,'SetSampleRate',handles.fs);

[idMatPlayer nameMatPlayer] = AlgoFlexClient(handles.serverID,'Create', 'MatrixPlayer',0,1);

handles.rectime=10;      %Recording time for MatrixRecorder in sec
handles.sampno=handles.fs*handles.rectime;
[idMatRec nameMatRec] = AlgoFlexClient(handles.serverID,'Create','MatrixRecorder',1,0);

[idGain nameGain] = AlgoFlexClient(handles.serverID,'Create','Gain',1,1);

AlgoFlexClient(handles.serverID,'ConnectAudio',idMatPlayer,1,idGain,1);
AlgoFlexClient(handles.serverID,'ConnectAudio',idGain,1,idMatRec,1);

% Audiostream OUT
[idAudioOut nameAudioOut]=AlgoFlexClient(handles.serverID,'Create','AudioStream',2,0);
AlgoFlexClient(handles.serverID,'Help','AudioStream')
AlgoFlexClient(handles.serverID,'GetData',idAudioOut,'Capabilities')
AlgoFlexClient(handles.serverID,'SetData',idAudioOut,'Device','Primary Sound Driver');
AlgoFlexClient(handles.serverID,'SetData',idAudioOut,'BufferSize',1024);

% Audiostream IN
[idAudioIn nameAudioIn]=AlgoFlexClient(handles.serverID,'Create','AudioStream',0,2);
AlgoFlexClient(handles.serverID,'Help','AudioStream');
AlgoFlexClient(handles.serverID,'GetData',idAudioIn,'Capabilities');
AlgoFlexClient(handles.serverID,'SetData',idAudioIn,'Device','Primary Sound Capture Driver');
AlgoFlexClient(handles.serverID,'SetData',idAudioIn,'BufferSize',1024);

[idFastConv nameFastConv]=AlgoFlexClient(handles.serverID,'Create','FastConv',2,1);
AlgoFlexClient(handles.serverID,'Help','FastConv');

[idFilePlay nameFilePlay]=AlgoFlexClient(handles.serverID,'Create','FilePlayer',0,2);
AlgoFlexClient(handles.serverID,'Help','FilePlayer')
AlgoFlexClient(handles.serverID,'SetData',idFilePlay,'InputFileName',handles.playbackFile);
AlgoFlexClient(handles.serverID,'SetData',idFilePlay,'PlayMode','whole');
AlgoFlexClient(handles.serverID,'SetData',idFilePlay,'BufferSize',1024);
AlgoFlexClient(handles.serverID,'SetData',idFilePlay,'CurPosRate',1);
AlgoFlexClient(handles.serverID,'GetData',idFilePlay,'FileSize');

[idDelay nameDelay] = AlgoFlexClient(handles.serverID,'Create','Delay',2,2);
AlgoFlexClient(handles.serverID,'Help','Delay');
AlgoFlexClient(handles.serverID,'SetData',idDelay,'DelayTime',1);

[idProd nameProd] = AlgoFlexClient(handles.serverID,'Create','Prod',2,1);
AlgoFlexClient(handles.serverID,'SetData',idProd,'Mode','Numerical');
AlgoFlexClient(handles.serverID,'Help','Prod')
%AlgoFlexClient(serverID,'SetData',idProd,'ParmX1',IID_L)
%AlgoFlexClient(serverID,'SetData',idProd,'ParmX2','Prod')

% :::::::: Route audio :::::::::
% 
% AlgoFlexClient(handles.serverID,'ConnectAudio',idAudioIn, [1 2],idDelay,[1 2]);
% AlgoFlexClient(handles.serverID,'ConnectAudio',idDelay, [1 2],idAudioOut,[1 2]);
AlgoFlexClient(handles.serverID,'ConnectAudio',idFilePlay, [1 2],idAudioOut,[1 2]);

% :::: Set Exe sequence ::::::
AlgoFlexClient(handles.serverID,'SetExeSeq',[idFilePlay idAudioOut]);


% :::: start ::::::::
AlgoFlexClient(handles.serverID,'SetSampleRate',handles.fs);
AlgoFlexClient(handles.serverID,'MultiStart');
guidata(hObject,handles)


% --- Executes on button press in pushbutton3.
function STOP_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AlgoFlexClient(handles.serverID,'Stop');

AlgoFlexClient(handles.serverID,'DestroyAll');
AlgoFlexClient(handles.serverID,'Quit');
%Update handles structure
guidata(hObject,handles)



function PosX_Callback(hObject, eventdata, handles)
% hObject    handle to PosXBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.PosX=str2double(get(hObject,'String'));
%set(handles.PosXBox,'String',num2str(handles.PosX));
% Hints: get(hObject,'String') returns contents of PosXBox as text
%        str2double(get(hObject,'String')) returns contents of PosXBox as a double
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function PosX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PosXBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PosY_Callback(hObject, eventdata, handles)
% hObject    handle to PosYBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.PosY=str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of PosYBox as text
%        str2double(get(hObject,'String')) returns contents of PosYBox as a double
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function PosY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PosYBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PosZ_Callback(hObject, eventdata, handles)
% hObject    handle to PosZBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.PosZ=str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of PosZBox as text
%        str2double(get(hObject,'String')) returns contents of PosZBox as a double
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function PosZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PosZBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

