%case filtered out to calibratearm

switch statecur{2}
    case 'calibration'
save('_calibration.mat','calibparamsarr');
    otherwise
        'undefined case for saveign data'
        
end