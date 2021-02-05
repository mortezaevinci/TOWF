function outputhandle = previewout(obj, targetImage)
%previewout Display previewout of live video data.
% 
%    previewout(OBJ) creates a Video previewout window that displays live video
%    data for video input object OBJ. The window also displays the timestamp
%    and video resolution of each frame, and the current status of OBJ. The
%    Video previewout window displays the video data at 100% magnification (one 
%    screen pixel represents one image pixel). The size of the previewout image
%    is determined by the value of the video input object ROIPosition 
%    property.
%
%    The Video previewout window displays image data in its native color space,
%    indicated by the default value of the video input object 
%    ReturnedColorSpace property. To determine this value, use PROPINFO. 
%
%    The Video previewout window remains active until it is either stopped using
%    STOPpreviewout or closed using CLOSEpreviewout. If you delete the object, 
%    DELETE(OBJ), the Video previewout window stops previewouting and closes
%    automatically.
%    
%    previewout(OBJ, HIMAGE) displays live video data for video input object
%    OBJ in the image object specified by the handle HIMAGE. previewout scales
%    the image data to fill the entire area of the image object but does not
%    modify the values of any image object properties. Use this syntax to  
%    previewout video data in a custom GUI of your own design (see Examples).
%
%    HIMAGE = previewout(...) returns HIMAGE, a handle to the image object 
%    containing the previewouted data. To obtain a handle to the figure window
%    containing the image object, use ANCESTOR. For more information about 
%    using image objects, see IMAGE. See the Custom Update Function section
%    for more information about the image object returned.
%
%    Notes
%    -----
%     
%    The behavior of the Video previewout window depends on the object's current
%    state and trigger configuration.
%    
%       State           Video previewout Window Behavior
%    ----------------------------------------------------------------------
%     Running=off    Displays a live view of the image being acquired from
%                    the device, for all trigger types. The image is updated 
%                    to reflect changes made to configurations of video 
%                    input object properties. (The FrameGrabInterval 
%                    property is ignored until a trigger occurs.)
%
%     Running=on     If TriggerType is set to immediate or manual, the Video
%                    previewout window continues to update the image displayed.
%                    If TriggerType is set to hardware, the Video previewout 
%                    window stops updating the image until a trigger
%                    occurs.
%     
%     Logging=on     The Video previewout window might drop some data frames,
%                    but this will not affect the frames logged to memory 
%                    or disk.
%
%    Custom Update Function
%    ----------------------
%    If you specify the image object where you want previewout to display  
%    video data, you can also specify a function that previewout calls every
%    time a new frame is available. previewout assigns application-defined data,
%    specified by the name 'UpdatepreviewoutWindowFcn', to the image object, 
%    HIMAGE. Using the SETAPPDATA function, you can set the value of 
%    'UpdatepreviewoutWindowFcn' to a function handle that previewout invokes 
%    every time a new image frame is available. You can use this function to
%    perform custom processing of the previewouted image data. If 
%    'UpdatepreviewoutWindowFcn' is configured to [] (the default), previewout 
%    ignores it. If it is configured to any other value, previewout errors.
%
%    NOTE: When you specify an ‘UpdatepreviewoutWindowFcn’ function, your 
%    function is responsible for displaying video data in the image object.
%    Your function can process the data before displaying it, after
%    displaying it, or both. Use this code to display the data:
%
%        set(HIMAGE, 'CData', event.Data)
%
%    When previewout invokes the update function you specify, it passes three 
%    arguments:
%
%        OBJ         The video input object being previewouted
%        EVENT       An event structure with image frame information
%        HIMAGE      The handle to the image object being updated
%
%    The event structure contains all of the following fields:
%
%        Data        Current image frame specified as an H-by-W-by-B array,
%                    where H and W are the image height and width, as 
%                    specified in the ROIPosition property, and B is the 
%                    number of color bands, as specified in the NumberOfBands
%                    property.
%        Resolution  String specifying current image width and height, as 
%                    defined by the ROIPosition property.
%        Status      String describing the acquisition status.
%        Timestamp   String specifying the timestamp associated with the 
%                    current image frame.
%
%    Examples
%       % Create a customized GUI.
%       figure('Name', 'My Custom previewout Window');
%       uicontrol('String', 'Close', 'Callback', 'close(gcf)');
%
%       % Create an image object for previewouting.
%       vidRes = get(obj, 'VideoResolution');
%       nBands = get(obj, 'NumberOfBands');
%       hImage = image( zeros(vidRes(2), vidRes(1), nBands) );
%       previewout(obj, hImage);
%    
%    See also ANCESTOR, FUNCTION_HANDLE, IMAGE, IMAQHELP,  
%    IMAQDEVICE/CLOSEpreviewout, IMAQDEVICE/STOPpreviewout, 
%    IMAQDEVICE/PROPINFO, IMAQDEVICE/START, 
%    IMAQDEVICE/TRIGGER, IMAQDEVICE/DELETE.

