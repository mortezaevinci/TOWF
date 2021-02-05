I=imread('Q:\My files\PROJECT TOWF\images\Calibration\c1\capture.2011.03.22.12.bmp');
I=I(:,:,1);
h1=fspecial('gaussian',[7 7],1);
If=imfilter(I,h1);
cc=cornermetric(If,'Harris', 'SensitivityFactor',.05);
cc=cc>.02.*max(max(cc));

n_sq_x=6; %no of elements in y direction
n_sq_y=9; %no of elements in y direction
n_sq=n_sq_x*n_sq_y; % no fo elements

ll=bwlabel(cc,8);

stats=regionprops(ll,'Area','Centroid');
llarea=[stats.Area];
llcentr=[stats.Centroid];
llcentr=reshape(llcentr,2,numel(llcentr)/2)';

[sorttemp, indarea]=sort(llarea,'descend');

goodcen=llcentr(indarea(1:n_sq),:);
goodcen=[goodcen(:,1)';goodcen(:,2)'];
%goodcen=[x;y];
figure
imshow(I);
hold on
plot(goodcen(1,:),goodcen(2,:),'r+')

hold off

%if such matrix exists that following holds, then we have a projective
%plane in our image
% [x_0 y_0 x_0*y_0 1]   [a]   0
% [x_1 y_1 x_1*y_1 1] * [b] = 0
% [x_2 y_2 x_2*y_2 1]   [c]   0
% [x_3 y_3 x_3*y_3 1]   [d]   0
%...
homogoodcen4projectiveplane=[[goodcen];goodcen(1,:).*goodcen(2,:); ones(1,size(goodcen,2))];

randomset=1:n_sq;

A=homogoodcen4projectiveplane(:,randomset)';
[U,S,V]=svd(A,0);

%if the difference is huge, we can assume that the image data were in a plane
isplanar=(S(1,1)/S(4,4))>1000

%now check all points
V1=V(:,4);; %maybe should be (1,:)

(homogoodcen4projectiveplane(:,randomset)')*V1


%so far so good,
%now, use RANSAC to fit a plane to data


% 
% 
% hold on
% plot(goodcen(randomset,1),goodcen(randomset,2),'g+')
% hold off
% 
% %set the plane
% [Homo,Hnorm,inv_Hnorm] = compute_homography (goodcen(randomset,2:-1:1)',[0 1 1 0;0 0 1 1;1 1 1 1]);
% 
% x_l = ((0:n_sq_x)'*ones(1,n_sq_y+1))/n_sq_x;
% y_l = (ones(n_sq_x+1,1)*(0:n_sq_y))/n_sq_y;
% pts = [x_l(:) y_l(:) ones((n_sq_x+1)*(n_sq_y+1),1)]';
% 
% XX = Homo*pts;
% XX = XX(1:2,:) ./ (ones(2,1)*XX(3,:));
% 
% 
% hold on
% plot(XX(1,:),XX(2,:),'bo');
% 
% hold off