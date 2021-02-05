function [X1,X2] = mytriangulation(x1,x2,R,T,fc1,cc1,kc1,alpha_c1,fc2,cc2,kc2,alpha_c2)

%--- Normalize the image projection according to the intrinsic parameters
%of cameras 1 and 2
xt1 = normalize_pixel(x1,fc1,cc1,kc1,alpha_c1);
xt2 = normalize_pixel(x2,fc2,cc2,kc2,alpha_c2);

%--- the normalized projections to homogeneous coordinates
xt1 = [xt1;ones(1,size(xt1,2))];
xt2 = [xt2;ones(1,size(xt2,2))];

%--- Number of points:
N = size(xt1,2);

u = R * xt1;

n_xtt1 = dot(xt1,xt1);
n_xtt2 = dot(xt2,xt2);

T_vect = repmat(T, [1 N]);

DD = n_xtt1 .* n_xtt2 - dot(u,xt2).^2;

dot_uT = dot(u,T_vect);
dot_xttT = dot(xt2,T_vect);
dot_xttu = dot(u,xt2);

NN1 = dot_xttu.*dot_xttT - n_xtt2 .* dot_uT;
NN2 = n_xtt1.*dot_xttT - dot_uT.*dot_xttu;

Zt1 = NN1./DD;
Zt2 = NN2./DD;

Xx1 = xt1 .* repmat(Zt1,[3 1]);
Xx2 = R'*(xt2.*repmat(Zt2,[3,1])  - T_vect);


%--- Left coordinates:
X1 = 1/2 * (Xx1 + Xx2);

%--- Right coordinates:
X2 = R*X1 + T_vect;

