function TT=fkine_M26(lengths,q)
for ii=1:6
    eval(['th_' num2str(ii) '=q(' num2str(ii) ');']);
    eval(['l' num2str(ii) '=lengths(' num2str(ii) ');']);
end


%created by M2d .... it is the new M26
TT=[
[ sin(th_6)*(sin(th_4)*(sin(th_1)*sin(th_3) - cos(th_1)*cos(th_2)*cos(th_3)) - cos(th_1)*cos(th_4)*sin(th_2)) - cos(th_6)*(cos(th_5)*(cos(th_4)*(sin(th_1)*sin(th_3) - cos(th_1)*cos(th_2)*cos(th_3)) + cos(th_1)*sin(th_2)*sin(th_4)) + sin(th_5)*(cos(th_3)*sin(th_1) + cos(th_1)*cos(th_2)*sin(th_3))), sin(th_5)*(cos(th_4)*(sin(th_1)*sin(th_3) - cos(th_1)*cos(th_2)*cos(th_3)) + cos(th_1)*sin(th_2)*sin(th_4)) - cos(th_5)*(cos(th_3)*sin(th_1) + cos(th_1)*cos(th_2)*sin(th_3)),   cos(th_6)*(sin(th_4)*(sin(th_1)*sin(th_3) - cos(th_1)*cos(th_2)*cos(th_3)) - cos(th_1)*cos(th_4)*sin(th_2)) + sin(th_6)*(cos(th_5)*(cos(th_4)*(sin(th_1)*sin(th_3) - cos(th_1)*cos(th_2)*cos(th_3)) + cos(th_1)*sin(th_2)*sin(th_4)) + sin(th_5)*(cos(th_3)*sin(th_1) + cos(th_1)*cos(th_2)*sin(th_3))), l1*cos(th_1) + (sin(th_4)*(sin(th_1)*sin(th_3) - cos(th_1)*cos(th_2)*cos(th_3)) - cos(th_1)*cos(th_4)*sin(th_2))*(l4 + l5) - l6*cos(th_6)*(cos(th_5)*(cos(th_4)*(sin(th_1)*sin(th_3) - cos(th_1)*cos(th_2)*cos(th_3)) + cos(th_1)*sin(th_2)*sin(th_4)) + sin(th_5)*(cos(th_3)*sin(th_1) + cos(th_1)*cos(th_2)*sin(th_3))) - cos(th_1)*sin(th_2)*(l2 + l3) + l6*sin(th_6)*(sin(th_4)*(sin(th_1)*sin(th_3) - cos(th_1)*cos(th_2)*cos(th_3)) - cos(th_1)*cos(th_4)*sin(th_2))]
[ cos(th_6)*(cos(th_5)*(cos(th_4)*(cos(th_1)*sin(th_3) + cos(th_2)*cos(th_3)*sin(th_1)) - sin(th_1)*sin(th_2)*sin(th_4)) + sin(th_5)*(cos(th_1)*cos(th_3) - cos(th_2)*sin(th_1)*sin(th_3))) - sin(th_6)*(sin(th_4)*(cos(th_1)*sin(th_3) + cos(th_2)*cos(th_3)*sin(th_1)) + cos(th_4)*sin(th_1)*sin(th_2)), cos(th_5)*(cos(th_1)*cos(th_3) - cos(th_2)*sin(th_1)*sin(th_3)) - sin(th_5)*(cos(th_4)*(cos(th_1)*sin(th_3) + cos(th_2)*cos(th_3)*sin(th_1)) - sin(th_1)*sin(th_2)*sin(th_4)), - cos(th_6)*(sin(th_4)*(cos(th_1)*sin(th_3) + cos(th_2)*cos(th_3)*sin(th_1)) + cos(th_4)*sin(th_1)*sin(th_2)) - sin(th_6)*(cos(th_5)*(cos(th_4)*(cos(th_1)*sin(th_3) + cos(th_2)*cos(th_3)*sin(th_1)) - sin(th_1)*sin(th_2)*sin(th_4)) + sin(th_5)*(cos(th_1)*cos(th_3) - cos(th_2)*sin(th_1)*sin(th_3))), l1*sin(th_1) - (sin(th_4)*(cos(th_1)*sin(th_3) + cos(th_2)*cos(th_3)*sin(th_1)) + cos(th_4)*sin(th_1)*sin(th_2))*(l4 + l5) + l6*cos(th_6)*(cos(th_5)*(cos(th_4)*(cos(th_1)*sin(th_3) + cos(th_2)*cos(th_3)*sin(th_1)) - sin(th_1)*sin(th_2)*sin(th_4)) + sin(th_5)*(cos(th_1)*cos(th_3) - cos(th_2)*sin(th_1)*sin(th_3))) - sin(th_1)*sin(th_2)*(l2 + l3) - l6*sin(th_6)*(sin(th_4)*(cos(th_1)*sin(th_3) + cos(th_2)*cos(th_3)*sin(th_1)) + cos(th_4)*sin(th_1)*sin(th_2))]
[                                                                                                                           cos(th_6)*(cos(th_5)*(cos(th_2)*sin(th_4) + cos(th_3)*cos(th_4)*sin(th_2)) - sin(th_2)*sin(th_3)*sin(th_5)) + sin(th_6)*(cos(th_2)*cos(th_4) - cos(th_3)*sin(th_2)*sin(th_4)),                                                                             - sin(th_5)*(cos(th_2)*sin(th_4) + cos(th_3)*cos(th_4)*sin(th_2)) - cos(th_5)*sin(th_2)*sin(th_3),                                                                                                                             cos(th_6)*(cos(th_2)*cos(th_4) - cos(th_3)*sin(th_2)*sin(th_4)) - sin(th_6)*(cos(th_5)*(cos(th_2)*sin(th_4) + cos(th_3)*cos(th_4)*sin(th_2)) - sin(th_2)*sin(th_3)*sin(th_5)),                                                                                                                                                                                                (l4 + l5)*(cos(th_2)*cos(th_4) - cos(th_3)*sin(th_2)*sin(th_4)) + cos(th_2)*(l2 + l3) + l6*sin(th_6)*(cos(th_2)*cos(th_4) - cos(th_3)*sin(th_2)*sin(th_4)) + l6*cos(th_6)*(cos(th_5)*(cos(th_2)*sin(th_4) + cos(th_3)*cos(th_4)*sin(th_2)) - sin(th_2)*sin(th_3)*sin(th_5))]
[                                                                                                                                                                                                                                                                                                       0,                                                                                                                                                                             0,                                                                                                                                                                                                                                                                                                         0,                                                                                                                                                                                                                                                                                                                                                                                                                                                                          1]
 ];

end