function write_sequence(sequence, dirResults, T1)

% Check for the existence of the folder:
if(exist(dirResults, 'dir') ~= 7)
    mkdir(dirResults)
end

% Delete previous files:
delete([dirResults, '/*'])

nframes = size(sequence, 3);

t = T1;
for i = 1:nframes
    filenumber = sprintf('%06d', t);
    filepath = strcat(dirResults, 'res_', filenumber, '.png');
    imwrite(sequence(:,:,i), filepath);
    t = t + 1;
end

return

end