function Jinv=jacobinv_mine(lengths, q)

for ii=1:6
    eval(['th_' num2str(ii) '=q(' num2str(ii) ');']);
    eval(['l' num2str(ii) '=lengths(' num2str(ii) ');']);
end

Jinv=[

];

end