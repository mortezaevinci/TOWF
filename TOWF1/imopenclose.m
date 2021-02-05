function im=imopenclose(im,se)

im = imclose(im,se);
im = imopen(im,se);

end