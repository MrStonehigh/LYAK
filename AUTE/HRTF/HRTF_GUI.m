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
handles.DistanceL = 1;
handles.DistanceR = 1;
handles.headsize = .24;
handles.c=344; %Sound velocity
handles.TdelayL = 0;
handles.TdelayR = 0;
handles.azi = 0;
handles.ele = 0;
handles.hrtfL = [ones(1,100)]';
handles.hrtfR = [ones(1,100)]';



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
handles.DistanceL = sqrt((handles.PosX^2)+(handles.PosY-handles.headsize/2)^2+handles.PosZ^2)
handles.DistanceR = sqrt((handles.PosX^2)+(handles.PosY+handles.headsize/2)^2+handles.PosZ^2)
handles.TdelayL = handles.DistanceL/handles.c
handles.TdelayR = handles.DistanceR/handles.c
handles.SampDelayL = round(handles.fs*((handles.TdelayL)))
handles.SampDelayR = round(handles.fs*((handles.TdelayR)))

AlgoFlexClient(handles.serverID,'SetData',handles.idDelayR,'DelayTime',handles.TdelayR);
AlgoFlexClient(handles.serverID,'SetData',handles.idDelayL,'DelayTime',handles.TdelayL);

%handles.azi = asin( (handles.PosY * asin(90)) / sqrt(handles.PosY^2 + handles.PosX^2) )


handles.azi =acosd( dot([handles.PosX handles.PosY], [1 0] ) / (norm([handles.PosX handles.PosY]) * norm([1 0 ])))
handles.ele =acosd( dot([handles.PosX handles.PosY handles.PosZ], [handles.PosX handles.PosY 0] ) / (norm([handles.PosX handles.PosY handles.PosZ]) * norm([handles.PosX handles.PosY 0])))

if (handles.PosY < 0)
    handles.azi = -handles.azi
end

if (handles.PosZ < 0)
    handles.ele = -handles.ele
end

if (handles.PosX == 0 && handles.PosY == 0)
    handles.azi = 0
    handles.ele = 0
end

get_HRTF(handles.azi,handles.ele);


% Update handles structure
guidata(hObject, handles);

function get_HRTF(azi,ele)
% hObject    handle to PosZBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


eleArr=[-40 -30 -20 -10 0 10 20 30 40 50 60 70 80 90];

ele = round(ele/10)*10;

if(ele < -40)
    ele = -40
end

if (ele > 90)
    ele = 90
end

eleInd= ele/10 + 5;
eleFil=['elev' int2str(eleArr(eleInd))]
%radii=4;
fileL='';
fileR='';


   % cd 'C:\Users\Laste\Documents\MATLAB'
   cd 'C:\Users\Laste\Documents\Github\LYAK\AUTE'
    disp('Directory changed')

while ((exist(fileL,'file') ~= 2) && (exist(fileR,'file') ~= 2))
 
    if(azi==0)
hrtfL=['R' int2str(eleArr(eleInd)) 'e00' int2str(azi) 'a.wav']
hrtfR=['R' int2str(eleArr(eleInd)) 'e00' int2str(azi) 'a.wav']
    else if(azi<10)
hrtfL=['R' int2str(eleArr(eleInd)) 'e00' int2str(azi) 'a.wav']
hrtfR=['R' int2str(eleArr(eleInd)) 'e' int2str(360-azi) 'a.wav']
else if(azi<100&&azi>9)
hrtfL=['R' int2str(eleArr(eleInd)) 'e0' int2str(azi) 'a.wav']
hrtfR=['R' int2str(eleArr(eleInd)) 'e' int2str(360-azi) 'a.wav']
else if(azi>99&&azi<260)
     hrtfL=['R' int2str(eleArr(eleInd)) 'e' int2str(azi) 'a.wav']
