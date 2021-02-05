switch statecur{2}
    case 'camera'
        pause (.001);
        imc = get(himage(statecur{3}),'CData');
        figure(3);
        imshow(imc);
    case 'mouse'
        h4=figure(4);
        imshow(imm{statecur{3}}/max(max(imm{statecur{3}})));
        set(h4,'position',[2000 200 800 800]);
        
    otherwise
        'warning: undefined case in imshow stream'
        
        
end