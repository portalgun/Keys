classdef CapsMap < handle
properties
    map
    keys
end
methods
    function obj= CapsMap()
        d={...
            'a', 'A';
            'b', 'B';
            'c', 'C';
            'd', 'D';
            'e', 'E';
            'f', 'F';
            'g', 'G';
            'h', 'H';
            'i', 'I';
            'j', 'J';
            'k', 'K';
            'l', 'L';
            'm', 'M';
            'n', 'N';
            'o', 'O';
            'p', 'P';
            'r', 'R';
            's', 'S';
            't', 'T';
            'u', 'U';
            'v', 'V';
            'w', 'W';
            'x', 'X';
            'y', 'Y';
            'z', 'Z';
            '1', '!';
            '2', '@';
            '3', '#';
            '/', '?';
            '4', '$';
            '5', '%';
            '6', '^';
            '7', '&';
            '8', '*';
            '9', '(';
            '0', ')';
            '-', '_';
            '=', '+';
            '.', '>';
            ',', '<';
            ';', ':';
            '\t', '\tS';
            '\s', '\sS';
          };
        obj.keys=d(:,1);
        %['S-' obj.chara];

        obj.map=containers.Map(d(:,1),d(:,2));
    end
    function caps=fromKeyCode(obj,keycode)
        if ~iscell(keycode)
            caps=obj.convertFun(keycode);
            return
        end
        caps=cellfun(@(x) obj.convertFun(x),keycode,'UniformOutput',false);
    end
end
methods(Access=private)
    function out=convertFun(obj,x)
        try
            out=obj.map(x);
        catch
            out=x;
        end
    end
end
end
