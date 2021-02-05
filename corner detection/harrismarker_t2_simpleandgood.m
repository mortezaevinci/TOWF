I=imread('Q:\My files\PROJECT TOWF\images\Calibration\c1\capture.2011.03.22.3.bmp');

%imshow(I);


faroutcc=myfaroutcorners(I);



hold on
plot(faroutcc(1,:),faroutcc(2,:),'go')

hold off


% % 
% % 
% % hold on
% % plot(goodcen(randomset,1),goodcen(randomset,2),'g+')
% % hold off
% % 
% %set the plane
% [Homo,Hnorm,inv_Hnorm] = compute_homography ([[goodcc(:,faroutc)];[1 1 1 1]],[0 1 1 0;0 0 1 1;1 1 1 1]);
% 
% %n_sq_x=n_sq_x-1;n_sq_y=n_sq_y-1;
% x_l = ((0:n_sq_x)'*ones(1,n_sq_y+1))/n_sq_x;
% y_l = (ones(n_sq_x+1,1)*(0:n_sq_y))/n_sq_y;
% pts = [x_l(:) y_l(:) ones((n_sq_x+1)*(n_sq_y+1),1)]';
% 
% XX = Homo*pts;
% XX = XX(1:2,:) ./ (ones(2,1)*XX(3,:));
% 
% 
% hold on
% plot(XX(1,:),XX(2,:),'ro');
% 
% hold off
% 
