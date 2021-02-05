img = im2double(imread('corner.jpg'));
img=imresize(img,.2);
[map r c] = SUSAN(img,5);
figure,imshow(img),hold on
plot(c,r,'o')