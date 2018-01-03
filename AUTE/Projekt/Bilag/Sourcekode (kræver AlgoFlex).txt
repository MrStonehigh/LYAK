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

% Last Modified by GUIDE v2.5 29-Nov-2017 13:17:18

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
handles.sampno = 30;
%handles.playbackFile = importdata('HRTF\Testing.mat');
handles.playbackFile = importdata('HRTF\10secBeat.mat');
%handles.playbackFile = importdata('HRTF\S400.mat');
%handles.playbackFile = handles.playbackFile2.playdata 
handles.PosX = 1;
handles.PosY = 0;
handles.PosZ = 0;
handles.DistanceL = 1;
handles.DistanceR = 1;
handles.headsize = .23;
handles.c=344; %Sound velocity
handles.TdelayL = 0;
handles.TdelayR = 0;
% handles.azimuthBox = '0';
% handles.elevationBox = '0';
handles.azi = 0;
handles.ele = 0;
handles.hrtfL = [zeros(512,1)]';
handles.hrtfR = [zeros(512,1)]';
handles.lengthHrtfL = 512;
handles.lengthHrtfR = 512;
handles.SPLL = -13;
handles.SPLR = -13;



set(handles.PosXBox,'String',num2str(handles.PosX));
set(handles.PosYBox,'String',num2str(handles.PosY));
set(handles.PosZBox,'String',num2str(handles.PosZ));



% Plot

Room.ax = axes('box','on','units','norm','pos',[0.5 0.1 0.45 0.85]);
Room.ph = plot3(handles.PosX,handles.PosY,handles.PosZ,'x','MarkerSize',3,'LineWidth',8);
grid on
%grid minor
xlabel('X')
ylabel('Y')
zlabel('Z')
axis([(-handles.DistanceL*2) (handles.DistanceL*2) (-handles.DistanceL*2) (handles.DistanceL*2) (-handles.DistanceL*2) (handles.DistanceL*2)])
hold on
plot3(0,0,0,'or','MarkerSize',3,'LineWidth',8);
plot3([0 0.9],[0 0],[0 0],'o--r','MarkerSize',3,'LineWidth',2);
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

handles.DistanceL = sqrt((handles.PosX^2)+(handles.PosY-handles.headsize/2)^2+handles.PosZ^2)
handles.DistanceR = sqrt((handles.PosX^2)+(handles.PosY+handles.headsize/2)^2+handles.PosZ^2)
handles.TdelayL = handles.DistanceL/handles.c
handles.TdelayR = handles.DistanceR/handles.c
handles.SampDelayL = round(handles.fs*((handles.TdelayL)))
handles.SampDelayR = round(handles.fs*((handles.TdelayR)))

AlgoFlexClient(handles.serverID,'SetData',handles.idDelayR,'DelayTime',handles.TdelayR);
AlgoFlexClient(handles.serverID,'SetData',handles.idDelayL,'DelayTime',handles.TdelayL);

refSPL = -13;
refDist = 1;
handles.SPLL = 20*log10(1/handles.DistanceL)+refSPL;
handles.SPLR =  (handles.SPLL * (handles.DistanceL/handles.DistanceR));

set(handles.DistanceBox,'string',num2str(handles.DistanceL));

AlgoFlexClient(handles.serverID,'SetData',handles.idGainL,'GainDb',handles.SPLL);
AlgoFlexClient(handles.serverID,'SetData',handles.idGainR,'GainDb',handles.SPLR);

%handles.azimuthBox = asin( (handles.PosY * asin(90)) / sqrt(handles.PosY^2 + handles.PosX^2) )
Roomskalar = 1.5;
global Room;
set(Room.ph,'xdata',handles.PosX);
set(Room.ph,'ydata',handles.PosY);
set(Room.ph,'zdata',handles.PosZ);
axis([(-handles.DistanceL*Roomskalar) (handles.DistanceL*Roomskalar) (-handles.DistanceL*Roomskalar) (handles.DistanceL*Roomskalar) (-handles.DistanceL*Roomskalar) (handles.DistanceL*Roomskalar)])


