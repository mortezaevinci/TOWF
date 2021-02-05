for i=1:6
    eval(['th_' num2str(i) '=sym(''th_' num2str(i) ''',''real'');']);
    eval(['l' num2str(i) '=sym(''l' num2str(i) ''',''real'');']);
end