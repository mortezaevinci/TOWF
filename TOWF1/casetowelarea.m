camnumber=statecur{3}; 
%statecur{2}='istop';
towelifgreen=imcap{camnumber}.caphsv(:,:,1)>towelanalysis{camnumber}.hsv_glow & imcap{camnumber}.caphsv(:,:,1)<towelanalysis{camnumber}.hsv_ghigh & imcap{camnumber}.caphsv(:,:,2)>towelanalysis{camnumber}.hsv_lhigh;
towelifblue=imcap{camnumber}.caphsv(:,:,1)>towelanalysis{camnumber}.hsv_blow & imcap{camnumber}.caphsv(:,:,1)<towelanalysis{camnumber}.hsv_bhigh & imcap{camnumber}.caphsv(:,:,2)>towelanalysis{camnumber}.hsv_lhigh;

countg=nnz(towelifgreen);
countb=nnz(towelifblue);

if countg>countb
    towelanalysis{camnumber}.towelarea=towelifgreen;
else
    towelanalysis{camnumber}.towelarea=towelifblue;
end

switch statecur{2}
    case 'istop'
        [trr,tcc]=size(towelanalysis{camnumber}.towelarea);
        towelanalysis{camnumber}.towelarea(floor(trr*2/3):end,:)=0;  
end


towelanalysis{camnumber}.towelarea=bwmorph(towelanalysis{camnumber}.towelarea,'close');

towelanalysis{camnumber}.towelarea=bwmorph(towelanalysis{camnumber}.towelarea,'majority');

towelanalysis{camnumber}.towelarea=imfill(towelanalysis{camnumber}.towelarea,'holes');

openclosesize=8;

towelanalysis{camnumber}.towelarea(1:(openclosesize-2),:)=1;
towelanalysis{camnumber}.towelarea((end-(openclosesize-2)):end,:)=1;

se = strel('disk',openclosesize);
towelanalysis{camnumber}.towelarea = imopenclose(towelanalysis{camnumber}.towelarea,se);

towelanalysis{camnumber}.towelarea=bwmorph(towelanalysis{camnumber}.towelarea,'dilate');

lbs=bwlabel(towelanalysis{camnumber}.towelarea);
props=regionprops(lbs,'area');
[~,bigind]=max([props.Area]);
towelanalysis{camnumber}.towelarea=lbs==bigind;

figure(20+camnumber);

imarea=imcap{camnumber}.caprgb;
imarea(:,:,1)=imarea(:,:,1)+uint8(towelanalysis{camnumber}.towelarea.*100);
imshow(imarea);

'press any key to continue'
pause;