%    CP 9-01-01
%    Copyright 2001-2008 The MathWorks, Inc.
%    $Revision: 1.1.6.20 $  $Date: 2008/06/16 16:40:54 $

% Error checking.
if ~isa(obj, 'imaqdevice'),
    errID = 'imaq:previewout:invalidType';
    error(errID, imaqgate('privateMsgLookup',errID));
elseif ~all(isvalid(obj)),
    errID = 'imaq:previewout:invalidOBJ';
    error(errID, imaqgate('privateMsgLookup',errID));
end

if nargin==2
    % Verify HIMAGE passed in is valid.
    if ~isvector(targetImage) || ~all( ishandle(targetImage) ) || ...
            length(targetImage) ~= length(obj) || ...
            ~all( strcmpi( get(targetImage, 'Type'), 'image' ) )
        errID = 'imaq:previewout:invalidHIMAGE';
        error(errID, imaqgate('privateMsgLookup',errID));
    end
end

% Access the internal UDD object.
uddobj = imaqgate('privateGetField', obj, 'uddobject');

% Use the obsolete window if need be.
if imaqmex('feature', '-useObsoletepreviewout')
    previewout(uddobj);
    
    % Only assign the output LHS if one was specified. This
    % avoids having ANS appear every time previewout is called.
    if nargout>0
        outputhandle = [];
    end
    return;
end

% Do not preallocate this array since the number of image objects 
% we return may be less than the number of objects, i.e. if some 
% objects error out upon calling previewout on them.
hImageArray = [];

% For each object, try to activate a previewout window.
alreadyWarned = false;
isSingleton = (length(uddobj)==1);
for index=1:length(uddobj)
    try
        if nargin==2
            % First check the target image is not already 
            % associated with another object.
            trgtClients = localFindTargetClients( uddobj(index), targetImage(index) );
            if ~isempty(trgtClients);
                % Target image is being used by another object.
                errID = 'imaq:previewout:noTargetReuse';
                error(errID, imaqgate('privateMsgLookup',errID));
            end
            
            currentImage = localpreviewout( uddobj(index), targetImage(index) );
        else
            currentImage = localpreviewout( uddobj(index), [] );
        end
        hImageArray = [hImageArray; currentImage]; %#ok<AGROW>
    catch previewoutError
        % Error if we're dealing with a 1x1 object, otherwise warn.
        if isSingleton
            throw(previewoutError);
        elseif ~alreadyWarned
            msgID = 'imaq:previewout:openFailed';
            warnState = warning('off', 'backtrace');
            warning(msgID, [imaqgate('privateMsgLookup', msgID), ...
                sprintf('\n') previewoutError.message]);
            warning(warnState);
            alreadyWarned = true;
        end
    end
end

% Only assign the output LHS if one was specified. This 
% avoids having ANS appear every time previewout is called.
if nargout>0
    outputhandle = hImageArray;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function outputhandle = localpreviewout(uddobj, targetImage)

% Access the handle settings.
handles = localGetHandles(uddobj, targetImage);
if strcmpi( get(uddobj, 'previewouting') , 'on')
    % Give the active window focus.
    figure(handles.Figure);
    outputhandle = handles.Image;
    return;
end

% Verify object is in a previewoutable state before creating a new window.
% The device might be in use by another previewout window.
if ishardwareactive(uddobj)
    errID = 'imaq:previewout:deviceInUse';
    error(errID, imaqgate('privateMsgLookup',errID));
end

% If no window has already been created before calling
% previewout, the object needs a default one created.
if isempty(handles.Figure)
    % Make sure we're not being called from a deployed application.
    if isdeployed
        errID = 'imaq:previewout:noDeployment';
        error(errID, imaqgate('privateMsgLookup',errID));
    end
    
    % Create the default previewout window.
    handles = localCreateDefaultWindow(uddobj, handles);
end

% Configure the figure's colormap.
localConfigureColormap(uddobj, handles);

% Setup HG components for optimal performance.
localSetupHGComponents(uddobj, handles);

