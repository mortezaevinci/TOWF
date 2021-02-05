%if odd number of characters, the last one will be omitted

function [decstring]=hex2dec_ptbypt(hexstring)
decstring=[];
    for i=1:floor(numel(hexstring)/2)-1
    decstring=[decstring hex2dec(hexstring(1:2))];
        hexstring=hexstring(3:end);
    end
end