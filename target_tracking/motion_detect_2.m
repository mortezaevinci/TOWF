

stepframe =0;%֡����ļ��
frameNO =80; %��ʼ֡���
framenum =5; %�ܵ�֡��

stepy = 8; %�ֿ�ĳߴ�
stepx = 8;

sss = 'ball2.AVI'
video1=mmreader(sss);
dim_x             = video1.Width;

dim_y             = video1.Height;

%MMM = moviein(framenum);
FLAG = 1; %�м�ͼ��������ƿ���
FLAGM =0;%ȥ����Ӱ�㷨����
FLAGR = 1;%�м����Ƿ����
mtype =1;%mtype=1��ʾ����type=0��ʾ��ʮ��

%����ʱ��
time_inint=0;
time_read = 0;
time_bi = 0;
time_back = 0;
time_check = 0;
time_filter = 0;
time_lock = 0;

% ��ȡ2���ο�֡
tic %starts a stopwatch timer
%MF = read(video,frameNO); % read a audio or video interleaves(AVI) file
X=read(video1,frameNO);  %convert movie frame to indexed image
pic1 = rgb2gray(X); %change RGB image to gray image
pic1 = double(pic1);%convert to double precision
X= read(video1,frameNO+1);
pic2 = rgb2gray(X);
pic2 = double(pic2);

% ��ʼ��alpha
alpha = 0.618;
num = 1;
time_inint = toc;% prints the elapsed time since tic was used.

for frame = frameNO+2:1+stepframe:frameNO+framenum
    time_read = 0;
    time_bi = 0;
    time_back = 0;
    time_check = 0;
    time_filter = 0;
    time_lock = 0;
    
    % ��ȡ��ǰ֡ͼ��
    indexframe = frame;
    tic