% Configure the image object's app data.
localSetImageAppData(uddobj, handles);

% Configure our object with the callbacks and handles.
set(uddobj, 'ZZZUpdatepreviewoutFcn', @localUpdateWindow);
set(uddobj, 'ZZZUpdatepreviewoutStatusFcn', @localUpdateDefaultStatus);
set(uddobj, 'ZZZpreviewoutWindowHandles', handles);

% Pop the figure forward.
figure(handles.Figure);

% Initiate the data stream.
previewout(uddobj);

% Assign output.
outputhandle = handles.Image;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALLBACK FUNCTIONS FOR DEFAULT & CUSTOM WINDOWS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function localUpdateDefaultStatus(uddobj, event)

% Update the previewout window status.
handles = get(uddobj, 'ZZZpreviewoutWindowHandles');

if isempty(handles)
    return;
end

if handles.isDefaultWindow
    % Update the status message only. Timestamp and
    % resolution is only handled when there is actual
    % data available.
    set(handles.StatusFields.Status, 'String', event.Data.Status);
else
    % We're either dealing with an intermediate custom
    % window, or an advanced custom window.
    try
        % Invoke the user's function, i.e. handle the
        % advanced custom window case first.
        event.Data.Data = get(handles.Image, 'CData');
        localInvokeAppData(uddobj, event.Data, handles.Image);
    catch updateMessageError
        throw(updateMessageError);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function localUpdateWindow(uddobj, event)
% Extract our handles.
handles = get(uddobj, 'ZZZpreviewoutWindowHandles');

if handles.isDefaultWindow
    % We're dealing with the default previewout window.
    try
        % Update the image data.
        set(handles.Image, 'CData', event.Data.Data);

        % Retarget the scroll panel's image in case the image size changed.
        handles = localRetargetDefaultImage(handles, uddobj);
        set(uddobj, 'ZZZpreviewoutWindowHandles', handles);

        % Update the status bar.
        set(handles.StatusFields.Time, 'String', event.Data.Timestamp);
        set(handles.StatusFields.Resolution, 'String', event.Data.Resolution);
        set(handles.StatusFields.Status, 'String', event.Data.Status);
    catch custompreviewoutError
        % Now that we can control the previewout window from Java, it is
        % possible to delete the underlying object in the middle of an
        % update.  If we do that, don't error since it is an expected
        % action.
        if (ishandle(uddobj) && isvalid(uddobj))
            msgID = 'imaq:previewout:updateImageFailed';
            error(msgID, imaqgate('privateMsgLookup', msgID), custompreviewoutError.message);
        end
    end
else
    % We're either dealing with an intermediate custom 
    % window, or an advanced custom window.
    try
        % Invoke the user's function, i.e. handle the
        % advanced custom window case first.
        fcnSpecified = localInvokeAppData(uddobj, event.Data, handles.Image);
        if ~fcnSpecified
            % No function was specified, so just update the 
            % image data, i.e. handle the intermediate custom
            % window case.
            set(handles.Image, 'CData', event.Data.Data);
        end
    catch custompreviewoutError
        throw(custompreviewoutError);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function fcnSpecified = localInvokeAppData(uddobj, eventData, hImage)

% Access the user's function handle.
usersFcn = getappdata(hImage, 'UpdatepreviewoutWindowFcn');

if isempty(usersFcn)
    % Nothing to execute.
    fcnSpecified = false;
    return;    
elseif strcmp(class(usersFcn), 'function_handle')
    % Notify the user the image was updated.
    try
        usersFcn( videoinput(uddobj), eventData, hImage );
        fcnSpecified = true;
    catch appDataError
        msgID = 'imaq:previewout:updateFunctionFailed';
        error(msgID, imaqgate('privateMsgLookup', msgID), appDataError.message);
    end    
else
    % Invalid value specified.
    msgID = 'imaq:previewout:invalidUpdateFunction';
    error(msgID, imaqgate('privateMsgLookup', msgID));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function localImageDeleteFcn(hImage, hgevent, uddobj) %#ok<INUSL,INUSL>

% Make sure the UDD object is still valid. User might be 
% closing the window after having deleted the UDD object.
if ishandle(uddobj)
    % Disconnect image handle/callback from object.
    set(uddobj, 'ZZZUpdatepreviewoutFcn', '');
    set(uddobj, 'ZZZUpdatepreviewoutStatusFcn', '');
    set(uddobj, 'ZZZpreviewoutWindowHandles', []);
    
    % Stop previewouting data.
    stoppreviewout(uddobj);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function localResizeDefaultFcn(hFig, hgevent, handles, statusCharHeight) %#ok<INUSL,INUSL>