handles.azi =acosd( dot([handles.PosX handles.PosY], [1 0] ) / (norm([handles.PosX handles.PosY]) * norm([1 0 ])))
handles.ele =acosd( dot([handles.PosX handles.PosY handles.PosZ], [handles.PosX handles.PosY 0] ) / (norm([handles.PosX handles.PosY handles.PosZ]) * norm([handles.PosX handles.PosY 0])))

if (handles.PosY > 0)
    handles.azi = -handles.azi
end

if (handles.PosZ < 0)
    handles.ele = -handles.ele
end

if (handles.PosX == 0 && handles.PosY == 0)
    handles.azi = 0
    handles.ele = 0
end



if(handles.azi<0)
    handles.azi = 360+handles.azi;
end

eleArr=[-40 -30 -20 -10 0 10 20 30 40 50 60 70 80 90];

handles.ele = round(handles.ele/10)*10;

if(handles.ele < -40)
    handles.ele = -40
end

if (handles.ele > 90)
    handles.ele = 90
end

eleInd= handles.ele/10 + 5;
eleFil=['elev' int2str(eleArr(eleInd))];
%radii=4;
fileL='';
fileR='';


   % cd 'C:\Users\Laste\Documents\MATLAB'
   cd 'C:\Users\Laste\Documents\Github\LYAK\AUTE'
    disp('Directory changed')

while ((exist(fileL,'file') ~= 2) && (exist(fileR,'file') ~= 2));
 
    if(handles.azi==0)
    hrtfL=['L' int2str(eleArr(eleInd)) 'e00' int2str(handles.azi) 'a.wav'];
    hrtfR=['R' int2str(eleArr(eleInd)) 'e00' int2str(handles.azi) 'a.wav'];
        else if(handles.azi<10)
    hrtfL=['L' int2str(eleArr(eleInd)) 'e00' int2str(handles.azi) 'a.wav'];
    hrtfR=['R' int2str(eleArr(eleInd)) 'e00' int2str(handles.azi) 'a.wav'];
else if(handles.azi<100&&handles.azi>9)
    hrtfL=['L' int2str(eleArr(eleInd)) 'e0' int2str(handles.azi) 'a.wav'];
    hrtfR=['R' int2str(eleArr(eleInd)) 'e0' int2str(handles.azi) 'a.wav'];
else if(handles.azi>99&&handles.azi<260)
    hrtfL=['L' int2str(eleArr(eleInd)) 'e' int2str(handles.azi) 'a.wav'];
    hrtfR=['R' int2str(eleArr(eleInd)) 'e' int2str(handles.azi) 'a.wav'] ;
    else if(handles.azi>259)
        hrtfL=['L' int2str(eleArr(eleInd)) 'e' int2str(handles.azi) 'a.wav'];
        hrtfR=['R' int2str(eleArr(eleInd)) 'e' int2str(handles.azi) 'a.wav']    ; 
        end
    end
    end
    end
 end
fileL=fullfile('HRTF','full',eleFil,hrtfL)
fileR=fullfile('HRTF','full',eleFil,hrtfR)
exist(fileL,'file');
if(handles.azi==360 || handles.azi>360)
    handles.azi=0;
else
    handles.azi=handles.azi+1;
end
disp(handles.azi);
end
handles.azi=handles.azi-1;
disp('Im out!')

set(handles.azimuthBox,'string',num2str(handles.azi));
set(handles.elevationBox,'string',num2str(handles.ele));




left = importdata(fileL);
right = importdata(fileR);
disp(left)
handles.hrtfL = left.data';
handles.hrtfR = right.data';
disp('VIEWING HANDLES.HRTFL:')
disp(handles.hrtfL);
handles.lengthHrtfL = length(left.data);
handles.lengthHrtfR = length(right.data);

