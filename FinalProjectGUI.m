function varargout = FinalProjectGUI(varargin)
% FINALPROJECTGUI MATLAB code for FinalProjectGUI.fig
%      FINALPROJECTGUI, by itself, creates a new FINALPROJECTGUI or raises the existing
%      singleton*.
%
%      H = FINALPROJECTGUI returns the handle to a new FINALPROJECTGUI or the handle to
%      the existing singleton*.
%
%      FINALPROJECTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINALPROJECTGUI.M with the given input arguments.
%
%      FINALPROJECTGUI('Property','Value',...) creates a new FINALPROJECTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FinalProjectGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FinalProjectGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FinalProjectGUI

% Last Modified by GUIDE v2.5 18-Nov-2018 17:05:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FinalProjectGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @FinalProjectGUI_OutputFcn, ...
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


% --- Executes just before FinalProjectGUI is made visible.
function FinalProjectGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FinalProjectGUI (see VARARGIN)

% Choose default command line output for FinalProjectGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FinalProjectGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FinalProjectGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% I created three global variables through which I can differentiate
% between the two dimensions as well as between the media of the
% environment
global dimension;
global kenv;
global srate;

% if the user chose dimensionality of 1 
if (dimension == 1)
    % create an array holding time values for the gaussian function (maybe
    % change it so that it is not negative)
    t = -9.99:0.01:10;
    
    % create a time variable that will be used fot the functions of the
    % temperatures of the environment and the object
    time = 0;
    
    % create a variable for the standard deviation
    s = 0.1;
    
    % make a variable for the (initial) temperatures of the object and the
    % environment
    objectTi = 50;
    envirTi = 20;
    
    % create an animation loop that will run as long as the object's
    % temperature is higher than that of the environment
    while objectTi > envirTi
        % increment the time by 1 for every iteration
        time = time + 1;
        
        % update the gaussian function with the new temperature and time 
        % values 
        T = (objectTi) .* exp( -1 .* ((t .^ 2) ./ (2 * s ^ 2)));
        
        % initialize and constantly update the temperature difference
        % between the object and environment
        difference = abs(objectTi - envirTi);
        
        % update the object's and the environment's temperature using their
        % corresponding functions
        objectTi = heatDispersion(objectTi, time);
        envirTi = heatDispersionEnv(envirTi, time, kenv);
        
        % update the standard deviation of the gaussian graph to make it
        % wider and wider
        s = s + s/(srate * difference);
        
        % plot the updated gaussian function on a fixed axis
        plot(t, T)
        axis([-2, 2, 0, 50])
        
        % label the axes
        ylabel('Temperature (Celsius)');
        xlabel('Distance from object (meters)');
        drawnow
        
        % update the temperature that the text box is displaying
        set(handles.Temp,'String', objectTi);
    end
    
% if the user chose dimensionality of 2 
elseif (dimension == 2)
    % create 2 time arrays since there are 2 axis which the gaussian
    % depends on
    tx = -1.99:0.01:2;
    ty = -1.99:0.01:2;
    
    % create a meshgrid that will be used to set the x and y axis for the
    % graph
    [X, Y] = meshgrid(-9.99:0.1:10);
    time = 0;
    
    % create two standard deviation variables, one for the x and one for
    % the y axis
    sx = 0.65;
    sy = 0.65;
    
    % intialize the initial temperatures of the object and the environment
    objectTi = 50;
    envirTi = 20;
    
    % set the colormap to hot so that it gives the impression that the
    % object is indeed hot
    colormap('hot');
    
    % create the same animation loop as for a dimensionality of 1
    while objectTi > envirTi
        time = time + 1;
        
        % update temperature displayed in the graph using a two dimansional
        % gaussian function
        T = (objectTi) .* exp( -1 .* ((X .^ 2) ./ (2 * sx ^ 2)) - ((Y .^ 2) ./ (2 * sy ^ 2)));
        
        % this is the same as for the 1D version
        difference = abs(objectTi - envirTi);
        objectTi = heatDispersion(objectTi, time);
        envirTi = heatDispersionEnv(envirTi, time, kenv);
        
        % update both standard deviations
        sx = sx + sx/(srate * difference);
        sy = sy + sy/(srate * difference);
        
        % graph the function using the surf command
        surf(X,Y,T)
        
        % change the shading to make the surface smooth
        shading('interp');
        
        % keep the axis fixed
        axis([-10, 10, -10, 10, 0, 50]);
        
        % label the axes
        ylabel('y Distance from object (meters)');
        xlabel('x Distance from object (meters)');
        zlabel('Temperature (Celsius)');
        
        drawnow
        set(handles.Temp,'String', objectTi);
    end
end

% --- Executes on button press in TwoDimensions.
function TwoDimensions_Callback(hObject, eventdata, handles)
% hObject    handle to TwoDimensions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TwoDimensions

% create a global variable for the dimensionality so that it can be used to
% distinguish which animation loop should be used when the simulate button
% is pressed
global dimension ;
if (get(hObject,'Value'))
    dimension = 2;
end

% --- Executes on selection change in Media.
function Media_Callback(hObject, eventdata, handles)
% hObject    handle to Media (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Media contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Media

% create two global variables, one for the increase/decay constant that 
% will be used for in the exponential functions for the temperatures of the
% object and environment and the other a constant that will change the rate
% of increase of the standard deviation to prevent the graph from becoming
% flat too early or too late
global kenv;
global srate;

% create a cell that will contain the media options for the environment
contents = cellstr(get(hObject,'String'));

% assign different values to the global variables depending on the media
% that is chosen by the user
if strcmp(contents{get(hObject,'Value')}, 'Air')
    kenv = 0.000004;
    srate = 8;
end

if strcmp(contents{get(hObject,'Value')}, 'Water')
    kenv = 0.0000008;
    srate = 15;
end

% --- Executes during object creation, after setting all properties.
function Media_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Media (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OneDimension.
function OneDimension_Callback(hObject, eventdata, handles)
% hObject    handle to OneDimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of OneDimension

% create a global variable for the dimensionality so that it can be used to
% distinguish which animation loop should be used when the simulate button
% is pressed
global dimension ;
if (get(hObject,'Value'))
    dimension = 1;
end
