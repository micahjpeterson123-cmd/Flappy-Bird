 function varargout = flappybirdgui(varargin)
% FLAPPYBIRDGUI MATLAB code for flappybirdgui.fig
%      FLAPPYBIRDGUI, by itself, creates a new FLAPPYBIRDGUI or raises the existing
%      singleton*.
%
%      H = FLAPPYBIRDGUI returns the handle to a new FLAPPYBIRDGUI or the handle to
%      the existing singleton*.
%
%      FLAPPYBIRDGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FLAPPYBIRDGUI.M with the given input arguments.
%
%      FLAPPYBIRDGUI('Property','Value',...) creates a new FLAPPYBIRDGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before flappybirdgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to flappybirdgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help flappybirdgui

% Last Modified by GUIDE v2.5 06-May-2024 18:24:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @flappybirdgui_OpeningFcn, ...
                   'gui_OutputFcn',  @flappybirdgui_OutputFcn, ...
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


% --- Executes just before flappybirdgui is made visible.
function flappybirdgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to flappybirdgui (see VARARGIN)

% Choose default command line output for flappybirdgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes flappybirdgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = flappybirdgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Load pipe images
pipea = imread('PIPE.png');
pipeb = flipud(imread('PIPE.png'));
piped = imread('PIPE.png');
pipee = flipud(imread('PIPE.png'));

global v;
N = 100;                  % Number of grid points
c = 1;                    % Wave speed
L = 2;                    % Length of domain
h = L/N;                  % Space grid size
x = -L/2+h/2+(0:N-1)*h;  % Space coordinate
tau = 0.02;

ii = 2:N-1;   % Index counters (periodic BC)
ip = 3:N;     % i+1 values for vector ii
im = 1:N-2;   % i-1 values for vector ii

% Define initial pipe positions (flat/offscreen)
a = x.*0 + 1.5;
b = x.*0 - 1;
d = x.*0 + 1.5;
e = x.*0 - 1;

y = 0.25;
v = 5;

set(handles.start,      'Visible', 'off');
set(handles.graph,      'Visible', 'on');
set(handles.flap,       'Visible', 'on');
set(handles.again,      'Visible', 'off');
set(handles.score,      'Visible', 'on');
set(handles.scoredisp,  'Visible', 'on');
set(handles.group,      'Visible', 'off');
set(handles.charselecter,'Visible','off');
set(handles.chartex,    'Visible', 'off');

coeff_ftcs = c*tau/(2.*h);
i = 0;
j = 0;
first = 0;
prog = 0;
speed = 0.05;
t = 0;

global death; global start; global flap;

character = get(handles.charselecter, 'Value');

if (character == 1)
    img = imread('BIRD3.png');
    [s, ss] = audioread('windows-xp-startup.mp3');
    start = audioplayer(s, ss); play(start);
    [ff, fff] = audioread('sfx_wing.mp3');
    flap = audioplayer(ff, fff);
    [dd, ddd] = audioread('error.mp3');
    death = audioplayer(dd, ddd);
elseif (character == 2)
    img = imread('Ross.png');
    [s, ss] = audioread('virtually.mp3');
    start = audioplayer(s, ss); play(start);
    [ff, fff] = audioread('Coffee.mp3');
    flap = audioplayer(ff, fff);
    [dd, ddd] = audioread('rossbye.mp3');
    death = audioplayer(dd, ddd);
elseif (character == 3)
    img = imread('Sam.png');
    [s, ss] = audioread('clash-royale-hog-rider.mp3');
    start = audioplayer(s, ss); play(start);
    [ff, fff] = audioread('vineboom.mp3');
    flap = audioplayer(ff, fff);
    [dd, ddd] = audioread('emotional-damage-meme.mp3');
    death = audioplayer(dd, ddd);
elseif (character == 4)
    img = imread('Lindquist.png');
    [s, ss] = audioread('dance-moves.mp3');
    start = audioplayer(s, ss); play(start);
    [ff, fff] = audioread('fortnite-gun-shot-sound.mp3');
    flap = audioplayer(ff, fff);
    [dd, ddd] = audioread('knocked-loud.mp3');
    death = audioplayer(dd, ddd);
elseif (character == 5)
    img = imread('Stein.png');
    [s, ss] = audioread('billnyeopener.mp3');
    start = audioplayer(s, ss); play(start);
    [ff, fff] = audioread('bill.mp3');
    flap = audioplayer(ff, fff);
    [dd, ddd] = audioread('metal-pipe-clang.mp3');
    death = audioplayer(dd, ddd);
elseif (character == 6)
    img = imread('Abel.png');
    [s, ss] = audioread('okay.mp3');
    start = audioplayer(s, ss); play(start);
    [ff, fff] = audioread('pufferfish.mp3');
    flap = audioplayer(ff, fff);
    [dd, ddd] = audioread('abeldeath.mp3');
    death = audioplayer(dd, ddd);
end

img = flipud(img);

% --- Set up axes ONCE before the loop ---
ax = handles.graph;
cla(ax);
hold(ax, 'on');
ylim(ax, [-1 1.5]);
xlim(ax, [0, 0.8]);
axis(ax, 'off');

% Create wave line objects ONCE (update YData each frame instead of reploting)
ha_line = line(ax, x, a, 'Color', 'g');
hb_line = line(ax, x, b, 'Color', 'g');
hd_line = line(ax, x, d, 'Color', 'g');
he_line = line(ax, x, e, 'Color', 'g');