AlgoFlexClient(handles.serverID,'SetData',handles.idConvL,'FxLength',handles.lengthHrtfL);
AlgoFlexClient(handles.serverID,'SetData',handles.idConvL,'FxCoef',handles.hrtfL);

AlgoFlexClient(handles.serverID,'SetData',handles.idConvR,'FxLength',handles.lengthHrtfR);
AlgoFlexClient(handles.serverID,'SetData',handles.idConvR,'FxCoef',handles.hrtfR);




%getHRTF_Callback(handles.azi,handles.ele,hObject, eventdata, handles);
% disp('VIEWING HANDLES.HRTFL AGAIN:')
% disp(handles.hrtfL)

% Update handles structure
guidata(hObject,handles);

function getHRTF_Callback(azi,ele,hObject, eventdata, handles)
% hObject    handle to PosZBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(azi<0)
    azi = 360+azi;
end

eleArr=[-40 -30 -20 -10 0 10 20 30 40 50 60 70 80 90];

ele = round(ele/10)*10;

if(ele < -40)
    ele = -40
end

if (ele > 90)
    ele = 90
end

eleInd= ele/10 + 5;
eleFil=['elev' int2str(eleArr(eleInd))];
%radii=4;
fileL='';
fileR='';


   % cd 'C:\Users\Laste\Documents\MATLAB'
   cd 'C:\Users\Laste\Documents\Github\LYAK\AUTE'
    disp('Directory changed')

while ((exist(fileL,'file') ~= 2) && (exist(fileR,'file') ~= 2));
 
    if(azi==0)
    hrtfL=['L' int2str(eleArr(eleInd)) 'e00' int2str(azi) 'a.wav'];
    hrtfR=['R' int2str(eleArr(eleInd)) 'e00' int2str(azi) 'a.wav'];
        else if(azi<10)
    hrtfL=['L' int2str(eleArr(eleInd)) 'e00' int2str(azi) 'a.wav'];
    hrtfR=['R' int2str(eleArr(eleInd)) 'e00' int2str(azi) 'a.wav'];
else if(azi<100&&azi>9)
    hrtfL=['L' int2str(eleArr(eleInd)) 'e0' int2str(azi) 'a.wav'];
    hrtfR=['R' int2str(eleArr(eleInd)) 'e0' int2str(azi) 'a.wav'];
else if(azi>99&&azi<260)
    hrtfL=['L' int2str(eleArr(eleInd)) 'e' int2str(azi) 'a.wav'];
    hrtfR=['R' int2str(eleArr(eleInd)) 'e' int2str(azi) 'a.wav'] ;
    else if(azi>259)
        hrtfL=['L' int2str(eleArr(eleInd)) 'e' int2str(azi) 'a.wav'];
        hrtfR=['R' int2str(eleArr(eleInd)) 'e' int2str(azi) 'a.wav']    ; 
        end
    end
    end
    end
 end
fileL=fullfile('HRTF','full',eleFil,hrtfL)
fileR=fullfile('HRTF','full',eleFil,hrtfR)
exist(fileL,'file');
if(azi==360 || azi>360)
    azi=0;
else
    azi=azi+1;
end
disp(azi);
end
azi=azi-1;
disp('Im out!')

set(handles.azimuthBox,'string',num2str(azi));
set(handles.elevationBox,'string',num2str(ele));


left = importdata(fileL);
right = importdata(fileR);
disp(left)
handles.hrtfL = left.data';
handles.hrtfR = right.data';
disp('VIEWING HANDLES.HRTFL:')
disp(handles.hrtfL);
handles.lengthHrtfL = length(left.data);
handles.lengthHrtfR = length(right.data);

AlgoFlexClient(handles.serverID,'SetData',handles.idConvL,'FxLength',handles.lengthHrtfL);
AlgoFlexClient(handles.serverID,'SetData',handles.idConvL,'FxCoef',handles.hrtfL);

