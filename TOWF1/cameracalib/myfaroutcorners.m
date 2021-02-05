function faroutcc=myfaroutcorners(I)

try

faroutcc=[];
meandist2center=0;
gaussiansize=[[3 3];[7 7];[11 11];[19 19];[21 21];[25 25];[31 31]];

while(~isempty(gaussiansize))
I=I(:,:,1);
h1=fspecial('gaussian',gaussiansize(1,:),2);
If=imfilter(I,h1);
cc=cornermetric(If,'Harris', 'SensitivityFactor',.05);
cc=cc>.02.*max(max(cc));

n_sq_x=6; %no of elements in y direction
n_sq_y=9; %no of elements in y direction
n_sq=n_sq_x*n_sq_y; % no fo elements

ll=bwlabel(cc,8);

stats=regionprops(ll,'Area','Centroid');
llarea=[stats.Area];
llcentr=[stats.Centroid];
llcentr=reshape(llcentr,2,numel(llcentr)/2)';

if meandist2center~=0
    dist2center=(llcentr(:,1)-centerofcc(1)).^2+(llcentr(:,2)-centerofcc(2)).^2;
    goodind=find(dist2center<(2+0.5)^2*meandist2center);
    llcentr=llcentr(goodind,:);
    llarea=llarea(goodind);
end

[sorttemp, indarea]=sort(llarea,'descend');

goodcc=llcentr(indarea(1:n_sq),:);
goodcc=[goodcc(:,1)';goodcc(:,2)'];
% %goodcen=[x;y];
% figure
% imshow(I);
% hold on
% plot(goodcc(1,:),goodcc(2,:),'r+')
% for jjj=1:n_sq
% text(goodcc(1,jjj),goodcc(2,jjj),num2str(jjj),'Color','b');
% end
% hold off

%check if all corners are correct ones (no outliers)

centerofcc=[mean(goodcc(1,:)) mean(goodcc(2,:))];
dist2center=(goodcc(1,:)-centerofcc(1)).^2+(goodcc(2,:)-centerofcc(2)).^2;
meandist2center=mean(dist2center);
if ~isempty(find(dist2center>(2+.5)^2*meandist2center))
    'bad corner exists'
    
else
    'Warning: a bad corner may exist based on the very simple detection method'
    
    %find the maximum distance between two corners (two far-side corners)
    d=[1 1]; dmax=0;
    for c1=1:size(goodcc,2)-1
        for c2=(c1+1):size(goodcc,2)
               dist2dist=(goodcc(1,c1)-goodcc(1,c2))^2+(goodcc(2,c1)-goodcc(2,c2))^2;
               if dmax<dist2dist
                  dmax=dist2dist;
                  d(1)=c1;d(2)=c2;
               end
        end
    end
    
    %find the two close corners to the two farmost ones (they lie on the
    %edges)
    closec{1}=[0 0];
    %closedist{1}=[500000 500000];
    closec{2}=[0 0];
    %closedist{2}=[500000 500000];
    for ii=1:2
        dist2dist=[];
        for c1=1:size(goodcc,2)
            
            if c1~=d(ii)
                dist2dist=[dist2dist [c1;(goodcc(1,c1)-goodcc(1,d(ii)))^2+(goodcc(2,c1)-goodcc(2,d(ii)))^2]];
              
            end
             
        end
        dist2dist;
        [temp,inds]=sort(dist2dist(2,:));
        closec{ii}(1)=dist2dist(1,inds(1));
        closec{ii}(2)=dist2dist(1,inds(2));
        l{ii}=[lineparams(goodcc(:,closec{ii}(1)),goodcc(:,d(ii))) lineparams(goodcc(:,closec{ii}(2)),goodcc(:,d(ii)))];
    end
 
 
    
    %a automated theshold where the corner should lie on the propsed
    %parallel line
    linethres=sqrt(dmax)/max([n_sq_y,sqrt(n_sq_x^2+n_sq_y^2)])/2;
    
    farc{1}=[1 1];
    fardist{1}=[0 0];
    farc{2}=[1 1];
    fardist{2}=[0 0];
    for ii=1:2
        
       for c1=1:size(goodcc,2)
           %check if the corner is close to the lines on either side
           c1;
           d(ii);
           linedis1=point2line(goodcc(:,c1),l{ii}(1));
           linedis2=point2line(goodcc(:,c1),l{ii}(2));
            if (linedis1<linethres)
                dist2dist=(goodcc(1,c1)-goodcc(1,d(ii)))^2+(goodcc(2,c1)-goodcc(2,d(ii)))^2;
                if fardist{ii}(1)<dist2dist
                    fardist{ii}(1)=dist2dist;
                    farc{ii}(1)=c1;
                end 
            end
            if (linedis2<linethres)
                dist2dist=(goodcc(1,c1)-goodcc(1,d(ii)))^2+(goodcc(2,c1)-goodcc(2,d(ii)))^2;
                if fardist{ii}(2)<dist2dist
                    fardist{ii}(2)=dist2dist;
                    farc{ii}(2)=c1;
                end 
            end
           % pause
       end 
    end
   
    
    faroutc=unique([d(1) d(2) farc{1} farc{2}]);
    faroutcc=goodcc(:,faroutc); 
    if numel(faroutc)==4
          break; 
    end
    
 
end

gaussiansize=gaussiansize(2:end,:);
end %while

end

end