clc

armnumber=1;


Tc{1}=extrinsicparamsarr{armnumber}.TTcamref{1};
Tc{2}=extrinsicparamsarr{armnumber}.TTcamref{2};

%R=2, L=1
Tc12=Tc{2}*Tc{1}^-1;

%a point in cam1 in pixels is


Pc{1}=[320;240];
Pc{2}=[320;240];

% for ii=1:2
% 
% %Xn is normalized point
% Xn{ii} = normalize(Pc{ii},calibparamsarr{1}.fc,calibparamsarr{ii}.cc,calibparamsarr{ii}.kc,calibparamsarr{ii}.alpha_c);
% 
% %two points in the line are [0;0;0;1] and [Xn1;1;1;]
% 
% %the line through these two points becomes (one iz zero)
% end
% 
% Lc2=[Xn{2};1]
% 
% Xn12=Tc{2}*Tc{1}^-1*[Xn1;1;1] % a position of cam1 reference converted to cam2 reference
% X012=Tc{2}*Tc{1}^-1*[0;0;0;1] % a position of cam1 reference converted to cam2 reference
% Lc1=[(Xn12(1:3)-X012(1:3));1]
% 
% %intersection
% Xint2=[cross(Lc1(1:3),Lc2(1:3));1]





[X{1},X{2}] = mytriangulation(Pc{1},Pc{2},Tc12(1:3,1:3),Tc12(1:3,4),calibparamsarr{1}.fc,calibparamsarr{1}.cc,calibparamsarr{1}.kc,calibparamsarr{1}.alpha_c,calibparamsarr{2}.fc,calibparamsarr{2}.cc,calibparamsarr{2}.kc,calibparamsarr{2}.alpha_c);
X{1}
X{2}