AlgoFlexClient(handles.serverID,'SetData',handles.idConvR,'FxLength',handles.lengthHrtfR);
AlgoFlexClient(handles.serverID,'SetData',handles.idConvR,'FxCoef',handles.hrtfR);




% Update handles structure
guidata(hObject,handles);




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


set(handles.azimuthBox,'string',num2str(handles.azi));
set(handles.elevationBox,'string',num2str(handles.ele));
set(handles.DistanceBox,'string',num2str(handles.DistanceL));

AlgoFlexClient(handles.serverID,'SetSampleRate',handles.fs);

[handles.idMatPlayer handles.nameMatPlayer] = AlgoFlexClient(handles.serverID,'Create', 'MatrixPlayer',0,2);
AlgoFlexClient(handles.serverID,'Help','MatrixPlayer')
AlgoFlexClient(handles.serverID,'SetData',handles.idMatPlayer,'Samples',handles.playbackFile);
AlgoFlexClient(handles.serverID,'SetData',handles.idMatPlayer,'PlaybackMode','repeat');



[idChanCombL nameChanCombL] = AlgoFlexClient(handles.serverID,'Create','ChannelCombiner',2,1);
AlgoFlexClient(handles.serverID,'Help','ChannelCombiner')
AlgoFlexClient(handles.serverID,'SetData',idChanCombL,'Function','MeanActive');

[idChanCombR nameChanCombR] = AlgoFlexClient(handles.serverID,'Create','ChannelCombiner',2,1);
AlgoFlexClient(handles.serverID,'Help','ChannelCombiner')
AlgoFlexClient(handles.serverID,'SetData',idChanCombR,'Function','MeanActive');


handles.rectime=30;      %Recording time for MatrixRecorder in sec
handles.sampno=handles.fs*handles.rectime;
[handles.idMatRec handles.nameMatRec] = AlgoFlexClient(handles.serverID,'Create','MatrixRecorder',8,0);
AlgoFlexClient(handles.serverID,'Help','MatrixRecorder')
AlgoFlexClient(handles.serverID,'SetData',handles.idMatRec,'SamplesToRecord',handles.fs*10);
AlgoFlexClient(handles.serverID,'SetData',handles.idMatRec,'RecordMode','repeat');

[handles.idMatRecFil handles.nameMatRecFil] = AlgoFlexClient(handles.serverID,'Create','MatrixRecorder',2,0);
AlgoFlexClient(handles.serverID,'Help','MatrixRecorder');
AlgoFlexClient(handles.serverID,'SetData',handles.idMatRecFil,'SamplesToRecord',1024);
AlgoFlexClient(handles.serverID,'SetData',handles.idMatRecFil,'RecordMode','repeat');

[handles.idGainL handles.nameGainL] = AlgoFlexClient(handles.serverID,'Create','Gain',1,1);
AlgoFlexClient(handles.serverID,'SetData',handles.idGainL,'GainDb',handles.SPLL);
AlgoFlexClient(handles.serverID,'Help','Gain')
[handles.idGainR handles.nameGainR] = AlgoFlexClient(handles.serverID,'Create','Gain',1,1);
AlgoFlexClient(handles.serverID,'SetData',handles.idGainR,'GainDb',handles.SPLR);
AlgoFlexClient(handles.serverID,'SetData',handles.idGainL,'GLD_GainFactor',{'Linear','1','1e-6'});
AlgoFlexClient(handles.serverID,'SetData',handles.idGainR,'GLD_GainFactor',{'Linear','1','1e-6'});

% AlgoFlexClient(handles.serverID,'ConnectAudio',idMatPlayer,1,idGain,1);
% AlgoFlexClient(handles.serverID,'ConnectAudio',idGain,1,idMatRec,1);

% Audiostream OUT
[idAudioOut nameAudioOut]=AlgoFlexClient(handles.serverID,'Create','AudioStream',2,0);
AlgoFlexClient(handles.serverID,'Help','AudioStream');
AlgoFlexClient(handles.serverID,'GetData',idAudioOut,'RawCapabilities')
AlgoFlexClient(handles.serverID,'SetData',idAudioOut,'Device','Primary Sound Driver');
AlgoFlexClient(handles.serverID,'SetData',idAudioOut,'BufferSize',4096);

