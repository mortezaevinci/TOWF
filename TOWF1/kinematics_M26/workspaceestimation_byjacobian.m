clc

L=[.16 .19 .12 .19 .14 .165];

qdef=[0 0 pi/2 0 pi/2 0];


for ii=1:2000
ii

q=randn(1,6)*pi-pi/2+qdef;  %x=q-zero, z= pi/2 for either joint 72, 76, 7a ... y=-pi/2 for 74, and pi/2 for 76


TT=fkine_M26(L,q);



J=jacob_M26(L,q);


dJ=det(J);

if dJ>.01
    goodpoints=[goodpoints TT(1:3,4)];
else
    
    badpoints=[badpoints T(1:3,4)];
    
end


end

figure(35)
plot3(goodpoints(1,:),goodpoints(2,:),goodpoints(3,:),'.')
hold on
plot3(badpoints(1,:),badpoints(2,:),badpoints(3,:),'r.')