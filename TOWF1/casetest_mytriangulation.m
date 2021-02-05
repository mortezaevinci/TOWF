'camera #1 image'

for ii=1:2

imc = get(himage(ii),'CData');

figure(7);
imshow(imc);
[x,y]=ginput(1);
Pc{ii}=[x;y];
end

statem=[{'posbycams','',1};
    statem];

