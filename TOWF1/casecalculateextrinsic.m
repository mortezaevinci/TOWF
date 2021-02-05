switch statecur{2}
    case '2cam'
      iiarr=1:2;
setexternalbycamera;
      if codeparams.stable==0
        save('_calibration.mat','calibparamsarr');
      end
    case '1cam'
        iiarr=statecur{3};
        setexternalbycamera;
        
      if codeparams.stable==0
        save('_calibration.mat','calibparamsarr');
      end
    case '1cam_cycled'
        
      
camnumber=statecur{3};


%statem1={'arm2pos','zero',armnumber};
statem2={'calculateextrinsic','1cam',camnumber};

%NOTE
%last Rc_ext, Tc_ext always equals calibparams{lastcamnumber}.Tc0 or Rc0

statem3={'modifyparameter','Rc0=Rc_ext;Tc0=Tc_ext'';',0};
% statem4={'modifyparameter',['mbedparamsarr{1}.fullcommandparts=[{''' component ''',''10'',''64'',0}; {''00'',''10'',''0'',1}];',0};
% statem42={'mbedCMD','',1};
statemc={'cycle','input(''cycle? 1=true, other=false: '');',0};

statem5={'calculateextrinsic','1cam',camnumber};
statem6={'modifyparameter','Rc1=Rc_ext;Tc1=Tc_ext'';',0};
statem7={'testrefshow','',0};

statecycle=[statem5;statem6;statem7];

statem=[statem2;statem3;statemc;statem];
         
    otherwise
        'Warning: case not found'
end