hrtfR=['R' int2str(eleArr(eleInd)) 'e' int2str(360-azi) 'a.wav'] 
    else if(azi>259)
        hrtfL=['R' int2str(eleArr(eleInd)) 'e' int2str(azi) 'a.wav']
hrtfR=['R' int2str(eleArr(eleInd)) 'e0' int2str(360-azi) 'a.wav']     
        end
    end
    end
    end
 end
fileL=fullfile('HRTF','full',eleFil,hrtfL)
fileR=fullfile('HRTF','full',eleFil,hrtfR)
exist(fileL,'file')
if(azi==360)
    azi=0;
else
    azi=azi+1;
end
disp(azi)
end
azi=azi-1;
disp('Im out!')

left = importdata(fileL)
right = importdata(fileR)

handles.hrtfL = left.data;
handles.hrtfR = right.data;



% Hints: get(hObject,'String') returns contents of PosZBox as text
%        str2double(get(hObject,'String')) returns contents of PosZBox as a double
%Update handles structure
%guidata(hObject,handles)

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

% AlgoFlexClient(handles.serverID,'ConnectAudio',idMatPlayer,1,idGain,1);
% AlgoFlexClient(handles.serverID,'ConnectAudio',idGain,1,idMatRec,1);

% Audiostream OUT
[idAudioOut nameAudioOut]=AlgoFlexClient(handles.serverID,'Create','AudioStream',2,0);
AlgoFlexClient(handles.serverID,'Help','AudioStream');
AlgoFlexClient(handles.serverID,'GetData',idAudioOut,'Capabilities')
AlgoFlexClient(handles.serverID,'SetData',idAudioOut,'Device','Primary Sound Driver');
AlgoFlexClient(handles.serverID,'SetData',idAudioOut,'BufferSize',1024);

% Audiostream IN
[idAudioIn nameAudioIn]=AlgoFlexClient(handles.serverID,'Create','AudioStream',0,2);
AlgoFlexClient(handles.serverID,'Help','AudioStream');
AlgoFlexClient(handles.serverID,'GetData',idAudioIn,'Capabilities');
AlgoFlexClient(handles.serverID,'SetData',idAudioIn,'Device','Primary Sound Capture Driver');
AlgoFlexClient(handles.serverID,'SetData',idAudioIn,'BufferSize',1024);
AlgoFlexClient(handles.serverID,'Help','FFT');

% [idConvL nameConvL]=AlgoFlexClient(handles.serverID,'Create','FastConv',2,1);
% AlgoFlexClient(handles.serverID,'SetData',idConvL,'CompleteSetup',[num2cell(handles.hrtfL) num2cell((handles.hrtfL)) num2cell(2)]);
% [idConvR nameConvR]=AlgoFlexClient(handles.serverID,'Create','FastConv',2,1);
% AlgoFlexClient(handles.serverID,'SetData',idConvR,'CompleteSetup',cell(handles.hrtfR,1,1));
% AlgoFlexClient(handles.serverID,'Help','FastConv')

[idConvL nameConvL]=AlgoFlexClient(handles.serverID,'Create','Fx',1,1);
AlgoFlexClient(handles.serverID,'SetData',idConvL,'FxLength',length(handles.hrtfL));
AlgoFlexClient(handles.serverID,'SetData',idConvL,'FxCoef',handles.hrtfL);

[idConvR nameConvR]=AlgoFlexClient(handles.serverID,'Create','Fx',1,1);
AlgoFlexClient(handles.serverID,'SetData',idConvR,'FxLength',length(handles.hrtfR));
AlgoFlexClient(handles.serverID,'SetData',idConvR,'FxCoef',handles.hrtfR);