% Determine how many character ticks we have to 
% play with in the figure.
set(handles.Figure, 'Units', 'characters');
figCharPos = get(handles.Figure, 'Position');
set(handles.Figure, 'Units', 'normalized');

% Determine how much height we have for the image panel.
availImPanelHeight = figCharPos(4) - statusCharHeight;
if availImPanelHeight <= 0
    % Not enough room to resize.
    return;
end

% Resize the image panel.
set(handles.ImagePanel, 'Units', 'characters');
set(handles.ImagePanel, ...
    'Position', [0 statusCharHeight figCharPos(3) availImPanelHeight]);
set(handles.ImagePanel, 'Units', 'normalized');

% Resize the status bar container.
set(handles.StatusContainer, 'Units', 'characters');
set(handles.StatusContainer, ...
    'Position', [0 0 figCharPos(3) statusCharHeight]);
set(handles.StatusContainer, 'Units', 'normalized');

% Determine how much width we have for the status info section.
statusPanelPos = get(handles.StatusPanels.Status, 'Position');
availStatusWidth = figCharPos(3) - statusPanelPos(1);
if availStatusWidth <= 0
    % Not enough room to resize.
    return;
end

% Stretch the status info panel to the figure's width.
set(handles.StatusPanels.Status, ...
    'Position', [statusPanelPos(1:2) availStatusWidth statusPanelPos(4)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UTILITY FUNCTIONS FOR DEFAULT & CUSTOM WINDOWS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function handles = localGetHandles(uddobj, targetImage)

% Get a hold of our handles.
handles = get(uddobj, 'ZZZpreviewoutWindowHandles');
if isempty(handles)
    % Handles is empty, i.e. handles = [].
    % Initialize them with the correct fields.
    if isempty(targetImage)
        handles = localInitHandleStructure;
    else
        handles = localInitHandleStructure(targetImage);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function handles = localInitHandleStructure(targetImage)

% Initialize the handles structure to [].
handles.Axis = [];
handles.Image = [];
handles.Figure = [];
handles.ScrollPanelParent = [];
handles.isDefaultWindow = true;
handles.ImagePanel = [];
handles.ScrollPanel = [];
handles.StatusPanels = [];
handles.StatusFields = [];
handles.StatusContainer = [];

% Check for target image.
if nargin==1
    % Initialize the handles structure based 
    % on the target image supplied.
    handles.Axis = ancestor(targetImage, 'axes');
    handles.Image = targetImage;
    handles.Figure = ancestor(targetImage, 'figure');
    
    % Scroll panel requires a uipanel or figure as the
    % scroll panel parent. For robustness, make sure this
    % is true in case the user's GUI is atypical.
    axParent = get(handles.Axis, 'Parent');
    axParentType = get(axParent, 'Type');
    if any( strcmpi( axParentType, {'figure', 'uipanel'} ) )
        handles.ScrollPanelParent = axParent;
    else
        % User's axis parent can't be used as a 
        % parent for the scroll panel. Just use the figure.
        handles.ScrollPanelParent = handles.Figure;
    end

    % Flag this as a custom window.
    handles.isDefaultWindow = false;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function objs = localFindTargetClients(uddobj, targetImage)

% Initialize.
objs = [];
allObjs = imaqfind;

% Check if no objects have a target image associated with them.  In that
% case, just return.
objsWithNoTarget = imaqfind('ZZZpreviewoutWindowHandles', []);

if (length(allObjs) == length(objsWithNoTarget))
    return;
end

% Determine the objects that have a target image association with them.
objsWithTargetIndices = [];

for curIndex = 1:length(allObjs)
    curObj = subsref(allObjs, substruct('()', curIndex));
    if ~isempty(get(curObj, 'ZZZpreviewoutWindowHandles'))
        objsWithTargetIndices(end+1) = curIndex; %#ok<AGROW>
    end
end

objsWithTarget = subsref(allObjs, substruct('()', objsWithTargetIndices));

% For each object that has a target image associated with it,
% check for any possible conflicts of 2 different objects trying
% to use the same target image.
uddobjsWithTarget = imaqgate('privateGetField', objsWithTarget, 'uddobject');
for index=1:length(uddobjsWithTarget)
    handles = get(uddobjsWithTarget(index), 'ZZZpreviewoutWindowHandles');
    
    % Exclude the object about to be previewouted, in order to 
    % allow the following scenario to succeed:
    %    x = previewout(vid);
    %    previewout(vid, x);
    if ~isequal(uddobj, uddobjsWithTarget(index)) && handles.Image==targetImage
        objs = [objs uddobjsWithTarget(index)]; %#ok<AGROW>
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function localSetImageAppData(uddobj, handles) %#ok<INUSL>

% Cache the handles as part of our image object.
setappdata(handles.Image, 'previewoutWindowHandles', handles);

% Initialize the user configurable update callback if
% it doesn't already exist. Otherwise, just leave it 
% with whatever it is currently set to.
if ~isappdata(handles.Image, 'UpdatepreviewoutWindowFcn')
    setappdata(handles.Image, 'UpdatepreviewoutWindowFcn', []);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function localSetupHGComponents(uddobj, handles)

% Configure the image object. 
%
% The image object must be set up with the appropriate CData size,
% otherwise a portion of the image will be shown. Secondly, the image
% object, MUST be set up first so that the axes scale correctly. Otherwise,
% the image won't scale correctly with axes limit modes turned to manual.

% Determine the number of bands for the CData
if strcmp(get(uddobj, 'ReturnedColorSpace'), 'grayscale')
    numBands = 1;
else
    numBands = 3;
end

roi = get(uddobj, 'ROIPosition');
set(handles.Image, {'CData', 'DeleteFcn'}, ...
    {zeros(roi(4), roi(3), numBands, 'uint8'), {@localImageDeleteFcn, uddobj} });

% Configure the axis and image for optimal refresh. This 
% should be done regardless whose HG components we're using.
set(handles.Axis, 'Visible', 'off', 'CLimMode', 'manual', 'CLim', [0 255],...
    'ALimMode', 'manual', 'XLimMode', 'manual', 'YLimMode', 'manual', ...
    'ZLimMode', 'manual', 'XTickMode', 'manual', 'YTickMode', 'manual', ...
    'ZTickMode', 'manual');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function localConfigureColormap(uddobj, handles) %#ok<INUSL>

set(handles.Figure, 'Colormap', gray(256));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFAULT WINDOW SPECIFIC FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function handles = localCreateDefaultWindow(uddobj, handles)

% Access previewout settings.
propValues = get(uddobj, {'ROIPosition', 'ObjectConstructorArguments'});
roi = propValues{1};
args = propValues{2};
uddclass = class(uddobj);

% Height of status bar in character units.
statusCharHeight = 1.25;

% Create a new figure.
objWinName = sprintf('Video previewout - %s:%i', args{1}, args{2});
handles.Figure = figure('Tag', uddclass, 'MenuBar', 'none', ...
    'Visible', 'off', 'ToolBar', 'none', 'NumberTitle', 'off', ...
    'Name', objWinName);

% Determine correct color map. Also leave double buffer
% on so image doesn't flash when scrolling.
set(handles.Figure, 'HandleVisibility', 'off', 'Units', 'pixels', ...
    'BackingStore', 'off');

% Setup the status bar.
handles = localSetupDefaultStatusArea(uddobj, handles, statusCharHeight);

% Setup a new axis, image, and scroll panel.
handles = localSetupDefaultImageArea(handles, roi, statusCharHeight);

% Squeeze the figure size to the image size.
localSqueezeDefaultFig(handles, roi, statusCharHeight);

% TODO Don't pass in all the handles??
set(handles.Figure, 'Visible', 'on', ...
    'ResizeFcn', {@localResizeDefaultFcn, handles, statusCharHeight});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function handles = localSetupDefaultImageArea(handles, roi, statusCharHeight)

% Get the figure position in character units.
set(handles.Figure, 'Units', 'characters');
figPos = get(handles.Figure, 'Position');

% Create a panel for the image components.
handles.ImagePanel = uipanel('Parent', handles.Figure, ...
    'Units', 'characters', 'BorderType', 'none', ...
    'Position', [0 statusCharHeight figPos(3) figPos(4)-statusCharHeight]);
set(handles.ImagePanel, 'Units', 'normalized');

% Define the parent for the scroll panel.
handles.ScrollPanelParent = handles.ImagePanel;

% Create a new axis and image using temporary data 
% of the correct size and dimensions.
data = zeros(roi(4), roi(3), 3);
handles.Axis = axes('Parent', handles.ImagePanel);
handles.Image = image(data, 'Parent', handles.Axis);

% Add scrollbars.
handles.ScrollPanel = imscrollpanel(handles.ScrollPanelParent, handles.Image);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function handles = localSetupDefaultStatusArea(uddobj, handles, statusCharHeight) %#ok<INUSL>

% Get the figure position in character units.
set(handles.Figure, 'Units', 'characters');
figPos = get(handles.Figure, 'Position');

% Define default width, in character units, 
% for each section in the status bar.
timeSecWidth = 20;
resSecWidth = 20;
statusXOffset = timeSecWidth + resSecWidth;
statusSecWidth = figPos(3) - statusXOffset;

% Define position vector, in normalized units,
% for uicontrol text fields.
normTextPos = [0 0 1 1];

% Create a UI panel to contain all status components.
hStatusContainer = uipanel('Parent', handles.Figure, ... 
    'Units', 'characters', 'BorderType', 'none', ...
    'Position', [0 0 figPos(3) statusCharHeight]);
set(hStatusContainer, 'Units', 'normalized');

% Timestamp info section.
timeSecPos = [0 0 timeSecWidth statusCharHeight];
hTimePanel = uipanel('Parent', hStatusContainer, ...
    'Units', 'characters', 'Position', timeSecPos);
hTimeField = uicontrol(hTimePanel, 'Style', 'text', ...
    'String', 'Time Stamp', 'Units', 'normalized', ...
    'Position', normTextPos);

% Resolution info section.
resSecPos = [timeSecWidth 0 resSecWidth statusCharHeight];
hResPanel = uipanel('Parent', hStatusContainer, ...
    'Units', 'characters', 'Position', resSecPos);
hResField = uicontrol(hResPanel, 'Style', 'text', ...
    'String', 'Resolution', 'Units', 'normalized', ...
    'Position', normTextPos);

% Acquisition status info section.
statusSecPos = [statusXOffset 0 statusSecWidth statusCharHeight];
hStatusPanel = uipanel('Parent', hStatusContainer, ...
    'Units', 'characters', 'Position', statusSecPos);
hStatusField = uicontrol(hStatusPanel, 'Style', 'text', ...
    'String', 'Status', 'Units', 'normalized', ...
    'Position', normTextPos, 'HorizontalAlignment', 'left');

% Add the new handles to our structure.
handles.StatusContainer = hStatusContainer;

handles.StatusPanels.Time = hTimePanel;
handles.StatusPanels.Resolution = hResPanel;
handles.StatusPanels.Status = hStatusPanel;

handles.StatusFields.Time = hTimeField;
handles.StatusFields.Resolution = hResField;
handles.StatusFields.Status = hStatusField;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function localSqueezeDefaultFig(handles, roi, statusCharHeight)

% Resize our figure to the image width and height. Don't 
% resize if the window's docked (causes a warning). The 
% window should never be docked at this point, but do it
% just in case since it's an inexpensive check.
winStyle = get(handles.Figure, 'WindowStyle');
if ~strcmpi(winStyle, 'docked')
    % Determine the size of the panel containing the status bar.
    set(handles.StatusContainer, 'Units', 'pixels');
    statusPos = get(handles.StatusContainer, 'Position');
    set(handles.StatusContainer, 'Units', 'normalized');

    % Resize the figure based on the ROI and status bar.
    % Make sure to resize the figure with respect to the top
    % left corner.
    set(handles.Figure, 'Units', 'pixels');
    figPos = get(handles.Figure, 'Position');   
    figWidth = roi(3);
    figHeight = roi(4)+statusPos(4);
    bottomLeft = figPos(2) + (figPos(4) - figHeight);
    set(handles.Figure, ...
        'Position', [figPos(1) bottomLeft figWidth figHeight]);
    
    % Since the resize callback is not fired when the figure
    % is resized programmatically, fire it ourselves in case the 
    % figure width changed a bit.
    localResizeDefaultFcn(handles.Figure, [], handles, statusCharHeight)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function handles = localRetargetDefaultImage(handles, uddobj)

% Determine if the axis width and height match the ROI
% width and height.
axUnits = get(handles.Axis, 'Units');
set(handles.Axis, 'Units', 'Pixels');
axPos = get(handles.Axis, 'Position');
set(handles.Axis, 'Units', axUnits);

roi = get(uddobj, 'ROIPosition');
if all(axPos(3:4)==roi(3:4))
    % Target image and ROI are in sync.
    return;
end

% Turn the scroll panel off and force it 
% to retarget with the new image.
api = iptgetapi(handles.ScrollPanel);
api.replaceImage(get(handles.Image, 'CData'));
