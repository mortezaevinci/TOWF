%REPEATED FROM CALIBRATEARM case



switch statecur{2}
    case 'armMdata2zerojointpos'
        for ii=1:7
           armparamsarr{statecur{3}}.zeropos(ii,:)= armparamsarr{statecur{3}}.M2data{ii}.sendata.jointpos;
       
            
        end
            save('_armcalib.mat','armparamsarr') 
    otherwise
        'otherwise save case'
        
end