
ex = []; % Global error vector
x = []; % Detected corners on the image plane
y = []; % Reprojected points

if ~exist('alpha_c'),
   alpha_c = 0;
end;

for kk = 1:n_img,
   
   eval(['omckk = omc_' num2str(kk) ';']);
   eval(['Tckk = Tc_' num2str(kk) ';']);   
   
   if (~isnan(omckk(1,1))),
      
      %Rkk = rodrigues(omckk);
      
      eval(['calibparams.y{' num2str(kk) '}  = project_points2(calibparams.X{' num2str(kk) '},omckk,Tckk,fc,cc,kc,alpha_c);']);
      
      eval(['calibparams.ex{' num2str(kk) '} = calibparams.x{' num2str(kk) '} - calibparams.y{' num2str(kk) '};']);
      
      eval(['x_kk = calibparams.x{' num2str(kk) '};']);
      
      eval(['ex = [ex calibparams.ex{' num2str(kk) '}];']);
      eval(['x = [x calibparams.x{' num2str(kk) '}];']);
      eval(['y = [y calibparams.y{' num2str(kk) '}];']);
      
   else
      
      %	eval(['y_' num2str(kk) '  = NaN*ones(2,1);']);

   
      % If inactivated image, the error does not make sense:
      eval(['calibparams.ex{' num2str(kk) '} = NaN*ones(2,1);']);
      
   end;
   
end;

err_std = std(ex')';
