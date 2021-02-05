function imm=getfocusimm(himage,vid_src,focusparams)

    set(vid_src,'Focus',focusparams.focusval);
    
    %pause(.02);
    data1 = get(himage,'CData');
   
    for ii=1:focusparams.immdiv:size(data1,1)
        for jj=1:focusparams.immdiv:size(data1,2)
            
            miny=ii-focusparams.wsize(1);
            if miny<1
                miny=1;
            end
            maxy=ii+focusparams.wsize(1);
            if maxy>size(data1,1)
                maxy=size(data1,1);
            end
            minx=jj-focusparams.wsize(2);
            if minx<1
                minx=1;
            end
            maxx=jj+focusparams.wsize(2);
            if maxx>size(data1,2)
                maxx=size(data1,2);
            end
            
          
    data1w=data1(miny:maxy,minx:maxx);
    imm((ii-1)/focusparams.immdiv+1,(jj-1)/focusparams.immdiv+1)=focusmeasure(data1w,'TENV',[]);
    
%      Sx = fspecial('sobel');
%         Gx = imfilter(double(Image), Sx, 'replicate', 'conv');
%         Gy = imfilter(double(Image), Sx', 'replicate', 'conv');
%         G = Gx.^2 + Gy.^2;
%     
%      I2 = nlfilter(I,[3 3],'std2');
    
        end
    end
    
  
end