[idFilePlay nameFilePlay]=AlgoFlexClient(handles.serverID,'Create','FilePlayer',0,2);
AlgoFlexClient(handles.serverID,'Help','FilePlayer');
AlgoFlexClient(handles.serverID,'SetData',idFilePlay,'InputFileName',handles.playbackFile);
AlgoFlexClient(handles.serverID,'SetData',idFilePlay,'PlayMode','whole');
AlgoFlexClient(handles.serverID,'SetData',idFilePlay,'BufferSize',1024);
AlgoFlexClient(handles.serverID,'SetData',idFilePlay,'CurPosRate',1);
AlgoFlexClient(handles.serverID,'GetData',idFilePlay,'FileSize');

[idhrtfR namehrtfR]=AlgoFlexClient(handles.serverID,'Create','MatrixPlayer',0,1);
AlgoFlexClient(handles.serverID,'Help','MatrixPlayer');
AlgoFlexClient(handles.serverID,'SetData',idhrtfR,'Samples',handles.hrtfR);
AlgoFlexClient(handles.serverID,'SetData',idhrtfR,'PlaybackMode','repeat');


[idhrtfL namehrtfL]=AlgoFlexClient(handles.serverID,'Create','MatrixPlayer',0,1);
AlgoFlexClient(handles.serverID,'Help','FilePlayer');
AlgoFlexClient(handles.serverID,'SetData',idhrtfL,'Samples',handles.hrtfL);
AlgoFlexClient(handles.serverID,'SetData',idhrtfL,'PlaybackMode','repeat');


% Delays
[handles.idDelayL handles.nameDelayL] = AlgoFlexClient(handles.serverID,'Create','Delay',1,1);
AlgoFlexClient(handles.serverID,'Help','Delay');
AlgoFlexClient(handles.serverID,'SetData',handles.idDelayL,'DelayTime',handles.TdelayL);

[handles.idDelayR handles.nameDelayR] = AlgoFlexClient(handles.serverID,'Create','Delay',1,1);
AlgoFlexClient(handles.serverID,'Help','Delay');
AlgoFlexClient(handles.serverID,'SetData',handles.idDelayR,'DelayTime',handles.TdelayR);

[idProd nameProd] = AlgoFlexClient(handles.serverID,'Create','Prod',2,1);
AlgoFlexClient(handles.serverID,'SetData',idProd,'Mode','Numerical');
AlgoFlexClient(handles.serverID,'Help','ParmProdSum')
%AlgoFlexClient(serverID,'SetData',idProd,'ParmX1',IID_L)
%AlgoFlexClient(serverID,'SetData',idProd,'ParmX2','Prod')

% :::::::: Route audio :::::::::
% 
% AlgoFlexClient(handles.serverID,'ConnectAudio',idAudioIn, [1 2],idDelay,[1 2]);
% AlgoFlexClient(handles.serverID,'ConnectAudio',idDelay, [1 2],idAudioOut,[1 2]);
%AlgoFlexClient(handles.serverID,'ConnectAudio',idFilePlay, [1 2],idAudioOut,[1 2]);

% Music to delay
AlgoFlexClient(handles.serverID,'ConnectAudio',idFilePlay, 1,handles.idDelayL,1);
AlgoFlexClient(handles.serverID,'ConnectAudio',idFilePlay, 2,handles.idDelayR,1);

% AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idDelayL, 1,idAudioOut,1);
% AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idDelayR, 1,idAudioOut,2);

AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idDelayL, 1,idConvL,1);
AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idDelayR, 1,idConvR,1);

% AlgoFlexClient(handles.serverID,'ConnectAudio',idhrtfL, 1,idConvL,2);
% AlgoFlexClient(handles.serverID,'ConnectAudio',idhrtfR, 1,idConvR,2);

AlgoFlexClient(handles.serverID,'ConnectAudio',idConvL, 1,idAudioOut,1);
AlgoFlexClient(handles.serverID,'ConnectAudio',idConvR, 1,idAudioOut,2);

% :::: Set Exe sequence ::::::
AlgoFlexClient(handles.serverID,'SetExeSeq',[idFilePlay handles.idDelayL handles.idDelayR idhrtfL idhrtfR idConvL idConvR idAudioOut]);


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


