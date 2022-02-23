classdef BasicMap < handle
properties
    map
    revmap
end
methods
    function obj=BasicMap()
        d={...
            'q',113;
            'w',119;
            'e',101;
            'r',114;
            't',116;
            'y',121;
            'u',117;
            'i',105;
            'o',111;
            'p',112;

            'Q',81;
            'W',87;
            'E',69;
            'R',82;
            'T',84;
            'Y',89;
            'U',85;
            'I',73;
            'O',79;
            'P',80;

            'a',97;
            's',115;
            'd',100;
            'f',102;
            'g',103;
            'h',104;
            'j',106;
            'k',107;
            'l',108;

            'A',65;
            'S',83;
            'D',68;
            'F',70;
            'G',71;
            'H',72;
            'J',74;
            'K',75;
            'S',76;

            'z',122;
            'x',120;
            'c',99;
            'b',98;
            'v',118;
            'b',98;
            'n',110;
            'm',109;

            'Z',90;
            'X',88;
            'C',67;
            'V',86;
            'B',66;
            'N',78;
            'M',77;

            '0', 48;
            '1', 49;
            '2', 50;
            '3' 51;
            '4', 52;
            '5', 53;
            '6', 54;
            '7',55;
            '8', 56;
            '9' , 57;

            'Larrow'  ,28;
            'Rarrow' ,29;
            'Uarrow'    ,30;
            'Darrow'  ,31;
            'escape'   ,27;
            'enter',13;
            'tab'   ,9;
            'space' ,32;
            'backspace',8;
            'delete',127;
            'backslash',39
            '?',63;
            '-',45;
            '=',61;
            '/',47;
            '[',91;
            ']',93;
            ';',59;
            ',',44;
            '.',46;
            '`',96;
            '<',60;
            '>',62;
            ':',58;

            '!',33;
            '@',64;
            '#',35;
            '$',36;
            '%',37;
            '^',94;
            '&',38;
            '*',42;
            '(',40;
            ')',41;
            '_',95;
            '+',43;
        };
        obj.map=containers.Map(d(:,2),d(:,1));
        obj.revmap=containers.Map(d(:,1),d(:,2));
    end
    function key=fromScan(obj,scan)
        key=arrayfun(@(x) obj.map(x),scan,'UniformOutput',false);
    end
    function scan=toScan(obj,keys)
        if iscell(keys)
            scan=cellfun(@(x) obj.revmap(x),keys);
        else
            scan=obj.revmap(keys);
        end
    end
end
end
