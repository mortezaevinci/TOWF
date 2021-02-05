clc

L=[.16 .18 .12 .18 .15 .2];

qdef=[0 0 0 0 0 0];

q=[0 0 0 0 0 0]+qdef;  %x=q-zero, z= pi/2 for either joint 72, 76, 7a ... y=-pi/2 for 74, and pi/2 for 76

                         
Tc_ext = Tc0';
Rc_ext = Rc0;

Tt_ext1=[[Rc_ext Tc_ext];[ 0 0 0 1]]

       
                           
[phi,theta,psai]=Rc2euler(Rc_ext);

tic
Tt_arm=fkine_M26(L,q);
toc

Tc_ext = Tc1';
Rc_ext = Rc1;


Tt_ext2=[[Rc_ext Tc_ext];[ 0 0 0 1]];

[phi,theta,psai]=Rc2euler(Rc_ext)

tt{1}=Tt_ext1;
tt{2}=Tt_ext2;
tt{3}=Tt_arm;
tnum=3;

pws=[     1     1     1     1     1     1
     1     1     1     1     1    -1
     1     1     1     1    -1     1
     1     1     1     1    -1    -1
     1     1     1    -1     1     1
     1     1     1    -1     1    -1
     1     1     1    -1    -1     1
     1     1     1    -1    -1    -1
     1     1    -1     1     1     1
     1     1    -1     1     1    -1
     1     1    -1     1    -1     1
     1     1    -1     1    -1    -1
     1     1    -1    -1     1     1
     1     1    -1    -1     1    -1
     1     1    -1    -1    -1     1
     1     1    -1    -1    -1    -1
     1    -1     1     1     1     1
     1    -1     1     1     1    -1
     1    -1     1     1    -1     1
     1    -1     1     1    -1    -1
     1    -1     1    -1     1     1
     1    -1     1    -1     1    -1
     1    -1     1    -1    -1     1
     1    -1     1    -1    -1    -1
     1    -1    -1     1     1     1
     1    -1    -1     1     1    -1
     1    -1    -1     1    -1     1
     1    -1    -1     1    -1    -1
     1    -1    -1    -1     1     1
     1    -1    -1    -1     1    -1
     1    -1    -1    -1    -1     1
     1    -1    -1    -1    -1    -1
    -1     1     1     1     1     1
    -1     1     1     1     1    -1
    -1     1     1     1    -1     1
    -1     1     1     1    -1    -1
    -1     1     1    -1     1     1
    -1     1     1    -1     1    -1
    -1     1     1    -1    -1     1
    -1     1     1    -1    -1    -1
    -1     1    -1     1     1     1
    -1     1    -1     1     1    -1
    -1     1    -1     1    -1     1
    -1     1    -1     1    -1    -1
    -1     1    -1    -1     1     1
    -1     1    -1    -1     1    -1
    -1     1    -1    -1    -1     1
    -1     1    -1    -1    -1    -1
    -1    -1     1     1     1     1
    -1    -1     1     1     1    -1
    -1    -1     1     1    -1     1
    -1    -1     1     1    -1    -1
    -1    -1     1    -1     1     1
    -1    -1     1    -1     1    -1
    -1    -1     1    -1    -1     1
    -1    -1     1    -1    -1    -1
    -1    -1    -1     1     1     1
    -1    -1    -1     1     1    -1
    -1    -1    -1     1    -1     1
    -1    -1    -1     1    -1    -1
    -1    -1    -1    -1     1     1
    -1    -1    -1    -1     1    -1
    -1    -1    -1    -1    -1     1
    -1    -1    -1    -1    -1    -1];

 
 
for ii1=1:tnum
  for ii2=1:tnum
     for ii3=1:tnum
         for ii4=1:tnum   
           for ii5=1:tnum
              
               
            for pwsi=1:size(pws,1)
                xend=eye(4,4);
                proc=[];
                
                cnum=3;
                for mm=1:cnum
                    eval(['iimm=ii' num2str(mm) ';']);
                    proc=[proc iimm pws(pwsi,mm+size(pws,2)-cnum)];
                xend=xend*tt{iimm}^pws(pwsi,mm);
                end
                
                if xend(1,4)>0.9&xend(1,4)<1
                   proc
                    xend/Tt_arm_simulation
                end
            end
            
               
           end
         end
     end
  end
end

 q2=[-pi/10 0 0 0 0 0]+qdef;
 tic
 Tt_arm_simulation=fkine_M26(L,q2)
 toc
 