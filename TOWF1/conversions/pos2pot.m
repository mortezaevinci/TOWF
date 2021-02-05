function pot=pos2pot(armparams,posind,posval)

if nargin==1
    error('Invalid number of inputs')
end

pot=[];
for ii=1:numel(posind)

pot=[pot; (posval(ii)-armparams.linearpot2pos.bb(posind(ii)))./armparams.linearpot2pos.mm(posind(ii))];


end
end