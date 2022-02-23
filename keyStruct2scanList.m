function scanList = keyStruct2scanList(keyStruct)
% function scanList = keyStruct2scanList(keyStruct) 
%
%   example call: % Get a scanList you can use for KbCheck() 
%                   KEY.w = KbName('w');
%                   scanList = keyStruct2scanList(KEY)
%
%
% History:
% 08-07-17 Taka Created  

nKeys = 256;
scanList = zeros(nKeys,1);

keys = fieldnames(keyStruct);
for i=1:numel(keys)
    tmpIndex = keyStruct.(keys{i}); % note that there are two return keys...
    assert(all(tmpIndex>0)&&all(tmpIndex<=nKeys),...
       [mfilename,': the input struct must not contain a value outside [1-256].']);

    scanList(tmpIndex) = 1;
end

scanList = logical(scanList);


% show_where; keyboard; 
