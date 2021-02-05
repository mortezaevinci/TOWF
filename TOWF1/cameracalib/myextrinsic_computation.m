%%% INPUT THE IMAGE FILE NAME:

if ~exist('calibparams')
    if (calibparams.fc==0)|(calibparams.kc==0)|(calibparams.alpha_c==0)|(calibparams.cc==0)
   fprintf(1,'No intrinsic camera parameters available.\n');
   return;
    end
end;


fprintf(1,'\n');
disp('Computation of the extrinsic parameters from an image of a pattern');
disp('The intrinsic camera parameters are assumed to be known (previously computed)');

%%%%
%gets I




%%% EXTRACT GRID CORNERS:

% fprintf(1,'\nExtraction of the grid corners on the image\n');
% 
% disp('Window size for corner finder (wintx and winty):');
% wintx = input('wintx ([] = 5) = ');
% if isempty(wintx), wintx = 5; end;
% wintx = round(wintx);
% winty = input('winty ([] = 5) = ');
% if isempty(winty), winty = 5; end;
% winty = round(winty);
% 
% fprintf(1,'Window size = %dx%d\n',2*wintx+1,2*winty+1);


[x_ext,X_ext,n_sq_x,n_sq_y,ind_orig,ind_x,ind_y,redcenter, goodresults] = myextract_grid(I,calibparams.wintx,calibparams.winty,calibparams.fc,calibparams.cc,calibparams.kc,calibparams.dX,calibparams.dY,calibparams.n_sq_x,calibparams.n_sq_y,calibparams.figurenumber+ii*2);


%%% Computation of the Extrinsic Parameters attached to the grid:

[omc_ext,Tc_ext,Rc_ext,H_ext] = compute_extrinsic(x_ext,X_ext,calibparams.fc,calibparams.cc,calibparams.kc,calibparams.alpha_c);


%%% Reproject the points on the image:

[x_reproj] = project_points2(X_ext,omc_ext,Tc_ext,calibparams.fc,calibparams.cc,calibparams.kc,calibparams.alpha_c);

err_reproj = x_ext - x_reproj;

err_std2 = std(err_reproj')';


Basis = [X_ext(:,[ind_orig ind_x ind_orig ind_y ind_orig ])];

VX = Basis(:,2) - Basis(:,1);
VY = Basis(:,4) - Basis(:,1);

nX = norm(VX);
nY = norm(VY);

VZ = min(nX,nY) * cross(VX/nX,VY/nY);

Basis = [Basis VZ];

[x_basis] = project_points2(Basis,omc_ext,Tc_ext,calibparams.fc,calibparams.cc,calibparams.kc,calibparams.alpha_c);

dxpos = (x_basis(:,2) + x_basis(:,1))/2;
dypos = (x_basis(:,4) + x_basis(:,3))/2;
dzpos = (x_basis(:,6) + x_basis(:,5))/2;



figure(calibparams.figurenumber);
image(I);
colormap(gray(256));
hold on;
plot(x_ext(1,:)+1,x_ext(2,:)+1,'r+');
plot(x_reproj(1,:)+1,x_reproj(2,:)+1,'yo');
h = text(x_ext(1,ind_orig)-25,x_ext(2,ind_orig)-25,'O');
set(h,'Color','g','FontSize',14);
h2 = text(dxpos(1)+1,dxpos(2)-30,'X');
set(h2,'Color','g','FontSize',14);
h3 = text(dypos(1)-30,dypos(2)+1,'Y');
set(h3,'Color','g','FontSize',14);
h4 = text(dzpos(1)-10,dzpos(2)-20,'Z');
set(h4,'Color','g','FontSize',14);
plot(x_basis(1,:)+1,x_basis(2,:)+1,'g-','linewidth',2);
title('Image points (+) and reprojected grid points (o)');

if ~isempty(redcenter)
   plot(redcenter(1),redcenter(2),'co'); 
end

hold off;

fprintf(1,'\n\nExtrinsic parameters:\n\n');
fprintf(1,'Translation vector: Tc_ext = [ %3.6f \t %3.6f \t %3.6f ]\n',Tc_ext);
fprintf(1,'Rotation vector:   omc_ext = [ %3.6f \t %3.6f \t %3.6f ]\n',omc_ext);
fprintf(1,'Rotation matrix:    Rc_ext = [ %3.6f \t %3.6f \t %3.6f\n',Rc_ext(1,:)');
fprintf(1,'                               %3.6f \t %3.6f \t %3.6f\n',Rc_ext(2,:)');
fprintf(1,'                               %3.6f \t %3.6f \t %3.6f ]\n',Rc_ext(3,:)');
fprintf(1,'Pixel error:           err = [ %3.5f \t %3.5f ]\n\n',err_std2); 


calibparams=collectextrinsicparams(calibparams,Rc_ext,Tc_ext);

calibparams.omc0 = omc_ext;
calibparams.Tc0 = Tc_ext;
calibparams.Rc0 = Rc_ext;
calibparams.Hc0 = H_ext;

% % Stores the projected points:
%       
% eval(['y_' num2str(kk) ' = x_reproj;']);
% eval(['X_' num2str(kk) ' = X_ext;']);
% eval(['x_' num2str(kk) ' = x_ext;']);      
%       
%             
% % Organize the points in a grid:
%       
% eval(['n_sq_x_' num2str(kk) ' = n_sq_x;']);
% eval(['n_sq_y_' num2str(kk) ' = n_sq_y;']);
%    