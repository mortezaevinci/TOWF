function [qout isconverged] = ikine_M26_cc(TT, L, q0) %#codegen


    method=1; %0 for ordinary jacobean, 1 for DLS
    
	%
	%  solution control parameters
	%
	ilimit = 250;
	stol = 1e-2;

	isconverged=1;
dq=zeros(6,1);

	if nargin == 2,
		q = zeros(6, 1);
	else
		q = q0(:);
    end
    
    n = numel(q);
   
		if n == 6
		
		

	tcount = 0;
% 	if ishomog(tr),		% single xform case
		nm = 5;
		count = 0;
		while nm > stol,
            
			dx = -T2cartesian_real(fkine_M26(L, q'))+T2cartesian_real(TT);
            
            switch method
                case 0
            
		             	dq = rem(pinv( jacob_M26(L, q) ) * dx,2*pi);
            
            
                case 1
                  
                        J=jacob_M26(L, q);
                        lambda=.005;
                        
                         qq=J*J'+lambda*eye(6);
                        if det(qq)~=0
                        dq=rem(J'*(qq)^-1*dx,2*pi)/10;
                        else
                        dq=q;
                        count=count+500; %finish
                        end
                    
            end
                
               
            
			q = rem(q + dq,2*pi);%+rand(6,1).*.0001;
            for ii=1:numel(q)
               if q(ii)>pi
                   q(ii)=q(ii)-2*pi;
               end
               if q(ii)<-pi
                   q(ii)=q(ii)+2*pi;
               end
            end
            
            %a non-mathematical enforcement of solution constraints
            if q(4)>0
%                 %possibility1
%                q(1)=-q(1);
%                q(3)=-q(3);
%                q(5)=-q(5);

q=kine_sol2(q);
            end
            
            q=myjointlimits(q);
            
%             %specific to M26
%             if q(3)<0
%                q(3)=q(3)+pi;
%                q(4)=-q(4);
%                if q(5)<0
%                q(5)=q(5)+pi;
%                else
%                    q(5)=q(5)-pi;
%                end
%                 
%             end
            
            
			nm = norm(dq);
            if isnan(nm)
                nm=5;
            end
			count = count+1;
			if count > ilimit,
				
                isconverged=0;
                break;
			end
		end
		qout = q;
        else
            	
                isconverged=0;
        end