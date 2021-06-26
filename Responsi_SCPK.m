function varargout = Responsi_SCPK(varargin)
% RESPONSI_SCPK MATLAB code for Responsi_SCPK.fig
%      RESPONSI_SCPK, by itself, creates a new RESPONSI_SCPK or raises the existing
%      singleton*.
%
%      H = RESPONSI_SCPK returns the handle to a new RESPONSI_SCPK or the handle to
%      the existing singleton*.
%
%      RESPONSI_SCPK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSI_SCPK.M with the given input arguments.
%
%      RESPONSI_SCPK('Property','Value',...) creates a new RESPONSI_SCPK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Responsi_SCPK_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Responsi_SCPK_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Responsi_SCPK

% Last Modified by GUIDE v2.5 25-Jun-2021 22:55:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Responsi_SCPK_OpeningFcn, ...
                   'gui_OutputFcn',  @Responsi_SCPK_OutputFcn, ...
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


% --- Executes just before Responsi_SCPK is made visible.
function Responsi_SCPK_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Responsi_SCPK (see VARARGIN)

% Choose default command line output for Responsi_SCPK
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Responsi_SCPK wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Responsi_SCPK_OutputFcn(hObject, eventdata, handles) 
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
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = (1);
data1 = readmatrix('DATA RUMAH.xlsx',opts);

opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = (3:8);
data2 = readmatrix('DATA RUMAH.xlsx',opts);

data = [data1 data2];
set(handles.uitable1,'data',data);


opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = (3:8);
x = readmatrix('DATA RUMAH.xlsx',opts);
k=[0,1,1,1,1,1];%nilai atribut, dimana 0= atribut biaya &1= atribut keuntungan
w=[0.30,0.20,0.23,0.10,0.07,0.10];% bobot untuk masing-masing kriteria

%normalisasi matriks
[m n]=size (x); %matriks m x n dengan ukuran sebanyak variabel x (input)
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
for j=1:n,
    if k(j)==1, %statement untuk kriteria dengan atribut keuntungan
        R(:,j)=x(:,j)./max(x(:,j));
    else
        R(:,j)=min(x(:,j))./x(:,j);
    end;
end;

%proses perangkingan
for i=1:m,
 V(i)= sum(w.*R(i,:));
end;

Vtranspose=V.';
Vtranspose=num2cell(Vtranspose);
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = (2);
x2= readtable('DATA RUMAH.xlsx',opts);
x2 = table2cell(x2);
x2=[x2 Vtranspose];
x2=sortrows(x2,-2);
x2 = x2(:,1);

set(handles.uitable2, 'data', x2);