%     MF = read(video,indexframe);
    pic = read(video1,indexframe);
    curr = rgb2gray(pic);
    curr = double(curr);
    time_read = toc;
    tic
    % ��������Ӧ����
    if frame==frameNO+2
       pred = alpha*pic1 + (1 - alpha)*pic2;
    else
       %�ֿ���±���
       for jj = 1:M
           for ii = 1:N
               temp1 = pic1((jj-1)*stepy+1:jj*stepy,(ii-1)*stepx+1:ii*stepx);
               temp2 = pic2((jj-1)*stepy+1:jj*stepy,(ii-1)*stepx+1:ii*stepx);
               s = mmap(jj,ii);
               if s==255
                  pred((jj-1)*stepy+1:jj*stepy,(ii-1)*stepx+1:ii*stepx) = (1-alpha)*temp2+alpha*temp1;
              else
                  pred((jj-1)*stepy+1:jj*stepy,(ii-1)*stepx+1:ii*stepx) = (alpha)*temp2+(1-alpha)*temp1;
              end
          end
      end
  end
  time_back = toc;
  if FLAG
     figure,imshow(uint8(floor(pred+0.5)));
     title('����');
  end
    tic
    % ����в�����
    Error = abs(curr - pred); %floor(0.5+abs(y - pred));
    
    % �����洢�ռ�
     pic1 = pic2;
     pic2 = curr;
    
    % ����в��ƽ��ֵ
    [a,b] = size(Error);
    temp = sum(sum(Error));
    m = temp/(a*b);
    
    % alpha�ĸ���
    alpha = exp(-2/m);
    
    % ��ֵ������ֵ����Ӧ����
    T = 5*m; %��ֵ������
    for i =1:a
       for j = 1:b
           if Error(i,j) < T
              Error(i,j) = 0;
           else
              Error(i,j) = 255;
           end
       end
    end
    time_bi = toc;
    if FLAG
        ss = uint8(Error);
        figure,imshow(ss);
        title('��ֵ��');
    end
    tic
    %����ӳ�����
    M = floor(a/stepy);
    N = floor(b/stepx);
    mmap = zeros(M,N);
    for i = 1:M
       for j =1:N
          temp = sum(sum(Error((i-1)*stepy+1:i*stepy,(j-1)*stepx+1:j*stepx)));
          if temp >255*stepx*stepy*0.15;
              mmap(i,j) =255;
          end
       end
    end 
    time_check = toc;
    if FLAG
       %figure,imshow(mmap);
       %title('ӳ�����ͼ����ֵ�ָ');  
       vv = Error;
       for j = 1:M
          for i = 1:N
              if mmap(j,i) == 255
                  vv((j-1)*stepy+1:j*stepy,(i-1)*stepx+1:i*stepx) = 255;
              else
                  vv((j-1)*stepy+1:j*stepy,(i-1)*stepx+1:i*stepx) = 0;
              end
          end
       end
      figure,imshow(vv);
      title('��ֵ�ָ�');
    end

    tic
    %��ͨ����
    mcount = 1;%����ı��ֵ
    marea = zeros(M,N); %��������ž��󣬳�ʼΪ0
    for j =1:M
      for i = 1:N
        if mmap(j,i)==255 && i+j>2
            if i==1 
                flag1 = marea(j-1,i);
                flag2 = flag1;
            elseif j ==1
                flag2 = marea(j,i-1);
                flag1 = flag2;
            else
                flag1 = marea(j-1,i);
                flag2 = marea(j,i-1);
            end
            
            if flag1+flag2 == 0 %��ʾ�������߾��ޱ��
                marea(j,i) = mcount;
                mcount = mcount + 1;
            elseif (flag1 && flag2) == 0 % ��ʾ�ϱߺ����ֻ��һ�����
                marea(j,i) = flag1 + flag2;
            elseif flag1==flag2 %��ʾ�������ߵı����ͬ
                marea(j,i) = flag1;
            else %��ʾ�������ߵı�Ų�ͬ
                flagmin = min(flag1,flag2);
                flagmax = max(flag1,flag2);
                marea(j,i) = flagmin;
                %�����Ϊflag2�ľ���Ϊflag1
                for jj = 1:M
                    for ii = 1:N
                        if marea(jj,ii)==flagmax
                            marea(jj,ii) = flagmin;
                        end
                    end
                end
            end
          end
        end
     end
     
     time_check = time_check + toc;
     
     tic
     % ͳ�Ƹ�������Ĵ�С
     msum = zeros(1,mcount-1);
     for i = 1:M*N
       temp = marea(i);
       if temp~=0
          msum(temp) = msum(temp) + 1;%ͳ��ÿ�������Ŀ���
       end
     end
     
    % �趨��ֵ��ȥ������СĿ��
     Tnum = 6;  % �����������������,��Ŀ��ȡֵ�ϴ�СĿ��ȡֵ��С
     % ����Ӧ����
     %Tnum = 6;
     Tnum = sum(msum)*0.15;
     if Tnum < 1
         Tnum = 1;
     end
     %Tnum = 2;
     for i = 1:M*N
       if mmap(i)~=0 % Ŀ������
           z = marea(i);% ������
           if z > 0
             if msum(z) <= Tnum 
                mmap(i)  = 0;
                marea(i) = 0;
             end
           end
         end
      end
      %if FLAG
      %   figure,imshow(mmap);
      %   title('ӳ�����ͼ�񣨳�ȥ����С����');
      %end

      % �����ڲ��׶�
      for j = 2:M
        for i = 2:N
          value1 = mmap(j-1,i);
          value2 = mmap(j,i-1);
          value0 = mmap(j,i);
          flag1 = marea(j-1,i);
          flag2 = marea(j,i-1);
          if value1 && value2 && (value0==0)
              mmap(j,i)  = 255;
              minflag = min(flag1,flag2);
              marea(j,i) = minflag; 
              if flag1 ~= flag2
                maxflag = max(flag1,flag2);
                for ii = 1:M*N
                  if marea(ii) == maxflag;
                      marea(ii) = minflag;
                  end
                end
              end
           end
        end
     end
  time_filter = toc;
  
  tic
     % �ٴ���ͨ����
     for j =1:M
       for i =2:N
         flag0 = marea(j,i);
         flag1 = marea(j,i-1);
         %flag2 = marea(j,i-1);
         if flag1>0 && flag0>0 && flag0~=flag1
                for ii = 1:M*N
                    if marea(ii)==flag0
                        marea(ii)=flag1;
                    end
                end
          end
        %��һ��ѭ������
       end
    end
    time_check = time_check + toc;  
    
    % ����ͳ�Ƹ�����Ŀ���
    msum = zeros(1,mcount-1);
    for i = 1:M*N
       temp = marea(i);
       if temp~=0
         msum(temp) = msum(temp) + 1;%ͳ��ÿ�������Ŀ���
       end
    end
   msum;
   if 1%FLAG
      %figure,imshow(mmap);
      %title('ӳ�����ͼ�񣨳�ȥ�ڲ��׶���');
      %����ӳ�������¶�ֵͼ��
      for j = 1:M
        for i = 1:N
           if mmap(j,i) == 255
               Error((j-1)*stepy+1:j*stepy,(i-1)*stepx+1:i*stepx) = 255;
           else
               Error((j-1)*stepy+1:j*stepy,(i-1)*stepx+1:i*stepx) = 0;
           end
         end
      end
      if FLAGR
         figure,imshow(Error);
         title('�����ͼ��');
     end
    end
    tic
    % ����Ŀ�������
    q = 0;
     Tnum = sum(msum)*0.1;
    for k = 1: mcount-1%��Ŀ��
    if msum(k) > Tnum
      q = q+1;% ����q��Ŀ��
      mminx0 = N;
      mminy0 = M;
      mmaxx0 = 1;
      mmaxy0 = 1;
      for j = 1:M
        for i = 1:N
         if mmap(j,i)~=0 && marea(j,i)==k
            mminx0 = min(i,mminx0);
            mminy0 = min(j,mminy0);
            mmaxx0 = max(i,mmaxx0);
            mmaxy0 = max(j,mmaxy0);
         end
        end
      end
      % ������Ӱ���������������㷨����L��Ŀ���������Ӱ
   if FLAGM
      kx1 = mminx0;
      kx2 = floor((mminx0+mmaxx0)/2);
      ky1 = mminy0;
      ky2 = floor((mminy0+mmaxy0)/2);
      mmaxx0 = 2*kx2-kx1;
      mmaxy0 = 2*ky2-ky1;
      [kx1 kx2 mmaxx0 ky1 ky2 mmaxy0]
      bb0= mmap(ky1:ky2,kx1:kx2)/255;
      bb1= mmap(ky1:ky2,kx2+1:mmaxx0)/255;
      bb2= mmap(ky2+1:mmaxy0,kx1:kx2)/255;
      bb3= mmap(ky2+1:mmaxy0,kx2+1:mmaxx0)/255;
      bv0 = sum(sum(bb0))/((ky2-ky1+1)*(kx2-kx1+1));
      bv1 = sum(sum(bb1))/((ky2-ky1+1)*(mmaxx0-kx2)+0.1);
      bv2 = sum(sum(bb2))/((mmaxy0-ky2+1)*(kx2-kx1+1));
      bv3 = sum(sum(bb3))/((mmaxy0-ky2+1)*(mmaxx0-kx2)+0.1);
      bv = (bv0+bv1+bv2+bv3)/4;
      [bv bv0 bv1 bv2 bv3]
      if (bv0 < 0.45*bv)+(bv2<0.45*bv) > 0   %
          mminx0 = kx2;
      end
      if (bv1 < 0.45*bv)+(bv3<0.45*bv) > 0   %
          mmaxx0 = kx2;
      end
   end
      %k
      mminx(q) = (mminx0-1)*stepx+1;
      mminy(q) = (mminy0-1)*stepy+1;
      mmaxx(q) = mmaxx0*stepx;
      mmaxy(q) = mmaxy0*stepy;

     end
    end

    % ����
    for k =1 : q
         ylen = mmaxy(k) - mminy(k);
         xlen = mmaxx(k) - mminx(k);
         ratioxy = ylen/(xlen+0.01);
     if (mminy(k) > 2) && (ratioxy >0.2) && (ratioxy<6)
      if mtype==1
         pic(mminy(k),mminx(k):mmaxx(k),1:3) = 255;
         pic(mmaxy(k),mminx(k):mmaxx(k),1:3) = 255;
         pic(mminy(k):mmaxy(k),mminx(k),1:3) = 255;
         pic(mminy(k):mmaxy(k),mmaxx(k),1:3) = 255;
     else
         centx = floor(0.5+(mminx(k)+mmaxx(k))/2);
         centy = floor(0.5+(mminy(k)+mmaxy(k))/2);
         centx0 = centx-10;
         centx1 = centx+10;
         centy0 = centy-10;
         centy1 = centy+10;
         if centx0 < 1
            centx0 = 1;
         end
         if centy0 < 1
            centy0 = 1;
         end
         if centx1 > b
            centx1 = b;
         end
         if centy1 > a
            centy1 = a;
         end
         
         pic(centy0:centy1,centx,1) = 255;
         pic(centy0:centy1,centx,2) = 0;
         pic(centy0:centy1,centx,3) = 0;
         pic(centy,centx0:centx1,1) = 255;
         pic(centy,centx0:centx1,2) = 0;
         pic(centy,centx0:centx1,3) = 0;
     end
     end
    end
    time_lock = toc;
    num = q;
    figure,imshow(pic);
    MMM(indexframe-frameNO-1) = getframe;
    title('����Ч��ͼ');
    

    for e = 1:stepframe
      indexframe = frame+e;
      MF = aviread(sss,indexframe);
      pic = frame2im(MF);
      for k =1 : q
        if (mminy(k) > 2) && (ratioxy >0.2) && (ratioxy<8)
           if mtype == 1
             pic(mminy(k),mminx(k):mmaxx(k),1:3) = 255;
             pic(mmaxy(k),mminx(k):mmaxx(k),1:3) = 255;
             pic(mminy(k):mmaxy(k),mminx(k),1:3) = 255;
             pic(mminy(k):mmaxy(k),mmaxx(k),1:3) = 255;
          else
            centx = floor(0.5+(mminx(k)+mmaxx(k))/2);
            centy = floor(0.5+(mminy(k)+mmaxy(k))/2);
            centx0 = centx-10;
            centx1 = centx+10;
            centy0 = centy-10;
            centy1 = centy+10;
            if centx0 < 1
               centx0 = 1;
            end
            if centy0 < 1
               centy0 = 1;
            end
            if centx1 > b
               centx1 = b;
            end
            if centy1 > a
               centy1 = a;
            end
         
            pic(centy0:centy1,centx,1) = 255;
            pic(centy0:centy1,centx,2) = 0;
            pic(centy0:centy1,centx,3) = 0;
            pic(centy,centx0:centx1,1) = 255;
            pic(centy,centx0:centx1,2) = 0;
            pic(centy,centx0:centx1,3) = 0;
           end
        end
      end

      ratioxy;
      figure,imshow(pic);
      MMM(indexframe-frameNO-1) = getframe;
      title('����Ч��ͼ');
  end
  [time_inint time_read time_back time_bi time_check time_filter time_lock];
 close all;
end
    
    close all;
    movie2avi(MMM,'result100.avi','FPS',30,'QUALITY',100,'KEYFRAME',15);
    close all
    
        
        
        
    
   