% ::::::::: UMIK Audiostream IN:::::::::::::::::
[idAudioIn nameAudioIn]=AlgoFlexClient(handles.serverID,'Create','AudioStream',0,2);
AlgoFlexClient(handles.serverID,'Help','AudioStream');
AlgoFlexClient(handles.serverID,'GetData',idAudioIn,'Capabilities');
%AlgoFlexClient(handles.serverID,'SetData',idAudioIn,'Device','Primary Sound Capture Driver');
AlgoFlexClient(handles.serverID,'SetData',idAudioIn,'Device','Microphone (Umik-1  Gain: 18dB  )');
AlgoFlexClient(handles.serverID,'SetData',idAudioIn,'BufferSize',4096);
% AlgoFlexClient(handles.serverID,'SetData',idAudioIn,'CardInputs',[2 1]);
% AlgoFlexClient(handles.serverID,'SetData',idAudioIn,'CardOutputs',[2 1]);
% ::::::::: UMIK Audiostream IN:::::::::::::::::

% AlgoFlexClient(handles.serverID,'Help','FFT');
% AlgoFlexClient(handles.serverID,'GetData',idAudioIn,'Capabilities')
% AlgoFlexClient(handles.serverID,'GetData',idAudioIn,'DeviceList')

% [idConvL nameConvL]=AlgoFlexClient(handles.serverID,'Create','FastConv',2,1);
% AlgoFlexClient(handles.serverID,'SetData',idConvL,'CompleteSetup',[num2cell(handles.hrtfL) num2cell((handles.hrtfL)) num2cell(2)]);
% [idConvR nameConvR]=AlgoFlexClient(handles.serverID,'Create','FastConv',2,1);
% AlgoFlexClient(handles.serverID,'SetData',idConvR,'CompleteSetup',cell(handles.hrtfR,1,1));
% AlgoFlexClient(handles.serverID,'Help','FastConv')

[handles.idConvL handles.nameConvL]=AlgoFlexClient(handles.serverID,'Create','Fx',1,2);
AlgoFlexClient(handles.serverID,'SetData',handles.idConvL,'FxLength',handles.lengthHrtfL);
AlgoFlexClient(handles.serverID,'SetData',handles.idConvL,'FxCoef',handles.hrtfL);

[handles.idConvR handles.nameConvR]=AlgoFlexClient(handles.serverID,'Create','Fx',1,2);
AlgoFlexClient(handles.serverID,'SetData',handles.idConvR,'FxLength',handles.lengthHrtfR);
AlgoFlexClient(handles.serverID,'SetData',handles.idConvR,'FxCoef',handles.hrtfR);

% [idFilePlay nameFilePlay]=AlgoFlexClient(handles.serverID,'Create','FilePlayer',0,2);
% AlgoFlexClient(handles.serverID,'Help','FilePlayer')
% AlgoFlexClient(handles.serverID,'SetData',idFilePlay,'InputFileName',handles.playbackFile);
% AlgoFlexClient(handles.serverID,'SetData',idFilePlay,'PlayMode','whole');
% AlgoFlexClient(handles.serverID,'SetData',idFilePlay,'BufferSize',1024);
% AlgoFlexClient(handles.serverID,'SetData',idFilePlay,'CurPosRate',1);
% AlgoFlexClient(handles.serverID,'GetData',idFilePlay,'FileSize');