% Compute initial pipe tip positions
[Ma, Ia] = min(a);
[Mb, Ib] = max(b);
[Md, Id] = min(d);
[Me, Ie] = max(e);

% Create image objects ONCE (update XData/YData each frame instead of delete/recreate)
img_h   = image(ax, [0.1-0.03, 0.1+0.03], [y-0.1, y+0.1], img);
pipea_h = image(ax, [x(Ia)-0.08, x(Ia)+0.08], [Ma,  1.5], pipea);
pipeb_h = image(ax, [x(Ib)-0.08, x(Ib)+0.08], [-1,  Mb],  pipeb);
piped_h = image(ax, [x(Id)-0.08, x(Id)+0.08], [Md,  1.5], piped);
pipee_h = image(ax, [x(Ie)-0.08, x(Ie)+0.08], [-1,  Me],  pipee);

drawnow;

%%%%%%%%%%%%
%% Main game loop
while(1)
    y = y + v*tau;
    if(y < -1)
        break;
    end
    if(j == 1)
        if(y > a(56) || y < b(56))
            break;
        end
    end
    if(j == 0)
        if(y > d(56) || y < e(56))
            break;
        end
    end
    v = v + -29.4*tau;

    % Lax method - advance wave equations
    a(ii) = (1/2)*(a(im) + a(ip)) + coeff_ftcs*(a(ip)-a(im));
    b(ii) = (1/2)*(b(im) + b(ip)) + coeff_ftcs*(b(ip)-b(im));
    d(ii) = (1/2)*(d(im) + d(ip)) + coeff_ftcs*(d(ip)-d(im));
    e(ii) = (1/2)*(e(im) + e(ip)) + coeff_ftcs*(e(ip)-e(im));

    % Compute pipe tip positions
    [Ma, Ia] = min(a);
    [Mb, Ib] = max(b);
    [Md, Id] = min(d);
    [Me, Ie] = max(e);

    % Update wave lines (no delete/recreate — just set new data)
    set(ha_line, 'YData', a);
    set(hb_line, 'YData', b);
    set(hd_line, 'YData', d);
    set(he_line, 'YData', e);

    % Update image positions (no delete/recreate — just move them)
    set(img_h,   'XData', [0.1-0.03,      0.1+0.03],      'YData', [y-0.1,  y+0.1]);
    set(pipea_h, 'XData', [x(Ia)-0.08,    x(Ia)+0.08],    'YData', [Ma,     1.5]);
    set(pipeb_h, 'XData', [x(Ib)-0.08,    x(Ib)+0.08],    'YData', [-1,     Mb]);
    set(piped_h, 'XData', [x(Id)-0.08,    x(Id)+0.08],    'YData', [Md,     1.5]);
    set(pipee_h, 'XData', [x(Ie)-0.08,    x(Ie)+0.08],    'YData', [-1,     Me]);

    % Flush graphics in sync with physics, then pace the loop
    drawnow;
    pause(speed);

    i = i + 1;
    if(i == 40)
        r = randi([1 5]);
        if(r == 1);     amp = 0;
        elseif(r == 2); amp = 0.5;
        elseif(r == 3); amp = 1;
        elseif(r == 4); amp = 1.5;
        elseif(r == 5); amp = 2;
        end
        if(j == 0)
            a = -1*(amp./cosh(10*(x - 0.9).^2/h).^2 - 1.5);
            b = (2 - amp)./cosh(10*(x - 0.9).^2/h).^2 - 1.0;
            j = 1; i = 0;
        elseif(j == 1)
            d = -1*(amp./cosh(10*(x - 0.9).^2/h).^2 - 1.5);
            e = (2 - amp)./cosh(10*(x - 0.9).^2/h).^2 - 1.0;
            j = 0; i = 0;
        end
    end

    t = t + 1;
    if(t == 80 && first == 0)
        num = str2double(get(handles.score,'String'));
        set(handles.score, 'String', sprintf('%d', num + 1));
        first = 1; t = 0; prog = prog + 1;
    elseif(t == 40 && first == 1)
        num = str2double(get(handles.score,'String'));
        set(handles.score, 'String', sprintf('%d', num + 1));
        t = 0; prog = prog + 1;
    end

    if(prog == 5)
        speed = speed * 0.9;
        prog = 0;
    end
end

play(death);
set(handles.again,       'Visible', 'on');
set(handles.group,       'Visible', 'on');
set(handles.charselecter,'Visible', 'on');
set(handles.chartex,     'Visible', 'on'); 

% --- Executes on button press in flap.
function flap_Callback(hObject, eventdata, handles)
% hObject    handle to flap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global v; global flap;
play(flap);
if(get(handles.easy, 'Value') == 1)
    if(v > 0)
        v = v + 2;
    else
        v = 3;
    end
elseif(get(handles.medium, 'Value') == 1)
    v = 5.5;
else
    v = 8;
end

% --- Executes on button press in again.
function again_Callback(hObject, eventdata, handles)
% hObject    handle to again (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.score, 'String', 0);
start_Callback(@start_Callback, eventdata, handles);

% --- Executes on selection change in charselecter.
function charselecter_Callback(hObject, eventdata, handles)
% hObject    handle to charselecter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns charselecter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from charselecter

% --- Executes during object creation, after setting all properties.
function charselecter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to charselecter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
