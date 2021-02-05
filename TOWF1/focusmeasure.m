 function fmeasure = focusmeasure(Image, Measure, ROI)
%relative degree of focus of 
%an image. 
%   is a grayscale image and fmeasure is the computed
%           focus value.
%   Method is the focus measure algorithm
%   ROI,    Image ROI as a rectangle [xo yo width heigth].
%           if an empty argument is passed, the whole
%           image is processed.


if ~isempty(ROI)
    Image = imcrop(Image, ROI);
end

WSize = 15; % Size of local window (only some operators)

switch upper(Measure)
       
        
    case 'HELM' %Helmli's mean method (Helmli2001)        
        MEANF = fspecial('average',[WSize WSize]);
        U = imfilter(Image, MEANF, 'replicate');
        R1 = U./Image;
        R1(Image==0)=1;
        index = (U>Image);
        fmeasure = 1./R1;
        fmeasure(index) = R1(index);
        fmeasure = mean2(fmeasure);
        
        
        
    case 'LAPD' % Diagonal laplacian (Thelen2009)
        M1 = [-1 2 -1];
        M2 = [0 0 -1;0 2 0;-1 0 0]/sqrt(2);
        M3 = [-1 0 0;0 2 0;0 0 -1]/sqrt(2);
        F1 = imfilter(Image, M1, 'replicate', 'conv');
        F2 = imfilter(Image, M2, 'replicate', 'conv');
        F3 = imfilter(Image, M3, 'replicate', 'conv');
        F4 = imfilter(Image, M1', 'replicate', 'conv');
        fmeasure = abs(F1) + abs(F2) + abs(F3) + abs(F4);
        fmeasure = mean2(fmeasure);
        
    case 'SFIL' %Steerable filters (Minhas2009)
        % Angles = [0 45 90 135 180 225 270 315];
        N = floor(WSize/2);
        sig = N/2.5;
        [x,y] = meshgrid(-N:N, -N:N);
        G = exp(-(x.^2+y.^2)/(2*sig^2))/(2*pi*sig);
        Gx = -x.*G/(sig^2);Gx = Gx/sum(Gx(:));
        Gy = -y.*G/(sig^2);Gy = Gy/sum(Gy(:));
        R(:,:,1) = imfilter(double(Image), Gx, 'conv', 'replicate');
        R(:,:,2) = imfilter(double(Image), Gy, 'conv', 'replicate');
        R(:,:,3) = cosd(45)*R(:,:,1)+sind(45)*R(:,:,2);
        R(:,:,4) = cosd(135)*R(:,:,1)+sind(135)*R(:,:,2);
        R(:,:,5) = cosd(180)*R(:,:,1)+sind(180)*R(:,:,2);
        R(:,:,6) = cosd(225)*R(:,:,1)+sind(225)*R(:,:,2);
        R(:,:,7) = cosd(270)*R(:,:,1)+sind(270)*R(:,:,2);
        R(:,:,7) = cosd(315)*R(:,:,1)+sind(315)*R(:,:,2);
        fmeasure = max(R,[],3);
        fmeasure = mean2(fmeasure);
        
        
    case 'TENG'% Tenengrad (Krotkov86)
        Sx = fspecial('sobel');
        Gx = imfilter(double(Image), Sx, 'replicate', 'conv');
        Gy = imfilter(double(Image), Sx', 'replicate', 'conv');
        fmeasure = Gx.^2 + Gy.^2;
        fmeasure = mean2(fmeasure);
        
    case 'TENV' % Tenengrad variance (Pech2000)
        Sx = fspecial('sobel');
        Gx = imfilter(double(Image), Sx, 'replicate', 'conv');
        Gy = imfilter(double(Image), Sx', 'replicate', 'conv');
        G = Gx.^2 + Gy.^2;
        fmeasure = std2(G)^2;
        
  
    otherwise
        error('Unknown measure %s',upper(Measure))
end
 end
