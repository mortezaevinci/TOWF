function m2data=generatesendetail(m2data)
   offset=0;
   
   offsets=[0 2 4 6 8 12 13 14 15 16 18 20 24 26 28 30 32 34 36 38 40 inf]*2';
   descriptions=['motorpos';
                'motorspd';
                'jointpos';
                'jointspd';
                'undocumm';
                'mtrposid';
                'mtrconid';
                'undocumm';
                'jntposid';
                'minmtrps';
                'maxmtrps';
                'undocumm';
                'Pmtrpos_';
                'Imtrpos_';
                'Dmtrpos_';
                'mtrpsinv';
                'jntpsinv';
                'internal';
                'Pjntspd_';
                'Ijntspd_';
                'Djntspd_';];
   while(offsets(find(offsets==offset)+1)<=numel(m2data.sendata.raw))
       ind=find(offsets==offset);
     %  ['m2data.sendata.' descriptions(ind,:) '=''' num2str(m2data.sendata.raw((offsets(ind)+1):offsets(ind+1))) ''';']
        eval(['m2data.sendata.' descriptions(ind,:) '=''' num2str(m2data.sendata.raw((offsets(ind)+1):offsets(ind+1))) ''';']);
       offset=offsets(ind+1);
   end
end