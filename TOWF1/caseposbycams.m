armnumber=statecur{3};


Tc{1}=extrinsicparamsarr{armnumber}.TTcamref{1};
Tc{2}=extrinsicparamsarr{armnumber}.TTcamref{2};

%R=2, L=1
Tc12=Tc{2}*Tc{1}^-1;

%a point in cam1 in pixels is

%Pc{1}=[320;240];
%Pc{2}=[320;240];

[X{1},X{2}] = mytriangulation(Pc{1},Pc{2},Tc12(1:3,1:3),Tc12(1:3,4),calibparamsarr{1}.fc,calibparamsarr{1}.cc,calibparamsarr{1}.kc,calibparamsarr{1}.alpha_c,calibparamsarr{2}.fc,calibparamsarr{2}.cc,calibparamsarr{2}.kc,calibparamsarr{2}.alpha_c);
X{1}
X{2}

TTarm=extrinsicparamsarr{armnumber}.TTarm;
TTgrid=extrinsicparamsarr{armnumber}.chess2endeffector;

for ii=1:1
Xg=Tc{ii}^-1*[X{ii};1] %the cam1 position to grid reference
Xe=TTgrid^-1*Xg %the chess to end effector...
Xb=TTarm*Xe   %the position of the end effector by the base reference   (what we need to use)
end