classdef PtbMap < handle
properties
    map
    revmap
end
methods
    function obj=PtbMap()
        d={ ...
            'a'          ,'a';
            'b'          ,'b';
            'c'          ,'c';
            'd'          ,'d';
            'e'          ,'e';
            'f'          ,'f';
            'g'          ,'g';
            'h'          ,'h';
            'i'          ,'i';
            'j'          ,'j';
            'k'          ,'k';
            'l'          ,'l';
            'm'          ,'m';
            'n'          ,'n';
            'o'          ,'o';
            'p'          ,'p';
            'q'          ,'q';
            'r'          ,'r';
            's'          ,'s';
            't'          ,'t';
            'u'          ,'u';
            'v'          ,'v';
            'w'          ,'w';
            'x'          ,'x';
            'y'          ,'y';
            'z'          ,'z';
            '1'          ,'1';
            '2'          ,'2';
            '3'          ,'3';
            '4'          ,'4';
            '5'          ,'5';
            '6'          ,'6';
            '7'          ,'7';
            '8'          ,'8';
            '9'          ,'9';
            '0'          ,'0';
            '1'          ,'1!';
            '2'          ,'2@';
            '3'          ,'3#';
            '4'          ,'4$';
            '5'          ,'5%';
            '6'          ,'6^';
            '7'          ,'7&';
            '8'          ,'8*';
            '9'          ,'9(';
            '0'          ,'0)';
            '-'          ,'-_';
            '='          ,'=+';
            '.'          ,'.>';
            ','          ,',<';
            '['          ,'[{';
            ']'          ,']}';
            '`'          ,'`';       % NOT MAC
            '`'          ,'`~';
            '/'          ,'/?';
            ';'          ,';';       % NOT MAC
            ';'          ,';:';
            'backslash'  ,'\|';
            'backslash'  ,'\\';      % NOT MAC
            'backslash'  ,'NonUS\|';      % NOT MAC
            'enter'      ,'return';
            'enter'      ,'ENTER';
            'enter'      ,'Return';
            'escape'     ,'ESCAPE';
            'escape'     ,'Cancel';
            'pageD'      ,'PageDown';
            'pageU'      ,'PageUp';
            'insert'     ,'Insert';   % maybe OSX specific... left_shift didn't work
            'end'        ,'End';
            'home'       ,'Home';
            'menu'       ,'Menu';
            'opt'        ,'Application';
            'print'      ,'PrintScreen';
            'numLock'    ,'NumLock';
            'scrollLock' ,'scrollLock';
            'capsLock'   ,'capsLock';
            'undefined'  ,'Undefined';
            'pause'      ,'Pause';
            'volU'       ,'VolumeUp';
            'volD'       ,'VolumeDown';
            'mute'       ,'Mute';
            'find'       ,'Find';

            'shiftL'     ,'LeftShift';   % maybe OSX specific... left_shift didn't work
            'shiftR'     ,'RightShift';  % maybe OSX specific... left_shift didn't work
            'Uarrow'     ,'upArrow';     % INTERVAL 2
            'Darrow'     ,'downArrow';   % INTERVAL 1
            'Larrow'     ,'leftArrow';
            'Rarrow'     ,'rightArrow';
            'altR'       ,'RightAlt';
            'altL'       ,'LeftAlt';
            'guiR'       ,'RightGUI';
            'guiL'       ,'LeftGUI';
            'ctlL'       ,'LeftControl';
            'ctlR'       ,'RightControl';
            'space'      ,'space';
            'tab'        ,'tab';
            ''''         , '''"';
            'F1'         ,'F1';
            'F2'         ,'F2';
            'F3'         ,'F3';
            'F4'         ,'F4';
            'F5'         ,'F5';
            'F6'         ,'F6';
            'F7'         ,'F7';
            'F8'         ,'F8';
            'F9'         ,'F9';
            'F10'        ,'F10';
            'F11'        ,'F11';
            'F12'        ,'F12';
            'F13'        ,'F13';
            'F14'        ,'F14';
            'F15'        ,'F15';
            'F16'        ,'F16';
            'F17'        ,'F17';
            'F18'        ,'F18';
            'F19'        ,'F19';
            'F20'        ,'F20';
            'F21'        ,'F21';
            'F22'        ,'F22';
            'F23'        ,'F23';
            'F24'        ,'F24';
        };
        if ismac
            d2={...
                'backspace'  ,'DELETE';
                'delete'     ,'DeleteForward';
            };
        else
            d2={...
                'backspace'  ,'BackSpace';
                'delete'     ,'Delete';
            };
        end
        d=[d; d2];

        KbName('UnifyKeyNames');
        keys=cellfun(@PtbMap.KbFun,d(:,2),'UniformOutput',false);

        %nums=1:255;
        %vals=sort(cell2mat(keys));
        %nums=nums(~ismember(nums,vals));
        %numel(nums)
        %for i = 1:length(nums)
        %    disp(KbName(nums(i)));
        %end

        ind=~cellfun(@isempty,keys);

        obj.map=containers.Map(keys(ind),d(ind,1));
        obj.revmap=containers.Map(d(ind,1),keys(ind));
    end
    function keys=fromScan(obj,scan)
        % XXX handle BInd

        % ind
        keys=arrayfun(@(x) obj.map(x),scan,'UniformOutput',false);
    end
    function scan=toScan(obj,keys)
        if iscell(keys)
            scan=cellfun(@(x) obj.revmap(x),keys);
        else
            scan=obj.revmap(keys);
        end
    end
end
methods(Static,Access=private)
    function out=KbFun(x)
        try
            out=KbName(x);
            if numel(out) > 1
                out=out(1);
            end
        catch
            out=[];
        end
    end
end
end
