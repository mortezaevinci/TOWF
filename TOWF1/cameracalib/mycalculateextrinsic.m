
trypic=[];

while(isempty(trypic))
    for ii=iiarr
        Iarr{ii} = get(himage(ii),'CData');%imread('picture 4.jpg');
       
        figure(3);
        subplot(1,2,ii)
        imshow(Iarr{ii});
        subplot(1,2,ii)
        imshow(Iarr{ii});   
        trypic='0';%input('try this image? ([]=no');
    end
end

for ii=iiarr
calibparams=calibparamsarr{ii};

%calibparams.dX=0.024;
%calibparams.dY=0.024;

I=Iarr{ii};


myextrinsic_computation;
     
calibparamsarr{ii}=calibparams;

end


