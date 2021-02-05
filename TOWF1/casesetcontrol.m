switch statecur{2}
  
    case 'matfromfile'
         load '_controlparams.mat';
         
    otherwise
        'warning: case in calibratearm doesn''t exist.'
        
end