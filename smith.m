function varargout = smith(varargin)
% UNTITLED MATLAB code for untitled.fig
%
UNTITLED, by itself, creates a new UNTITLED or raises the existing
%
singleton*.
%
%
H = UNTITLED returns the handle to a new UNTITLED or the handle to
%
the existing singleton*.
%
%
UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%
function named CALLBACK in UNTITLED.M with the given input arguments.
%
%
UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%
existing singleton*. Starting from the left, property value pairs are
%
applied to the GUI before untitled_OpeningFcn gets called. An
%
unrecognized property name or invalid value makes property application
%
stop. All inputs are passed to untitled_OpeningFcn via varargin.
%
%
*See GUI Options on GUIDE's Tools menu. Choose "GUI allows only one
%
instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to help untitled
% Last Modified by GUIDE v2.5 20-Apr-2019 18:11:21
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',
mfilename, ...
'gui_Singleton', gui_Singleton, ...
'gui_OpeningFcn', @untitled_OpeningFcn, ...
'gui_OutputFcn', @untitled_OutputFcn, ...
'gui_LayoutFcn', [] , ...
'gui_Callback', []);
if nargin && ischar(varargin{1})
gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
[varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject
handle to figure
% eventdata reserved - to be defined in a future version of MATLAB
% handles
structure with handles and user data (see GUIDATA)
% varargin command line arguments to untitled (see VARARGIN)
% Choose default command line output for untitled
handles.output = hObject;
%equations were derived using the symbolic toolbox as follows
%solve('R=(1-Gr^2-Gi^2)/((1-Gr)^2+Gi^2)','Gi')
%bound was derived as follows
%solve('1/(R+1)*(-(R+1)*(R-2*R*Gr+R.*Gr^2-1+Gr^2))^(1/2)=0','Gr')
% Update handles structure
guidata(hObject, handles);
global phaseAngle MAX Gr
% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles)
% varargout cell array for returning output args (see VARARGOUT);
% hObject
handle to figure
% eventdata reserved - to be defined in a future version of MATLAB
% handles
structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;
% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject
handle to axes1 (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles
empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate axes1
% --- Executes on button press in pushbutton1.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject
handle to pushbutton2 (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles
structure with handles and user data (see GUIDATA)
%画最大外圆、标注虚轴刻度
axis square;
wavelengths=0:.01:.5;
angle = linspace(pi,-pi,length(wavelengths));
wave_circle = 1.05*exp(1i*angle);
plot(real(wave_circle),imag(wave_circle),'r');
hold on
plot([-1.05 1.05],[0 0],'color','r');
for i=1:length(wavelengths)-1
x=real(1.025*exp(1i*angle(i)));
y=imag(1.025*exp(1i*angle(i)));
if(x>0)
rot_angle=atan(y/x)*180/pi-90;
else
rot_angle=atan(y/x)*180/pi+90;
end
if(wavelengths(i)==0)
word = '0.00';
elseif(mod(wavelengths(i),.1)==0)
word =[num2str(wavelengths(i)) '0'];
else
word = num2str(wavelengths(i));
end
text(x,y,word,'Rotation',rot_angle)
end
hold on
bound2=0;
bound3=0;
min_bound1=0;
min_bound2=0;
max_bound2=0;
interval=[.01:.01:.2,.22:.02:.5,.55:.05:1,1.1:.1:2 , 2.2:.2:5 , 6:10 , 12:2:20 , 30:10:50];
interval2=[.01:.01:.5 , .55:.05:1 , 1.1:.1:2 , 2.2:.2:5 , 6:10 , 12:2:20 , 30:10:50];
% 画电阻圆族
U = @(R,X)(R^2+X^2-1)/(R^2+2*R+1+X^2);
V = @(R,X)(2*X)/(R^2+2*R+1+X^2);
MAX = 2019
Gr = linspace(-1,1,MAX)
axis square
axis([-1.1,1.1,-1.1,1.1]);
hold on
for R = interval
min_bound1 = (R-1)/(R+1);
if (R<0.2)
if (mod(R,0.1) == 0)
max_bound = U(R,2)
elseif (mod(R,0.02) == 0)
max_bound = U(R,0.5)
else
max_bound = U(R,0.2)
end
if(R == 0.05 || (R<0.151 && R>0.149))
min_bound2 = U(R,0.5)
max_bound2 = U(R,1)
end
elseif (R<0.5)
if (mod(R,0.2) == 0)
max_bound = U(R,5)
elseif (mod(R,0.1) == 0)
max_bound = U(R,2)
elseif (R == 0.55 || R == 0.65 || R == 0.75)
temp = U(R,0.5)
min_bound2 = max(min_bound1,temp)
max_bound = U(R,1)
else
max_bound = U(R,0.5)
end
elseif (R<1)
if (mod(R,0.2) == 0)
max_bound = U(R,5)
elseif (mod(R,0.1) == 0)
max_bound = U(R,2)
elseif (R == 0.25 || R == 0.35 || R == 0.45)
temp = U(R,0.5)
min_bound2 = max(min_bound1,temp)
max_bound = U(R,1)
elseif (R<0.5)
max_bound = U(R,0.5)
else
max_bound = U(R,1)
end
elseif (R<5)
if (mode(R,2) == 0)
max_bound = U(R,20)
elseif (mod(R,1) == 0)
max_bound = U(R,10)
elseif (R>2)
max_bound = U(R,5)
else
if (mod(R,0.2) == 0)
max_bound = U(R,5)
else
max_bound = U(R,2)
end
end
elseif (R<10)
if (mod(R,2) == 0)
max_bound = U(R,20)
else
max_bound = U(R,10)
end
else
if (R == 10 || R == 20)
max_bound = U(R,50)
elseif (R == 50)
max_bound = 1
elseif (R<20)
max_bound = U(R,20)
else
max_bound = U(R,50)
end
end
index = ceil((min_bound1 + 1)*(MAX - 1)/2 + 1);
actual_value = Gr(index);
if (actual_value<min_bound1)
index = index + 1;
end
MIN=index;
index = ceil((max_bound + 1)*(MAX - 1)/2 + 1);
actual_value = Gr(index);
if (actual_value>max_bound)
index = index - 1;
end
MIN2 = ceil((min_bound2 + 1)*(MAX - 1)/2 + 1);
actual_value = Gr(MIN2);
if (actual_value<min_bound2)
    MIN2 = MIN2 + 1;
end
MAX2 = ceil((max_bound2+1)*(MAX-1)/ 2+1);
actual_value = Gr(MAX2);
if(actual_value<max_bound2)
MAX2 = MAX2 + 1;
end
r_L_a=1/(R+1)*(-(R+1)*(R-2*R.*Gr(MIN:index)+
R.*Gr(MIN:index).^2-1+Gr(MIN:index).^2)).^(1/ 2 );
r_L_b=-1/(R+1)*(-(R+1)*(R-2*R.*Gr(MIN:index)+
R.*Gr(MIN:index).^2-1+Gr(MIN:index).^2)).^(1/ 2 );
r_L_b(1)=0;
r_L_a(1)=0;
r_L_a2=1/(R+1)*(-(R+1)*(R-2*R.*Gr(MIN2:MAX2 )+R.*Gr(MIN2:MAX2).^2-1+Gr(MIN2:MA
X2).^2)).^(1/2);
r_L_b2=-1/(R+1)*(-(R+1)*(R-2*R.*Gr(MIN2:MAX2)+R.*Gr(MIN2:MAX2).^2-1+Gr(MIN2:M
AX2).^2 )).^(1/2);
r_L_a3=1/(R+1)*(-(R+1)*(R-2*R.*Gr(MIN2:index)
+R.*Gr(MIN2:index).^2-1+Gr(MIN2:index).^2)).^(1/2);
r_L_b3=-1/(R+1)*(-(R+1)*(R-2*R.*Gr(MIN2:index)+R.*Gr(MIN2:index).^2-1+Gr(MIN2:index)
.^2)).^(1/2);
if(~(R>.2 && R<.5 && ~(mod(R,.02)==0)))
color ='k';
end
plot(Gr(MIN:index),r_L_a(1:index-MIN+1),color,Gr(MIN:index),
r_L_b(1:index-MIN+1),color);
if(R<=1)
if(mod(R,1)==0)
word = [num2str(R) '.0'];
else
word = num2str(R);
end
if(mod(R,.1)==0)
set(text(Gr(MIN),0,word),'Rotation',90,'HorizontalAlignment','left','VerticalAlignment','bott om');
end
elseif(R<=2)
if(mod(R,.2)==0)
if(mod(R,1)==0)
word = [num2str(R) '.0'];
else
word = num2str(R);
end
set(text(Gr(MIN),0,word),'Rotation',90,'HorizontalAlignment','left','VerticalAlignment','bott om');
end
elseif(R<=5)
if(mod(R,1)==0)
set(text(Gr(MIN),0,[num2str(R)
'.0']),'Rotation',90,'HorizontalAlignment','left','VerticalAlignment','bottom');
elseif(mod(R,10)==0)
set(text(Gr(MIN),0,num2str(R)),'Rotation',90,'HorizontalAlignment','left','VerticalAlignment' ,'bott
om');
end
elseif(R == 0.25 || R == 0.35 || R==0.45)
plot(Gr(MIN2:index),r_L_a3,'b');
plot(Gr(MIN2:index),r_L_b3,'b');
elseif(R==.05 || (R>.149 && R<.151))
plot(Gr(MIN2:MAX2),r_L_a2(length(Gr(MIN2:MAX2))-length(r_L_a2)+1:length(r_L_a2)),'b');
plot(Gr(MIN2:MAX2),r_L_b2(length(Gr(MIN2:MAX2))-length(r_L_b2)+1:length(r_L_b2)),'b');
end
end
%%%%%%
hold on
bound2=0;
bound3=0;
inter_bound=0;
imag_bound=0;
imag_bound_y=0;
imag_rad=0;
max_bound=0;
inter_index=0;
imag_index=0;
phaseAngle=0;
for X = interval
inter_bound = (-1+X^2)/(X^2+1);
imag_bound = (-1+X)/X;
angle_point = 0;
if(inter_bound ~= 0)
angle_point = sqrt(1-inter_bound^2)/inter_bound;
end
imag_bound_y = 1/2/X*(-2+2*(1-X^2+2*X^2.*inter_bound-X^2.*inter_bound.^2).^(1/2));
imag_rad = (imag_bound^2 + imag_bound_y^2)^(1/2);
condition = imag_rad < 1;
if(inter_bound > 1)
inter_bound = 1;
elseif(inter_bound < -1)
imag_bound=-1;
end
if(imag_bound > 1)
imag_bound = 1;
elseif(imag_bound < -1)
imag_bound=-1;
end
if(X<0.2)
if(mod(X,.1)==0)
max_bound = U(2,X)
elseif(mod(X,.02)==0)
max_bound = U(0.5,X)
else
max_bound = U(0.2,X)
end
elseif(X<1)
if(mod(X,0.2) == 0)
max_bound = U(5,X)
elseif(mod(X,0.1) == 0)
max_bound = U(2,X)
elseif(x<0.5)
max_bound = U(0.5,X)
else
max_bound = U(1,X)
end
elseif(X<5)
if(mod(X,2) == 0)
    max_bound = U(20,X)
elseif(mod(X,1) == 0)
max_bound = U(10,X)
elseif(x>2)
max_bound = U(5,X)
else
if(mod(X,0.2) == 0)
max_bound = U(5,X)
else
max_bound = U(2,X)
end
end
elseif(X<10)
if(mod(X,2) == 0)
max_bound = U(20,X)
else
max_bound = U(10,X)
end
else
if(X == 10 || X == 20)
max_bound = U(50,X)
elseif(X == 50)
max_bound = 1
elseif(X<20)
max_bound = U(20,X)
else
max_bound = U(50,X)
end
end
inter_index = ceil((inter_bound+1)*(MAX-1)/ 2+1);
imag_index = ceil((imag_bound+1)*(MAX-1)/ 2+1);
index4 = ceil((max_bound+1)*(MAX-1)/ 2+1);
index1 = max(inter_index,imag_index);
index2 = min(imag_index,inter_index);
if(condition)
index3=imag_index;
else
index3=inter_index;
end
actual_value1 = Gr(index1);
actual_value2 = Gr(index2);
actual_value3 = Gr(index3);
actual_value4 = Gr(index4);
if((actual_value1 > inter_bound && index1 == inter_index)||(actual_value1 > imag_bound
&& index1 == imag_index))
index1 = index1 - 1;
end
if((actual_value2 < inter_bound && index2 == inter_index)||(actual_value2 < imag_bound
&& index2 == imag_index))
index2 = index2 + 1;
end
if((actual_value3 < inter_bound && index3 == inter_index)||(actual_value3 < imag_bound
&& index3 == imag_index))
index3 = index3 + 1;
end
if(actual_value4 > max_bound)
index4 = index4 - 1;
end
MIN = index2;
MAX2 = index1;
MAX3 = index4;
MIN2 = index3;
x_L_a =
real(1/2/X*(-2+2*(1-X^2+2*X^2.*Gr(MIN2:MAX3 )-X^2.*Gr(MIN2:MAX3).^2).^(1/ 2)));
x_L_b =
real(1/2/X*(2-2*(1-X^2+2*X^2.*Gr(MIN2:MAX3)-X^2.*Gr(MIN2:MAX3).^2).^(1 /2)));
x_L_c= real(1/2/X*(2+2*(1-X^2+2*X^2.*Gr(MIN:MAX2)-X^2.*Gr(MIN:MAX2).^2).^(1/
2)));
x_L_d= real(1/2/X*(-2-2*(1-X^2+2*X^2.*Gr(MIN:MAX2)-X^2.*Gr(MIN:MAX2).^2).^(1/
2)));
if(MIN2<MAX3)
x_L_c(1)=x_L_b(1);
x_L_d(1)=x_L_a(1);
end
check1 = abs(round(10000*1
/2/X*(-2-2*(1-X^2+2*X^2*inter_bound-X^2*inter_bound^2)^(1/2))));
check2 = abs(round(10000*(1-inter_bound^2)^(1 /2)));
if(imag_bound > -1 && check1 == check2)
plot(Gr(MIN:MAX2),x_L_c,'c')
plot(Gr(MIN:MAX2),x_L_d,'c')
end
plot(Gr(MIN2:MAX3),x_L_a,'c')
plot(Gr(MIN2:MAX3),x_L_b,'c')
condition = Gr(MIN2)^2 + x_L_d(1)^2 > .985;
if(X<=1)
if(mod(X,.1)==0)
if(mod(X,1)==0)
word = [num2str(X) '.0'];
else
word = num2str(X);
end
if(X==1)
angle = 90;
else
angle = -atan(angle_point)*180/pi;
set(text(Gr(MIN2),x_L_d(1),word),'Rotation',angle,'VerticalAlignment','bottom','HorizontalAlign
ment','left');
set(text(Gr(MIN2),-x_L_d(1),word),'Rotation',-angle+180,'HorizontalAlignment','right','VerticalAl
ignment','bottom');
end
if(mod(X,.2)==0)
xval = X^2/(X^2+4);
yval = 1/2/X*(-2+2*(1-X^2+2*X^2*xval-X^2*xval^2)^(1/2));
angle = -atan(yval/(.5-xval))*180/pi;
set(text(xval,yval,word),'Rotation',angle,'HorizontalAlignment','left','VerticalAlignment','bottom');
set(text(xval,-yval,word),'Rotation',-angle+180,'HorizontalAlignment','right','VerticalAlignment','b
ottom')
end
end
elseif(X<=2)
if(mod(X,.2)==0)
if(mod(X,1)==0)
word = [num2str(X) '.0'];
else
word = num2str(X);
end
if(condition)
angle = -atan(angle_point)*180/pi+180;
set(text(Gr(MIN2),x_L_a(1),word),'Rotation',angle,'VerticalAlignment','bottom','HorizontalAlign
m ent','left');
set(text(Gr(MIN2),-x_L_a(1),word),'Rotation',-angle+180,'HorizontalAlignment','right','VerticalAl
i gnment','bottom');
else
angle = -atan(angle_point)*180/pi+180;
set(text(Gr(MAX2),x_L_d(length(x_L_d)),word),'Rotation',angle,'VerticalAlignment','botto
m','HorizontalAlignment','left');
set(text(Gr(MAX2),-x_L_d(length(x_L_d)),word),'Rotation',-angle+180,'HorizontalAlignment' ,'ri
ght','VerticalAlignment','bottom');
end
end
elseif(X<=5)
if(mod(X,1)==0)
if(condition)
angle = -atan(angle_point)*180/pi+180;
set(text(Gr(MIN2),x_L_a(1),[num2str(X)
'.0']),'Rotation',angle,'VerticalAlignment','botto m','HorizontalAlignment','left');
set(text(Gr(MIN2),-x_L_a(1),[num2str(X)
'.0']),'Rotation',-angle+180,'HorizontalAlignment ','right','VerticalAlignment','bottom');
else
angle = -atan(angle_point)*180/pi+180;
set(text(Gr(MAX2),x_L_d(length(x_L_d)),[num2str(X)
'.0']),'Rotation',angle,'VerticalAlignment','bottom','HorizontalAlignment','left');
set(text(Gr(MAX2),-x_L_d(length(x_L_d)),[num2str(X)
'.0']),'Rotation',-angle+180,'HorizontalAlignment','right','VerticalAlignment','bottom');
end
end
else
if(mod(X,10)==0)
if(condition)
angle = -atan(angle_point)*180/pi+180;
set(text(Gr(MIN2),x_L_a(1),num2str(X)),'Rotation',angle,'VerticalAlignment','bottom','Horizontal
Alignment','left');
set(text(Gr(MIN2),-x_L_a(1),num2str(X)),'Rotation',-angle+180,'HorizontalAlignment','right','Ver
ticalAlignment','bottom');
else
angle = -atan(angle_point)*180/pi+180;
set(text(Gr(MAX2),x_L_d(length(x_L_d)),num2str(X)),'Rotation',angle,'VerticalAlignment','botto
m','HorizontalAlignment','left');
set(text(Gr(MAX2),-x_L_d(length(x_L_d)),num2str(X)),'Rotation',-angle+180,'HorizontalAlignm
ent','right','VerticalAlignment','bottom');
end
end
end
end
%plot imaginary axis
plot(zeros(1,length(Gr)),Gr,'r');
wavelengths = 0:.01:.5;
angle = linspace(pi,-pi,length(wavelengths));
wave_circle = 1.05*exp(1i*phaseAngle);
plot(real(wave_circle),imag(wave_circle),'r');
for i=1:length(wavelengths)-1
x=real(1.025*exp(1i*angle(i)));
y=imag(1.025*exp(1i*angle(i)));
if(x>0)
rot_angle=atan(y/x)*180/pi-90;
else
rot_angle=atan(y/x)*180/pi+90;
end
if(wavelengths(i)==0)
word = '0.00';
elseif(mod(wavelengths(i),.1)==0)
word = [num2str(wavelengths(i)) '0'];
else
word = num2str(wavelengths(i));
end
set(text(x,y,word),'Rotation',rot_angle,'VerticalAlignment','middle','HorizontalAlignment','center')
end
% --- Executes on button press in pushbutton3.
function edit1_Callback(hObject, eventdata, handles)
% hObject
handle to edit1 (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles
structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit1 as text
%
str2double(get(hObject,'String')) returns contents of edit1 as a double
zl = str2double(get(hObject,'String'));
if isnan(zl)
errordlg('You must input a number.');
set(handles.edit1, 'string', '');
end
% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject
handle to edit1 (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles
empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%
See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end
function edit2_Callback(hObject, eventdata, handles)
% hObject
handle to edit2 (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles
structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit2 as text
%
str2double(get(hObject,'String')) returns contents of edit2 as a double
zl = str2double(get(hObject,'String'));
if isnan(zl)
errordlg('You must input a number.');
set(handles.edit2, 'string', '');
end
% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject
handle to edit2 (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles
empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%
See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end
function edit3_Callback(hObject, eventdata, handles)
% hObject
handle to edit3 (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles
structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit3 as text
%
str2double(get(hObject,'String')) returns contents of edit3 as a double
% --- Executes during object creation, after setting all properties.
function edit9_Callback(hObject, eventdata, handles)
% hObject
handle to edit9 (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles
structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit9 as text
%
str2double(get(hObject,'String')) returns contents of edit9 as a double
zl = str2double(get(hObject,'String'));
if isnan(zl)
errordlg('You must input a number.');
set(handles.edit9, 'string', '');
elseif real(zl<0)
errordlg('The real part cannot be negative.');
set(handles.edit9, 'string', '');
end
% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject
handle to edit9 (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles
empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%
See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end
function edit10_Callback(hObject, eventdata, handles)
% hObject
handle to edit10 (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles
structure with handles and user data (see GUIDATA)
zl = str2double(get(hObject,'String'));
if isnan(zl)
errordlg('You must input a number.');
set(handles.edit10, 'string', '');
end
% Hints: get(hObject,'String') returns contents of edit10 as text
%
str2double(get(hObject,'String')) returns contents of edit10 as a double
% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject
handle to edit10 (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles
empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%
See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
set(hObject,'BackgroundColor','white');
end
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject
handle to pushbutton4 (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles
structure with handles and user data (see GUIDATA)
zl = str2double(get(handles.edit9,'string'));
z2 = str2double(get(handles.edit10,'string'));
z3 = str2double(get(handles.edit2,'string'));
d = str2double(get(handles.edit1,'string'));
z = ((zl+j*z2)./z3+j*tan(2*pi*d))/(1+j*((zl+j*z2)./z3)*tan(2*pi*d));
z22=z*z3;
y = 1/z22;
aida = (z-1)/(z+1);
set(handles.text19,'string',num2str(z22))
set(handles.text21,'string',num2str(y))
set(handles.text24,'string',num2str(aida))
p=str2double(get(handles.text24,'string'));
p1=real(p);
p2=imag(p);
p3=sqrt(p1^2+p2^2);
set(handles.text26,'string',num2str(p3))
r = str2double(get(handles.text24,'string'));
r1 = real(r);
r2 = imag(r);
r3 = sqrt((r1)^2+(r2)^2);
r4 = (1+r3)./(1-r3);
set(handles.text23,'string',r4)
%画等反射系数圆
zl = str2double(get(handles.edit9,'string'));
R=zl./z3;
X=z2./z3;
U=(R^2+X^2-1)./(R^2+2*R+1+X^2);
V=(2*X)./(R^2+2*R+1+X^2);
tr = 2*pi*(0:0.01:1);
r=sqrt((R^2-2*R+1+X^2)/(R^2+2*R+1+X^2));
plot(r*cos(tr),r*sin(tr),'r','LineWidth',1)
pause(0.5)
% 等归一化电抗圆
for rr = 1/(1+R)
cr = 1-rr;
plot(cr+rr*cos(tr),rr*sin( tr),'r','LineWidth',1)
end
pause(0.5)
for x=X
rx= 1/x;
cx= rx;
tx=2* atan( x) * ( 0:0.01:1);
if tx<pi
plot(1-rx*sin(tx),cx-rx*cos(tx),'r','LineWidth',1)
else
plot(1-rx*sin(tx),-cx+rx*cos(tx),'r','LineWidth',1)
end
end
pause(0.5)
z11 = ((zl+j*z2)./z3+j*tan(2*pi*0))/(1+j*((zl+j*z2)./z3)*tan(2*pi*0));
aida11 = (z11-1)/(z11+1);
plot([0 4*real(aida11)],[0 4*imag(aida11)],'r','LineWidth',1)
text(real(aida11),imag(aida11),['(',num2str(real(aida11)),',',num2str(imag(aida11)),')'],'color','b','fo
ntsize',9);
hold on
pause(0.5)
z = ((zl+j*z2)./z3+j*tan(2*pi*d))/(1+j*((zl+j*z2)./z3)*tan(2*pi*d));
aida = (z-1)/(z+1);
plot([-4*real(aida) 4*real(aida)],[-4*imag(aida) 4*imag(aida)],'r','LineWidth',1)
text(real(aida),imag(aida),['(',num2str(real(aida)),',',num2str(imag(aida)),')'],'color','b','fontsize',9);
text(-real(aida),-imag(aida),['(',num2str(-real(aida)),',',num2str(-imag(aida)),')'],'color','b','fontsize',
9);
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject
handle to pushbutton5 (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles
structure with handles and user data (see GUIDATA)
set(handles.text21,'string','')
set(handles.text19,'string','')
set(handles.text23,'string','')
set(handles.text24,'string','')
set(handles.text26,'string','')
set(handles.edit9,'string','')
set(handles.edit10,'string','')
set(handles.edit1,'string','')
set(handles.edit2,'string','')
axes(handles.axes1);
cla reset %清空图像
% --- Executes during object creation, after setting all properties.
function text24_CreateFcn(hObject, eventdata, handles)
% hObject
handle to text24 (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles
empty - handles not created until after all CreateFcns called
% --- Executes during object creation, after setting all properties.
function text23_CreateFcn(hObject, eventdata, handles)
% hObject
handle to text23 (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles
empty - handles not created until after all CreateFcns called
% --- Executes during object creation, after setting all properties.
function text21_CreateFcn(hObject, eventdata, handles)
% hObject
handle to text21 (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles
empty - handles not created until after all CreateFcns called
% --- Executes during object creation, after setting all properties.
function text22_CreateFcn(hObject, eventdata, handles)
% hObject
handle to text22 (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles
empty - handles not created until after all CreateFcns called
% --- Executes during object creation, after setting all properties.
function text19_CreateFcn(hObject, eventdata, handles)
% hObject
handle to text19 (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles
empty - handles not created until after all CreateFcns called
%
% --- Executes during object creation, after setting all properties.
function text20_CreateFcn(hObject, eventdata, handles)
% hObject
handle to text20 (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles
empty - handles not created until after all CreateFcns called
% --- Executes during object creation, after setting all properties.
function text26_CreateFcn(hObject, eventdata, handles)
% hObject
handle to text26 (see GCBO)
% eventdata reserved - to be defined in a future version of MATLAB
% handles
empty - handles not created until after all CreateFcns called