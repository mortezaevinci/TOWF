function calibparams=collectextrinsicparams(calibparams,Rc_ext,Tc_ext)
    if isfield(calibparams,'HTc')
        newind=numel(calibparams.HTc)+1;
        
    else
        newind=1;
    end
    
calibparams.HTc{newind}=[[Rc_ext Tc_ext];[0 0 0 1]];
end