imcap{statecur{3}}.caprgb = get(himage(statecur{3}),'CData');
imcap{statecur{3}}.capgray=rgb2gray(imcap{statecur{3}}.caprgb);
imcap{statecur{3}}.caphsv=rgb2hsv(imcap{statecur{3}}.caprgb);