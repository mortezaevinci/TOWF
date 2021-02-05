function imm=getfocusimm(himage,vid_src,focusparams)

    set(vid_src,'Focus',focusparams.focusval);
    
    pause(.1);
    data1 = double(get(himage,'CData'));
    data1=data1(:,:,1);
    
     data1=imresize(data1,1/focusparams.immdiv);
     
     Sx = fspecial('sobel');
        Gx = imfilter(data1, Sx, 'replicate', 'conv');
        Gy = imfilter(data1, Sx', 'replicate', 'conv');
        G = Gx.^2 + Gy.^2;
        
        
        imm1 = imfilter(G,focusparams.h1);
   imm2 = imfilter(G,focusparams.h2);
  imm=max(imm1,imm2).^2;
end