% [idhrtfR namehrtfR]=AlgoFlexClient(handles.serverID,'Create','MatrixPlayer',0,1);
% AlgoFlexClient(handles.serverID,'Help','MatrixPlayer');
% AlgoFlexClient(handles.serverID,'SetData',idhrtfR,'Samples',handles.hrtfR);
% AlgoFlexClient(handles.serverID,'SetData',idhrtfR,'PlaybackMode','repeat');
% 
% 
% [idhrtfL namehrtfL]=AlgoFlexClient(handles.serverID,'Create','MatrixPlayer',0,1);
% AlgoFlexClient(handles.serverID,'Help','FilePlayer');
% AlgoFlexClient(handles.serverID,'SetData',idhrtfL,'Samples',handles.hrtfL);
% AlgoFlexClient(handles.serverID,'SetData',idhrtfL,'PlaybackMode','repeat');


% Delays
[handles.idDelayL handles.nameDelayL] = AlgoFlexClient(handles.serverID,'Create','Delay',1,1);
AlgoFlexClient(handles.serverID,'Help','Delay');
AlgoFlexClient(handles.serverID,'SetData',handles.idDelayL,'DelayTime',handles.TdelayL);

[handles.idDelayR handles.nameDelayR] = AlgoFlexClient(handles.serverID,'Create','Delay',1,1);
AlgoFlexClient(handles.serverID,'Help','Delay');
AlgoFlexClient(handles.serverID,'SetData',handles.idDelayR,'DelayTime',handles.TdelayR);


% [idProd nameProd] = AlgoFlexClient(handles.serverID,'Create','Prod',2,1);
% AlgoFlexClient(handles.serverID,'SetData',idProd,'Mode','Numerical');
% AlgoFlexClient(handles.serverID,'Help','ParmProdSum');
%AlgoFlexClient(serverID,'SetData',idProd,'ParmX1',IID_L)
%AlgoFlexClient(serverID,'SetData',idProd,'ParmX2','Prod')

% :::::::: Route audio :::::::::
% 
% AlgoFlexClient(handles.serverID,'ConnectAudio',idAudioIn, [1 2],idDelay,[1 2]);
% AlgoFlexClient(handles.serverID,'ConnectAudio',idDelay, [1 2],idAudioOut,[1 2]);
%AlgoFlexClient(handles.serverID,'ConnectAudio',idFilePlay, [1 2],idAudioOut,[1 2]);

% Music to delay
% AlgoFlexClient(handles.serverID,'ConnectAudio',idFilePlay, 1,handles.idDelayL,1);
% AlgoFlexClient(handles.serverID,'ConnectAudio',idFilePlay, 2,handles.idDelayR,1);
% :::::::: UMIK MIC ::::::::::
AlgoFlexClient(handles.serverID,'ConnectAudio',idAudioIn, 1,idChanCombL,1);
AlgoFlexClient(handles.serverID,'ConnectAudio',idAudioIn, 2,idChanCombR,1);
% :::::::: UMIK MIC ::::::::::

% :::::::: ORIGINAL ::::::::::
AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idMatPlayer, 1,idChanCombL,2);
AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idMatPlayer, 2,idChanCombR,2);
% :::::::: ORIGINAL ::::::::::

AlgoFlexClient(handles.serverID,'ConnectAudio',idChanCombL, 1,handles.idDelayL,1);
AlgoFlexClient(handles.serverID,'ConnectAudio',idChanCombR, 1,handles.idDelayR,1);

% AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idDelayL, 1,idAudioOut,1);
% AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idDelayR, 1,idAudioOut,2);

AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idDelayL, 1,handles.idGainL,1);
AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idDelayR, 1,handles.idGainR,1);

AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idGainL, 1,handles.idConvL,1);
AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idGainR, 1,handles.idConvR,1);

% AlgoFlexClient(handles.serverID,'ConnectAudio',idhrtfL, 1,idConvL,2);
% AlgoFlexClient(handles.serverID,'ConnectAudio',idhrtfR, 1,idConvR,2);

AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idConvL, 1,idAudioOut,1);
AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idConvR, 1,idAudioOut,2);

AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idMatPlayer,1,handles.idMatRec,1);
AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idMatPlayer,2,handles.idMatRec,2);
AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idDelayL,1,handles.idMatRec,3);
AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idDelayR,1,handles.idMatRec,4);
AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idGainL,1,handles.idMatRec,5);
AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idGainR,1,handles.idMatRec,6);
AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idConvL,1,handles.idMatRec,7);
AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idConvR,1,handles.idMatRec,8);

AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idConvL,2,handles.idMatRecFil,1);
AlgoFlexClient(handles.serverID,'ConnectAudio',handles.idConvR,2,handles.idMatRecFil,2);


% :::: Set Exe sequence ::::::
AlgoFlexClient(handles.serverID,'SetExeSeq',[handles.idMatRec handles.idMatRecFil idAudioIn handles.idMatPlayer idChanCombL idChanCombR handles.idDelayL handles.idDelayR handles.idGainL handles.idGainR handles.idConvL handles.idConvR idAudioOut]);


% :::: start ::::::::
AlgoFlexClient(handles.serverID,'SetSampleRate',handles.fs);
AlgoFlexClient(handles.serverID,'MultiStart');



guidata(hObject,handles)



% --- Executes on button press in pushbutton3.
function STOP_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ::::::::::: Make AlgoFlex blockdiagram :::::::::::::
%AlgoFlexClient(handles.serverID,'GenerateGraph',{},{},'Audio+Parms',50,'png','C:\tmp\3DAUTE_parms')
% ::::::::::: Make AlgoFlex blockdiagram :::::::::::::

AlgoFlexClient(handles.serverID,'SetData',handles.idMatPlayer,'PlaybackMode','standby');
AlgoFlexClient(handles.serverID,'Help','MatrixRecorder');
AlgoFlexClient(handles.serverID,'SetData',handles.idMatRec,'RecordMode','standby');
AlgoFlexClient(handles.serverID,'SetData',handles.idMatRecFil,'RecordMode','standby');

% ::::::::::: Make AlgoFlex blockdiagram :::::::::::::
%AlgoFlexClient(handles.serverID,'GenerateGraph',{},{},'Audio',50,'png','C:\tmp\3DAUTE_Audio')
% ::::::::::: Make AlgoFlex blockdiagram :::::::::::::


AlgoFlexClient(handles.serverID,'Stop');



MatRecData = AlgoFlexClient(handles.serverID,'GetData',handles.idMatRec,'Samples');
MatRecDataFil = AlgoFlexClient(handles.serverID,'GetData',handles.idMatRecFil,'Samples');
    save('Test.mat','MatRecData','MatRecDataFil');
    
   DataAnalysis(MatRecData,MatRecDataFil); 

AlgoFlexClient(handles.serverID,'DestroyAll');
AlgoFlexClient(handles.serverID,'Quit');
%Update handles structure
guidata(hObject,handles)

function DataAnalysis(MatRecData,MatRecDataFil)
close all
 
 fs=48000;
 t=0:1/fs:10-1/fs;

figure()
subplot(4,1,1)
plot(t,MatRecData(:,1),'b',t,MatRecData(:,2),'r')
grid on
title('MatPlayer output')
legend('Left ear','Rigth ear')
subplot(4,1,2)
plot(t,MatRecData(:,3),'b',t,MatRecData(:,4),'r')
grid on
title('Delay output')
subplot(4,1,3)
plot(t,MatRecData(:,5),'b',t,MatRecData(:,6),'r')
grid on
title('Gain output')
subplot(4,1,4)
plot(t,MatRecData(:,7),'b',t,MatRecData(:,8),'r')
grid on
title('Fx output')


figure()
plot(MatRecDataFil(:,1),'b')
hold on
plot(MatRecDataFil(:,2),'r')
grid on
title('HRTF Filter taps')
xlabel('Samples')
ylabel('Amplitude in gg')
ylim([-1 2])
legend('Left ear','Right ear')

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
%% Make graph
% clc
% AlgoFlexClient(handles.serverID,'GenerateGraph',{},{},'Audio+Parms',50,'png','C:\tmp\3DAUTE')


