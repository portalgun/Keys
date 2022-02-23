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
            'enter'      ,'return';
            'escape'     ,'ESCAPE';
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
            'backspace'  ,'BackSpace'; % NOT MAC
            'backspace'  ,'DELETE';
            'delete'     ,'Delete';
            'delete'     ,'DeleteForward';
        };

        KbName('UnifyKeyNames');
        keys=cellfun(@PtbMap.KbFun,d(:,2),'UniformOutput',false);
        ind=~cellfun(@isempty,keys);

        obj.map=containers.Map(keys(ind),d(ind,1));
        obj.revmap=containers.Map(d(ind,1),keys(ind));
    end
    function keys=fromScan(obj,scan)
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
