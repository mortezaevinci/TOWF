function line=cross4(p1,p2)
line(1)=det([p1(2:3);p2(2:3)]);
line(2)=-det([p1([1 3]);p2([1 3])]);
line(3)=det([p1(1:2);p2(1:2)]);
line(4)=1;


end