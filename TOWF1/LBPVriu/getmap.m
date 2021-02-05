function maps = getmap(samples)
%returns a LBPV uniform and rotation invariant map in a samples
%neighbourhood
maps = 0:2^samples-1;
maxi  = 0;
ind1   = 0;
  maxi = samples + 2;
  for i = 0:2^samples - 1
    numt = sum(bitget(bitxor(i,bitset(bitshift(i,1,samples),1,bitget(i,samples))),1:samples));
    if numt > 2
       maps(i+1) = samples+1;
    else
      maps(i+1) = sum(bitget(i,1:samples));
    end
  end
end
