function hex=mydec2hex(dec,nchar)
dec=floor(dec);
if dec<0
    dec=bitcmp(abs(dec)-1,nchar*4);
end
if nargin==2
hex=dec2hex(dec,nchar);
else
 hex=dec2hex(dec);   
end
end