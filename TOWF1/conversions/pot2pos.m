function pos=pot2pos(armparams,potind,potval)

if nargin==1
    error('Invalid number of inputs')
end

pos=[];
for ii=1:numel(potind)
    
    if nargin==2
        potval(ii)=hex2dec(armparams.M2data{potind(ii)}.sendata.jointpos);
    end
    
    pos=[pos; potval(ii)*armparams.linearpot2pos.mm(potind(ii))+armparams.linearpot2pos.bb(potind(ii))];
    
    
end
end