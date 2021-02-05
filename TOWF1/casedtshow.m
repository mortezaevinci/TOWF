if skip.video==0
'Camera properties...'
for ii=1:2
    'camera #'
    ii
    
    'intrinsic properties...'
calibparamsarr{ii}
fc0=calibparamsarr{ii}.fc 
cc0=calibparamsarr{ii}.cc 
alpha_c0=calibparamsarr{ii}.alpha_c 
kc0=calibparamsarr{ii}.kc

 

'Software properties...'
get(vid_src(ii),'focus')
%get(vid{ii})



'camera extrinsic parameters to the matching coordinate...'
Rc{ii}=calibparamsarr{ii}.Rc0;
Tc{ii}=calibparamsarr{ii}.Tc0;
Rc0=Rc{ii}
Tc0=Tc{ii}
end



'camera relative positions'
for ii=1:2
    'camera #'
ii
if ii==1
    jj=2;
else
    jj=1;
end

%positions at camera origin, and i-j-k coordinate system units
Xc0=[0 1 0 0;
     0 0 1 0;
     0 0 0 1];

for kk=1:4
    %calculates the position of the other camera in the first camera
    %coordinates
    [Xc0(:,kk) cam2camreference(Xc0(:,kk), Rc{ii},Rc{jj},Tc{ii},Tc{jj})]
end

end
end


try
    
'arm properties'
for jj=1:2
    ['arm number: ' num2str(jj)]
   armparamsarr{jj}.zeropos
   for ii=1:6
       curpot(ii)=hex2dec(armparamsarr{jj}.M2data{ii}.sendata.jointpos);
   end
   'in degrees'
   curpos=pot2pos(armparamsarr{jj},[1;2;3;4;5;6],curpot)*180/pi 
end
end